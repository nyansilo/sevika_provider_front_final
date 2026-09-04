// import 'package:dartz/dartz.dart';
// import '../../../../core/errors/app_error.dart';
// import '../entities/auth_response_entity.dart';
// import '../entities/social_provider.dart';
// import '../entities/social_auth_response_entity.dart';
// import '../usecases/params/change_password_params.dart';
// import '../usecases/params/forgot_password_params.dart';
// import '../usecases/params/login_params.dart';
// import '../usecases/params/refresh_token_params.dart';
// import '../usecases/params/register_params.dart';
// import '../usecases/params/reset_password_params.dart';
// import '../usecases/params/complete_social_registration_params.dart';
// import '../usecases/params/update_phone_params.dart';

// abstract class AuthRepository {
//   Future<Either<AppError, AuthResponseEntity>> login(LoginParams params);
//   Future<Either<AppError, AuthResponseEntity>> register(RegisterParams params);
//   Future<Either<AppError, AuthResponseEntity>> refreshToken(
//     RefreshTokenParams params,
//   );
//   Future<Either<AppError, Unit>> changePassword(ChangePasswordParams params);
//   Future<Either<AppError, Unit>> logout();
//   Future<Either<AppError, Unit>> forgotPassword(ForgotPasswordParams params);
//   Future<Either<AppError, Unit>> resetPassword(ResetPasswordParams params);

//   // 🚀 Social Flow
//   Future<Either<AppError, SocialAuthResponseEntity>> socialLogin(
//     SocialProvider provider,
//   );
//   Future<Either<AppError, SocialAuthResponseEntity>> completeSocialRegistration(
//     CompleteSocialRegistrationParams params,
//   );
//   Future<Either<AppError, AuthResponseEntity>> updatePhoneNumber(
//     UpdatePhoneParams params,
//   );
// }

import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../entities/auth_response_entity.dart';
import '../entities/social_provider.dart';
import '../entities/social_auth_response_entity.dart';
import '../usecases/params/change_password_params.dart';
import '../usecases/params/forgot_password_params.dart';
import '../usecases/params/login_params.dart';
import '../usecases/params/refresh_token_params.dart';
import '../usecases/params/register_params.dart';
import '../usecases/params/reset_password_params.dart';
import '../usecases/params/complete_social_registration_params.dart';
import '../usecases/params/update_phone_params.dart';

abstract class AuthRepository {
  Future<Either<AppError, AuthResponseEntity>> login(LoginParams params);
  Future<Either<AppError, AuthResponseEntity>> register(RegisterParams params);
  Future<Either<AppError, AuthResponseEntity>> refreshToken(
    RefreshTokenParams params,
  );
  Future<Either<AppError, Unit>> changePassword(ChangePasswordParams params);
  Future<Either<AppError, Unit>> logout();
  Future<Either<AppError, Unit>> forgotPassword(ForgotPasswordParams params);
  Future<Either<AppError, Unit>> resetPassword(ResetPasswordParams params);

  // 🚀 Social Flow
  Future<Either<AppError, SocialAuthResponseEntity>> socialLogin(
    SocialProvider provider,
  );
  Future<Either<AppError, SocialAuthResponseEntity>> completeSocialRegistration(
    CompleteSocialRegistrationParams params,
  );
  Future<Either<AppError, AuthResponseEntity>> updatePhoneNumber(
    UpdatePhoneParams params,
  );

  // 🎯 NEW: Permanent Account Deletion
  Future<Either<AppError, Unit>> deleteAccount();
}
