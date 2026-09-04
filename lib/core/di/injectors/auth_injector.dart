import 'package:get_it/get_it.dart';

import '../../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../../features/auth/data/datasources/social_auth_data_source.dart';
import '../../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../../features/auth/domain/repositories/auth_repository.dart';
import '../../../features/auth/domain/usecases/change_password_use_case.dart';
import '../../../features/auth/domain/usecases/login_use_case.dart';
import '../../../features/auth/domain/usecases/logout_use_case.dart';
import '../../../features/auth/domain/usecases/refresh_auth_token_use_case.dart';
import '../../../features/auth/domain/usecases/register_use_case.dart';

// 🚀 NEW AUTHENTICATION USE CASES IMPORTS
import '../../../features/auth/domain/usecases/social_login_usecase.dart';
import '../../../features/auth/domain/usecases/complete_social_registration_usecase.dart';
import '../../../features/auth/domain/usecases/forgot_password_usecase.dart';
import '../../../features/auth/domain/usecases/reset_password_usecase.dart';
import '../../../features/auth/domain/usecases/delete_account_use_case.dart'; // 🎯 ADDED: Permanent Deletion

// CUBITS IMPORTS
import '../../../features/auth/domain/usecases/update_phone_usecase.dart';
import '../../../features/auth/presentation/cubits/auth/auth_cubit.dart';
import '../../../features/auth/presentation/cubits/password_recovery/password_recovery_cubit.dart';

void initAuth(GetIt sl) {
  // 1. Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  // 🚀 Native Social Auth SDK Wrapper
  sl.registerLazySingleton<SocialAuthDataSource>(
    () => SocialAuthDataSourceImpl(),
  );

  // 2. Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      socialAuthDataSource: sl(), // 🚀 Injects the SDK handler
    ),
  );

  // 3. Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SocialLoginUseCase(sl())); // 🚀 Injected
  sl.registerLazySingleton(() => CompleteSocialRegistrationUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePhoneUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => RefreshAuthTokenUseCase(sl()));
  sl.registerLazySingleton(
    () => DeleteAccountUseCase(sl()),
  ); // 🎯 ADDED: Permanent Deletion

  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl())); // 🚀 Injected
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl())); // 🚀 Injected

  // 4. Cubits
  sl.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      loginUseCase: sl(),
      socialLoginUseCase: sl(), // 🚀 Connects OS UI to Use Case
      completeSocialRegistrationUseCase: sl(), // 🚀 Injected
      updatePhoneUseCase: sl(),
      registerUseCase: sl(),
      changePasswordUseCase: sl(),
      logoutUseCase: sl(),
      refreshTokenUseCase: sl(),
      authTokenManager: sl(),
      deleteAccountUseCase: sl(), // 🎯 ADDED: Injected into Cubit
      localStorageService:
          sl(), // 🎯 CRITICAL FIX: Properly inject LocalStorageService
    ),
  );

  // 🚀 Factory ensures memory is cleared when user navigates away from Recovery UI
  sl.registerFactory<PasswordRecoveryCubit>(
    () => PasswordRecoveryCubit(
      forgotPasswordUseCase: sl(),
      resetPasswordUseCase: sl(),
    ),
  );
}
