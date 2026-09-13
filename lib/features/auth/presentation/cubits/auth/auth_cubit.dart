// import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../../core/storage/auth_token_manager.dart';
// import '../../../../../core/storage/local_storage_service.dart';
// import '../../../../../core/usecases/usecase.dart';
// import '../../../../../core/errors/app_error.dart';
// import '../../../data/models/user_model.dart';
// import '../../../domain/entities/auth_response_entity.dart';
// import '../../../domain/entities/social_auth_response_entity.dart';
// import '../../../domain/entities/social_auth_status.dart';
// import '../../../domain/entities/social_provider.dart';
// import '../../../domain/entities/user_role.dart';
// import '../../../domain/usecases/login_use_case.dart';
// import '../../../domain/usecases/logout_use_case.dart';
// import '../../../domain/usecases/change_password_use_case.dart';
// import '../../../domain/usecases/params/login_params.dart';
// import '../../../domain/usecases/params/perform_social_login_params.dart';
// import '../../../domain/usecases/params/refresh_token_params.dart';
// import '../../../domain/usecases/params/register_params.dart';
// import '../../../domain/usecases/params/change_password_params.dart';
// import '../../../domain/usecases/params/complete_social_registration_params.dart';
// import '../../../domain/usecases/params/update_phone_params.dart';
// import '../../../domain/usecases/refresh_auth_token_use_case.dart';
// import '../../../domain/usecases/register_use_case.dart';
// import '../../../domain/usecases/social_login_usecase.dart';
// import '../../../domain/usecases/complete_social_registration_usecase.dart';
// import '../../../domain/usecases/update_phone_usecase.dart';
// import '../../../domain/usecases/delete_account_use_case.dart';
// import 'auth_state.dart';

// class AuthCubit extends Cubit<AuthState> {
//   final LoginUseCase loginUseCase;
//   final SocialLoginUseCase socialLoginUseCase;
//   final CompleteSocialRegistrationUseCase completeSocialRegistrationUseCase;
//   final RegisterUseCase registerUseCase;
//   final ChangePasswordUseCase changePasswordUseCase;
//   final LogoutUseCase logoutUseCase;
//   final RefreshAuthTokenUseCase refreshTokenUseCase;
//   final AuthTokenManager authTokenManager;
//   final UpdatePhoneUseCase updatePhoneUseCase;
//   final DeleteAccountUseCase deleteAccountUseCase;
//   final LocalStorageService localStorageService;

//   AuthCubit({
//     required this.loginUseCase,
//     required this.socialLoginUseCase,
//     required this.completeSocialRegistrationUseCase,
//     required this.registerUseCase,
//     required this.changePasswordUseCase,
//     required this.logoutUseCase,
//     required this.refreshTokenUseCase,
//     required this.authTokenManager,
//     required this.updatePhoneUseCase,
//     required this.deleteAccountUseCase,
//     required this.localStorageService,
//   }) : super(const AuthInitial()) {
//     checkAuth();
//   }

//   Future<void> login(LoginParams params) async {
//     emit(const AuthLoading());
//     final result = await loginUseCase.call(params);
//     result.fold(
//       (error) => emit(AuthError(error)),
//       (authResponseEntity) => _handleAuthSuccess(authResponseEntity),
//     );
//   }

//   Future<void> submitPhoneNumber(String phoneNumber) async {
//     emit(const AuthLoading());

//     final result = await updatePhoneUseCase.call(
//       UpdatePhoneParams(phoneNumber: phoneNumber),
//     );

//     result.fold(
//       (error) => emit(AuthError(error)),
//       (authResponseEntity) => _handleAuthSuccess(authResponseEntity),
//     );
//   }

//   Future<void> socialLogin(SocialProvider provider) async {
//     emit(const AuthLoading());
//     final result = await socialLoginUseCase.call(
//       PerformSocialLoginParams(provider),
//     );
//     result.fold((error) {
//       if (error.type == AppErrorType.cancelled) {
//         emit(const AuthInitial());
//       } else {
//         emit(AuthError(error));
//       }
//     }, (resultEntity) => _handleSocialFlow(resultEntity));
//   }

//   Future<void> completeSocialRegistration({
//     required String tempToken,
//     required String email,
//     String? password,
//   }) async {
//     emit(const AuthLoading());
//     final result = await completeSocialRegistrationUseCase.call(
//       CompleteSocialRegistrationParams(
//         tempToken: tempToken,
//         email: email,
//         password: password,
//       ),
//     );

//     result.fold((error) {
//       if (error.type == AppErrorType.socialAuthPasswordRequired) {
//         emit(
//           AuthRequiresPassword(
//             tempToken: tempToken,
//             email: email,
//             message: error.message ?? 'Please enter your password.',
//           ),
//         );
//       } else {
//         emit(AuthError(error));
//       }
//     }, (resultEntity) => _handleSocialFlow(resultEntity, currentEmail: email));
//   }

//   void cancelSocialFlow() {
//     emit(const AuthInitial());
//   }

//   void _handleSocialFlow(
//     SocialAuthResponseEntity entity, {
//     String? currentEmail,
//   }) {
//     if (entity.status == SocialAuthStatus.requiresEmail) {
//       emit(
//         AuthRequiresEmail(
//           tempToken: entity.tempToken!,
//           message: entity.message ?? 'Please provide your email.',
//         ),
//       );
//     } else if (entity.status == SocialAuthStatus.passwordRequired) {
//       emit(
//         AuthRequiresPassword(
//           tempToken: entity.tempToken!,
//           email: currentEmail!,
//           message: entity.message ?? 'Please enter your password.',
//         ),
//       );
//     } else if (entity.status == SocialAuthStatus.success &&
//         entity.authData != null) {
//       _handleAuthSuccess(entity.authData!);
//     }
//   }

//   Future<void> register(RegisterParams params) async {
//     emit(const AuthLoading());
//     final result = await registerUseCase.call(params);

//     result.fold(
//       (error) => emit(AuthError(error)),
//       (authResponseEntity) => _handleAuthSuccess(authResponseEntity),
//     );
//   }

//   /// 🎯 INITIAL INITIALIZATION AUTH CHECK ON APP START / HOT RESTART
//   Future<void> checkAuth() async {
//     emit(const AuthChecking());
//     try {
//       final token = await authTokenManager.getAccessToken();
//       final roleString = await authTokenManager.getUserRole();
//       final role = UserRole.fromString(roleString);

//       final cachedUserString = await authTokenManager.getCachedUser();

//       // 👨‍🔧 STRICTLY ENFORCE PROVIDER ROLE ON COLD BOOT
//       if (token == null ||
//           token.isEmpty ||
//           role != UserRole.provider ||
//           cachedUserString == null) {
//         await authTokenManager.clearTokens();
//         emit(const AuthUnauthenticated());
//         return;
//       }

//       final Map<String, dynamic> userMap = jsonDecode(cachedUserString);
//       final cachedUser = UserModel.fromJson(userMap);

//       emit(AuthAuthenticated(user: cachedUser));
//     } catch (e) {
//       debugPrint('Auth Check Failed: $e');
//       await authTokenManager.clearTokens();
//       emit(const AuthUnauthenticated());
//     }
//   }

//   Future<void> changePassword(ChangePasswordParams params) async {
//     if (state is! AuthAuthenticated) return;
//     final currentUser = (state as AuthAuthenticated).user;

//     emit(AuthAuthenticated(user: currentUser, isLoading: true));

//     final result = await changePasswordUseCase.call(params);

//     result.fold(
//       (error) => emit(
//         AuthAuthenticated(user: currentUser, error: error, isLoading: false),
//       ),
//       (_) {
//         emit(
//           AuthAuthenticated(
//             user: currentUser,
//             successMessage: 'Your password has been changed successfully!',
//             isLoading: false,
//           ),
//         );
//       },
//     );
//   }

//   Future<void> refreshToken() async {
//     final savedRefreshToken = await authTokenManager.getRefreshToken();

//     if (savedRefreshToken == null || savedRefreshToken.isEmpty) {
//       emit(const AuthUnauthenticated());
//       return;
//     }

//     final result = await refreshTokenUseCase.call(
//       RefreshTokenParams(refreshToken: savedRefreshToken),
//     );

//     result.fold((error) async {
//       await authTokenManager.clearTokens();
//       emit(AuthError(error));
//       emit(const AuthUnauthenticated());
//     }, (authResponseEntity) => _handleAuthSuccess(authResponseEntity));
//   }

//   Future<void> logout() async {
//     if (state is AuthLoading || state is AuthUnauthenticated) return;

//     emit(const AuthLoading());
//     final result = await logoutUseCase.call(const NoParams());

//     result.fold((error) => emit(AuthError(error)), (_) async {
//       await authTokenManager.clearTokens();
//       emit(const AuthUnauthenticated());
//     });
//   }

//   Future<void> deleteAccount() async {
//     if (state is! AuthAuthenticated) return;

//     final currentUser = (state as AuthAuthenticated).user;
//     emit(AuthAuthenticated(user: currentUser, isLoading: true));

//     final result = await deleteAccountUseCase.call(const NoParams());

//     result.fold(
//       (error) {
//         emit(
//           AuthAuthenticated(user: currentUser, error: error, isLoading: false),
//         );
//       },
//       (_) async {
//         await authTokenManager.clearTokens();
//         emit(
//           const AuthUnauthenticated(
//             message: 'Your account and all associated data have been permanently deleted.',
//           ),
//         );
//       },
//     );
//   }

//   Future<void> forceUnauthenticated() async {
//     debugPrint(
//       '🧹 AuthCubit: Executing hard secure storage token purge via eviction requested by interceptor.',
//     );
//     await authTokenManager.clearTokens();
//     emit(const AuthUnauthenticated());
//   }

//   /// 🎯 Helper handling successful Provider identity persistence
//   Future<void> _handleAuthSuccess(AuthResponseEntity entity) async {
//     // 👨‍🔧 STRICT GATEKEEPING: Ensure only Providers can log into this app!
//     if (entity.user.role == UserRole.provider) {
//       await authTokenManager.saveAccessToken(entity.accessToken);
//       await authTokenManager.saveRefreshToken(entity.refreshToken);
//       await authTokenManager.saveUserRole(entity.user.role.name);

//       await localStorageService.setBool(
//         'notifications_enabled_cache',
//         entity.user.pushNotificationsEnabled,
//       );

//       final userModelToCache = UserModel(
//         userId: entity.user.userId,
//         firstName: entity.user.firstName,
//         lastName: entity.user.lastName,
//         phoneNumber: entity.user.phoneNumber,
//         email: entity.user.email,
//         role: entity.user.role,
//         profileImage: entity.user.profileImage,
//         pushNotificationsEnabled: entity.user.pushNotificationsEnabled,
//         kycStatus: '',
//         isKycApproved: null,
//       );

//       final userJsonString = jsonEncode(userModelToCache.toJson());
//       await authTokenManager.saveCachedUser(userJsonString);

//       if (entity.user.phoneNumber.startsWith('SOCIAL_')) {
//         emit(AuthRequiresPhoneNumber(user: entity.user));
//       } else {
//         emit(AuthAuthenticated(user: entity.user));
//       }
//     } else {
//       await _handleInvalidRoleAccess();
//     }
//   }

//   Future<void> _handleInvalidRoleAccess() async {
//     await authTokenManager.clearTokens();
//     emit(
//       const AuthError(
//         AppError(
//           AppErrorType.forbidden,
//           message: 'This account is registered as a Customer. Please download the Customer App to log in.', // 👨‍🔧 Updated error message
//           statusCode: 403,
//         ),
//       ),
//     );
//     await Future.delayed(const Duration(milliseconds: 100));
//     emit(const AuthUnauthenticated());
//   }
// }

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/storage/auth_token_manager.dart';
import '../../../../../core/storage/local_storage_service.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/errors/app_error.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/entities/auth_response_entity.dart';
import '../../../domain/entities/social_auth_response_entity.dart';
import '../../../domain/entities/social_auth_status.dart';
import '../../../domain/entities/social_provider.dart';
import '../../../domain/entities/user_role.dart';
import '../../../domain/usecases/login_use_case.dart';
import '../../../domain/usecases/logout_use_case.dart';
import '../../../domain/usecases/change_password_use_case.dart';
import '../../../domain/usecases/params/login_params.dart';
import '../../../domain/usecases/params/perform_social_login_params.dart';
import '../../../domain/usecases/params/refresh_token_params.dart';
import '../../../domain/usecases/params/register_params.dart';
import '../../../domain/usecases/params/change_password_params.dart';
import '../../../domain/usecases/params/complete_social_registration_params.dart';
import '../../../domain/usecases/params/update_phone_params.dart';
import '../../../domain/usecases/refresh_auth_token_use_case.dart';
import '../../../domain/usecases/register_use_case.dart';
import '../../../domain/usecases/social_login_usecase.dart';
import '../../../domain/usecases/complete_social_registration_usecase.dart';
import '../../../domain/usecases/update_phone_usecase.dart';
import '../../../domain/usecases/delete_account_use_case.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final SocialLoginUseCase socialLoginUseCase;
  final CompleteSocialRegistrationUseCase completeSocialRegistrationUseCase;
  final RegisterUseCase registerUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final LogoutUseCase logoutUseCase;
  final RefreshAuthTokenUseCase refreshTokenUseCase;
  final AuthTokenManager authTokenManager;
  final UpdatePhoneUseCase updatePhoneUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final LocalStorageService localStorageService;

  AuthCubit({
    required this.loginUseCase,
    required this.socialLoginUseCase,
    required this.completeSocialRegistrationUseCase,
    required this.registerUseCase,
    required this.changePasswordUseCase,
    required this.logoutUseCase,
    required this.refreshTokenUseCase,
    required this.authTokenManager,
    required this.updatePhoneUseCase,
    required this.deleteAccountUseCase,
    required this.localStorageService,
  }) : super(const AuthInitial()) {
    checkAuth();
  }

  Future<void> login(LoginParams params) async {
    emit(const AuthLoading());
    final result = await loginUseCase.call(params);
    result.fold(
      (error) => emit(AuthError(error)),
      (authResponseEntity) => _handleAuthSuccess(authResponseEntity),
    );
  }

  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(const AuthLoading());
    final result = await updatePhoneUseCase.call(
      UpdatePhoneParams(phoneNumber: phoneNumber),
    );
    result.fold(
      (error) => emit(AuthError(error)),
      (authResponseEntity) => _handleAuthSuccess(authResponseEntity),
    );
  }

  Future<void> socialLogin(SocialProvider provider) async {
    emit(const AuthLoading());
    final result = await socialLoginUseCase.call(
      PerformSocialLoginParams(provider),
    );
    result.fold((error) {
      if (error.type == AppErrorType.cancelled) {
        emit(const AuthInitial());
      } else {
        emit(AuthError(error));
      }
    }, (resultEntity) => _handleSocialFlow(resultEntity));
  }

  Future<void> completeSocialRegistration({
    required String tempToken,
    required String email,
    String? password,
  }) async {
    emit(const AuthLoading());
    final result = await completeSocialRegistrationUseCase.call(
      CompleteSocialRegistrationParams(
        tempToken: tempToken,
        email: email,
        password: password,
      ),
    );

    result.fold((error) {
      if (error.type == AppErrorType.socialAuthPasswordRequired) {
        emit(
          AuthRequiresPassword(
            tempToken: tempToken,
            email: email,
            message: error.message ?? 'Please enter your password.',
          ),
        );
      } else {
        emit(AuthError(error));
      }
    }, (resultEntity) => _handleSocialFlow(resultEntity, currentEmail: email));
  }

  void cancelSocialFlow() {
    emit(const AuthInitial());
  }

  void _handleSocialFlow(
    SocialAuthResponseEntity entity, {
    String? currentEmail,
  }) {
    if (entity.status == SocialAuthStatus.requiresEmail) {
      emit(
        AuthRequiresEmail(
          tempToken: entity.tempToken!,
          message: entity.message ?? 'Please provide your email.',
        ),
      );
    } else if (entity.status == SocialAuthStatus.passwordRequired) {
      emit(
        AuthRequiresPassword(
          tempToken: entity.tempToken!,
          email: currentEmail!,
          message: entity.message ?? 'Please enter your password.',
        ),
      );
    } else if (entity.status == SocialAuthStatus.success &&
        entity.authData != null) {
      _handleAuthSuccess(entity.authData!);
    }
  }

  Future<void> register(RegisterParams params) async {
    emit(const AuthLoading());
    final result = await registerUseCase.call(params);
    result.fold(
      (error) => emit(AuthError(error)),
      (authResponseEntity) => _handleAuthSuccess(authResponseEntity),
    );
  }

  Future<void> checkAuth() async {
    emit(const AuthChecking());
    try {
      final token = await authTokenManager.getAccessToken();
      final roleString = await authTokenManager.getUserRole();
      final role = UserRole.fromString(roleString);

      final cachedUserString = await authTokenManager.getCachedUser();

      if (token == null ||
          token.isEmpty ||
          role != UserRole.provider ||
          cachedUserString == null) {
        await authTokenManager.clearTokens();
        emit(const AuthUnauthenticated());
        return;
      }

      final Map<String, dynamic> userMap = jsonDecode(cachedUserString);
      final cachedUser = UserModel.fromJson(userMap);

      emit(AuthAuthenticated(user: cachedUser));
    } catch (e) {
      debugPrint('Auth Check Failed: $e');
      await authTokenManager.clearTokens();
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> changePassword(ChangePasswordParams params) async {
    if (state is! AuthAuthenticated) return;
    final currentUser = (state as AuthAuthenticated).user;
    emit(AuthAuthenticated(user: currentUser, isLoading: true));

    final result = await changePasswordUseCase.call(params);

    result.fold(
      (error) => emit(
        AuthAuthenticated(user: currentUser, error: error, isLoading: false),
      ),
      (_) {
        emit(
          AuthAuthenticated(
            user: currentUser,
            successMessage: 'Your password has been changed successfully!',
            isLoading: false,
          ),
        );
      },
    );
  }

  Future<void> refreshToken() async {
    final savedRefreshToken = await authTokenManager.getRefreshToken();

    if (savedRefreshToken == null || savedRefreshToken.isEmpty) {
      emit(const AuthUnauthenticated());
      return;
    }

    final result = await refreshTokenUseCase.call(
      RefreshTokenParams(refreshToken: savedRefreshToken),
    );

    result.fold((error) async {
      await authTokenManager.clearTokens();
      emit(AuthError(error));
      emit(const AuthUnauthenticated());
    }, (authResponseEntity) => _handleAuthSuccess(authResponseEntity));
  }

  Future<void> logout() async {
    if (state is AuthLoading || state is AuthUnauthenticated) return;

    emit(const AuthLoading());
    final result = await logoutUseCase.call(const NoParams());

    result.fold((error) => emit(AuthError(error)), (_) async {
      await authTokenManager.clearTokens();
      emit(const AuthUnauthenticated());
    });
  }

  Future<void> deleteAccount() async {
    if (state is! AuthAuthenticated) return;

    final currentUser = (state as AuthAuthenticated).user;
    emit(AuthAuthenticated(user: currentUser, isLoading: true));

    final result = await deleteAccountUseCase.call(const NoParams());

    result.fold(
      (error) {
        emit(
          AuthAuthenticated(user: currentUser, error: error, isLoading: false),
        );
      },
      (_) async {
        await authTokenManager.clearTokens();
        emit(
          const AuthUnauthenticated(
            message: 'Your account and all associated data have been permanently deleted.',
          ),
        );
      },
    );
  }

  Future<void> forceUnauthenticated() async {
    await authTokenManager.clearTokens();
    emit(const AuthUnauthenticated());
  }

  Future<void> _handleAuthSuccess(AuthResponseEntity entity) async {
    if (entity.user.role == UserRole.provider) {
      await authTokenManager.saveAccessToken(entity.accessToken);
      await authTokenManager.saveRefreshToken(entity.refreshToken);
      await authTokenManager.saveUserRole(entity.user.role.name);

      await localStorageService.setBool(
        'notifications_enabled_cache',
        entity.user.pushNotificationsEnabled,
      );

      // 🚀 CACHE UPDATE: Ensure KYC data persists locally
      final userModelToCache = UserModel(
        userId: entity.user.userId,
        firstName: entity.user.firstName,
        lastName: entity.user.lastName,
        phoneNumber: entity.user.phoneNumber,
        email: entity.user.email,
        role: entity.user.role,
        profileImage: entity.user.profileImage,
        pushNotificationsEnabled: entity.user.pushNotificationsEnabled,
        kycStatus: entity.user.kycStatus, // 🎯 Safely store current values
        kycTier: entity.user.kycTier,
        isKycApproved: entity.user.isKycApproved,
      );

      final userJsonString = jsonEncode(userModelToCache.toJson());
      await authTokenManager.saveCachedUser(userJsonString);

      if (entity.user.phoneNumber.startsWith('SOCIAL_')) {
        emit(AuthRequiresPhoneNumber(user: entity.user));
      } else {
        emit(AuthAuthenticated(user: entity.user));
      }
    } else {
      await _handleInvalidRoleAccess();
    }
  }

  Future<void> _handleInvalidRoleAccess() async {
    await authTokenManager.clearTokens();
    emit(
      const AuthError(
        AppError(
          AppErrorType.forbidden,
          message: 'This account is registered as a Customer. Please download the Customer App to log in.',
          statusCode: 403,
        ),
      ),
    );
    await Future.delayed(const Duration(milliseconds: 100));
    emit(const AuthUnauthenticated());
  }
}
