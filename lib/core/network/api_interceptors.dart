import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';

import '../../features/auth/domain/entities/user_role.dart';
import '../../features/auth/domain/usecases/params/refresh_token_params.dart';
import '../../features/auth/domain/usecases/refresh_auth_token_use_case.dart';
import '../../features/auth/presentation/cubits/auth/auth_cubit.dart';
import '../../features/auth/presentation/cubits/auth/auth_state.dart';
import '../../features/notification/presentation/cubits/notification/notifications_cubit.dart';
import '../constants/api_endpoints.dart';
import '../di/service_locator.dart';
import '../storage/auth_token_manager.dart';
import '../usecases/usecase.dart';

class LoggerInterceptor extends Interceptor {
  final Logger logger = Logger(
    printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
  );

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    logger.e('${options.method} request ==> $requestPath');
    logger.d('Error type: ${err.error} \n Error message: ${err.message}');
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    logger.i('${options.method} request ==> $requestPath');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(
      'STATUSCODE: ${response.statusCode} \n '
      'STATUSMESSAGE: ${response.statusMessage} \n'
      'HEADERS: ${response.headers} \n'
      'Data: ${response.data}',
    );
    handler.next(response);
  }
}

// =============================================================================
// 1️⃣ AUTHORIZATION INTERCEPTOR (With Local Ghost State Block Validation)
// =============================================================================
class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 🎯 CLEANUP FIX: Initialize dependencies and tokens ONCE at the top
    final tokenManager = sl<AuthTokenManager>();
    final token = await tokenManager.getAccessToken();

    final bootstrapOrPublicPaths = [
      ApiEndpoints.login,
      ApiEndpoints.socialLogin,
      ApiEndpoints.register,
      ApiEndpoints.forgotPassword,
      ApiEndpoints.resetPassword,
      ApiEndpoints.completeSocialRegistration,
      ApiEndpoints.verifyOtp,
      ApiEndpoints.locationsBoundaries,
      ApiEndpoints.broadcastingAuth,
      ApiEndpoints.logout,
      ApiEndpoints
          .refreshToken, // 🎯 Ghost state ignores refresh token endpoint
    ];

    final isPublicOrBootstrapRoute = bootstrapOrPublicPaths.any(
      (path) => options.path.endsWith(path),
    );

    // 1. Allow pure public routes to slide past
    if (isPublicOrBootstrapRoute) {
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    }

    // 2. Load device state profile keys explicitly for secured routes
    final roleString = await tokenManager.getUserRole();
    final role = UserRole.fromString(roleString);

    // 3. Check for empty token slots
    if (token == null || token.isEmpty) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error:
              'Authentication details missing on local device secure storage.',
          type: DioExceptionType.cancel,
        ),
      );
    }

    // 4. Ghost State Check for cold reboots
    final authCubit = sl<AuthCubit>();
    final authState = authCubit.state;

    if (authState is AuthAuthenticated && authState.user.userId.isEmpty) {
      if (!options.path.endsWith(ApiEndpoints.profile)) {
        return handler.reject(
          DioException(
            requestOptions: options,
            error: 'Feature synchronization deferred during cold boot state verification routing.',
            type: DioExceptionType.cancel,
          ),
        );
      }
    }

    // 5. 👨‍🔧 STRICT PROVIDER ENFORCEMENT
    // Only allow verified Providers to make authenticated requests in this app.
    if (role == UserRole.provider) {
      options.headers['Authorization'] = 'Bearer $token';
      return handler.next(options);
    }

    return handler.reject(
      DioException(
        requestOptions: options,
        error: 'Authentication credentials missing or local session role is uninitialized.',
        type: DioExceptionType.cancel,
      ),
    );
  }
}

// =============================================================================
// 2️⃣ REFRESH TOKEN INTERCEPTOR (Atomic Lock-Tight Eviction Guard)
// =============================================================================
class RefreshTokenInterceptor extends Interceptor {
  final Dio dio;
  RefreshTokenInterceptor(this.dio);

  static Future<void>? _refreshFuture;
  static bool _isEvicting = false;

  // Centralized check to capture variations of backend rejection
  bool _isUnauthorized(int? statusCode, dynamic data) {
    return statusCode == 401 ||
        (data is Map && data['message'] == 'Unauthenticated.') ||
        (statusCode == 404 &&
            data?.toString().toLowerCase().contains('user not found') == true);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // 🎯 Catch 401s that sneak through Dio's validateStatus into onResponse
    if (_isUnauthorized(response.statusCode, response.data)) {
      try {
        final resolvedResponse = await _processUnauthorizedFlow(
          response.requestOptions,
        );
        return handler.next(resolvedResponse);
      } catch (e) {
        return handler.reject(
          e is DioException
              ? e
              : DioException(requestOptions: response.requestOptions, error: e),
        );
      }
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Standard catch for 401s that correctly trigger DioException
    if (_isUnauthorized(err.response?.statusCode, err.response?.data)) {
      try {
        final resolvedResponse = await _processUnauthorizedFlow(
          err.requestOptions,
        );
        return handler.resolve(resolvedResponse);
      } catch (e) {
        return handler.reject(
          e is DioException
              ? e
              : DioException(requestOptions: err.requestOptions, error: e),
        );
      }
    }
    return handler.next(err);
  }

  Future<Response<dynamic>> _processUnauthorizedFlow(
    RequestOptions requestOptions,
  ) async {
    if (requestOptions.extra['isRetry'] == true) {
      throw DioException(
        requestOptions: requestOptions,
        error: 'Retry cycle failed.',
      );
    }

    if (_isEvicting) {
      throw DioException(
        requestOptions: requestOptions,
        error: 'Session eviction already in progress. Request terminated.',
        type: DioExceptionType.cancel,
      );
    }

    try {
      _refreshFuture ??= _performTokenRefresh();
      await _refreshFuture;

      return await _retry(requestOptions);
    } catch (refreshError) {
      if (_isEvicting) {
        throw DioException(
          requestOptions: requestOptions,
          error: 'Session eviction already in progress. Request terminated.',
          type: DioExceptionType.cancel,
        );
      }
      _isEvicting = true;

      debugPrint('🚨 Session recovery failed. Executing atomic token purge...');

      // 1. Wipe device secure token slots
      await sl<AuthTokenManager>().clearTokens();

      // 2. Sever background socket instances
      try {
        sl<NotificationsCubit>().disconnectLiveNotificationsUseCase.call(
          const NoParams(),
        );
      } catch (e) {
        debugPrint('⚠️ WebSocket disposal hook failed: $e');
      }

      // 3. Fire state change EXACTLY ONCE
      await sl<AuthCubit>().forceUnauthenticated();

      // Keep the gate locked while the animation screens transition
      Future.delayed(const Duration(seconds: 4), () {
        _isEvicting = false;
      });

      throw DioException(
        requestOptions: requestOptions,
        error: 'Session expired due to database eviction tracking rules.',
        type: DioExceptionType.cancel,
      );
    } finally {
      _refreshFuture = null;
    }
  }

  Future<void> _performTokenRefresh() async {
    final tokenManager = sl<AuthTokenManager>();
    final savedRefreshToken = await tokenManager.getRefreshToken();

    if (savedRefreshToken == null || savedRefreshToken.isEmpty) {
      throw DioException(
        requestOptions: RequestOptions(path: ''),
        error: 'No refresh token available on disk.',
      );
    }

    final result = await sl<RefreshAuthTokenUseCase>()(
      RefreshTokenParams(refreshToken: savedRefreshToken),
    );

    await result.fold((failure) => throw failure, (authResponseEntity) async {
      // 👨‍🔧 STRICT GATEKEEPING ON REFRESH
      if (authResponseEntity.user.role == UserRole.provider) {
        await tokenManager.saveAccessToken(authResponseEntity.accessToken);
        await tokenManager.saveRefreshToken(authResponseEntity.refreshToken);
        await tokenManager.saveUserRole(authResponseEntity.user.role.name);
      } else {
        throw Exception("Invalid token rotation context role mismatch.");
      }
    });
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final token = await sl<AuthTokenManager>().getAccessToken();

    final Map<String, dynamic> updatedHeaders = Map.from(
      requestOptions.headers,
    );
    if (token != null && token.isNotEmpty) {
      updatedHeaders['Authorization'] = 'Bearer $token';
    }

    requestOptions.headers = updatedHeaders;
    requestOptions.extra['isRetry'] = true;

    return dio.fetch(requestOptions);
  }
}

// =============================================================================
// 3️⃣ JSON RESPONSE CHECKER INTERCEPTOR
// =============================================================================
class JsonResponseCheckerInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode != 204 &&
        response.data != null &&
        response.data is! Map &&
        response.data is! List) {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          error: 'Response is not valid JSON (Map or List expected)',
          response: response,
          type: DioExceptionType.badResponse,
        ),
      );
    } else {
      handler.next(response);
    }
  }
}
