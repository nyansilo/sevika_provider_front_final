import 'package:dio/dio.dart';

import '../constants/api_endpoints.dart';
import '/core/network/api_interceptors.dart';

import '../errors/app_exception.dart';
import '../errors/error_handler.dart';
import '../errors/error_messages.dart';
import 'network_info.dart';

class DioClient {
  late final Dio _dio;
  final NetworkInfo _networkInfo;

  DioClient(this._networkInfo) {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        headers: {
          'Accept': 'application/json',
          'Content-Type': Headers.jsonContentType,
        },
        connectTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        responseType: ResponseType.json,

        /// 🚀 FIXED: Allow status codes up to 499 (including 400 and 422) to progress without crashing.
        /// This lets your data stream hand the raw Laravel error array over to your ErrorHandler.
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    _dio.interceptors.clear();

    _dio.interceptors.addAll([
      AuthorizationInterceptor(),
      RefreshTokenInterceptor(_dio),
      JsonResponseCheckerInterceptor(),
      LoggerInterceptor(),
    ]);
  }

  /// Helper to enforce connectivity checks and map platform exceptions safely
  Future<Response<T>> _performRequest<T>(
    Future<Response<T>> Function() request,
  ) async {
    if (!await _networkInfo.isConnected) {
      throw AppException(message: ErrorMessages.noInternet);
    }

    try {
      final response = await request();

      // If it's a 4xx validation/client error code, build a structured exception
      if (response.statusCode != null && response.statusCode! >= 400) {
        final appError = await ErrorHandler.handle(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
          ),
        );

        throw AppException(
          message: appError.message ?? ErrorMessages.unknown,
          statusCode: appError.statusCode,
          type: appError.type, // 🚀 CRITICAL: Pass the parsed type
          validationErrors: appError
              .validationErrors, // 🚀 CRITICAL: Pass validationErrors map
        );
      }

      return response;
    } on AppException {
      rethrow; // 🚀 DO NOT allow already formatted AppExceptions to fall into generic blocks
    } on DioException catch (e) {
      final appError = await ErrorHandler.handle(e);
      throw AppException(
        message: appError.message ?? ErrorMessages.unknown,
        statusCode: appError.statusCode,
        type: appError.type,
        validationErrors: appError.validationErrors,
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  // GET METHOD
  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _performRequest(
      () => _dio.get<T>(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  // POST METHOD
  Future<Response<T>> post<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _performRequest(
      () => _dio.post<T>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  // PUT METHOD
  Future<Response<T>> put<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _performRequest(
      () => _dio.put<T>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  // PATCH METHOD
  Future<Response<T>> patch<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _performRequest(
      () => _dio.patch<T>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  // DELETE METHOD
  Future<Response<T>> delete<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _performRequest(
      () => _dio.delete<T>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }
}
