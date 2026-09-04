// import 'package:dartz/dartz.dart';
// import '../../../../core/errors/app_error.dart';
// import '../entities/auth_response_entity.dart';
// import '../entities/user_entity.dart';
// import '../usecases/params/change_password_params.dart'; // 🚀 ADDED: Typed change password params
// import '../usecases/params/login_params.dart';
// import '../usecases/params/refresh_token_params.dart';
// import '../usecases/params/register_params.dart';
// import '../usecases/params/update_profile_params.dart';

// abstract class AuthRepositoryOld {
//   /// Authenticates a customer using their credentials and returns their auth tokens.
//   Future<Either<AppError, AuthResponseEntity>> login(LoginParams params);

//   /// Registers a new customer into the marketplace system.
//   Future<Either<AppError, AuthResponseEntity>> register(RegisterParams params);

//   /// Retrieves the current customer profile data.
//   Future<Either<AppError, UserEntity>> getCurrentUser();

//   /// Modifies details of an active profile across remote data systems.
//   Future<Either<AppError, UserEntity>> updateProfile(
//     UpdateProfileParams params,
//   );

//   /// 🔐 ADDED: Mutates security keys for the authenticated entity domain context.
//   Future<Either<AppError, Unit>> changePassword(ChangePasswordParams params);

//   /// Rotates an expired session access token using a valid refresh token.
//   Future<Either<AppError, AuthResponseEntity>> refreshToken(
//     RefreshTokenParams params,
//   );

//   /// Invalidates the current user session across remote servers and local storage.
//   // 🚀 CLEANED: Signed to return explicit type-safe Unit instead of standard keyword void
//   Future<Either<AppError, Unit>> logout();
// }
