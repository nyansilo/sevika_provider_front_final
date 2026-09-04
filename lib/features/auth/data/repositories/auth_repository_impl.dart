// import 'package:dartz/dartz.dart';
// import '../../../../core/errors/app_error.dart';
// import '../../../../core/errors/error_handler.dart';
// import '../../domain/repositories/auth_repository.dart';
// import '../../domain/entities/auth_response_entity.dart';
// import '../../domain/entities/social_provider.dart';
// import '../../domain/entities/social_auth_response_entity.dart';
// import '../../domain/usecases/params/change_password_params.dart';
// import '../../domain/usecases/params/forgot_password_params.dart';
// import '../../domain/usecases/params/login_params.dart';
// import '../../domain/usecases/params/refresh_token_params.dart';
// import '../../domain/usecases/params/register_params.dart';
// import '../../domain/usecases/params/reset_password_params.dart';
// import '../../domain/usecases/params/complete_social_registration_params.dart';
// import '../../domain/usecases/params/update_phone_params.dart';
// import '../datasources/auth_remote_data_source.dart';
// import '../datasources/social_auth_data_source.dart';
// import '../models/social_login_request_model.dart';

// class AuthRepositoryImpl implements AuthRepository {
//   final AuthRemoteDataSource remoteDataSource;
//   final SocialAuthDataSource socialAuthDataSource;

//   AuthRepositoryImpl({
//     required this.remoteDataSource,
//     required this.socialAuthDataSource,
//   });

//   @override
//   Future<Either<AppError, AuthResponseEntity>> login(LoginParams params) async {
//     try {
//       final model = await remoteDataSource.login(params);
//       return Right(model.toEntity());
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, AuthResponseEntity>> register(
//     RegisterParams params,
//   ) async {
//     try {
//       final model = await remoteDataSource.register(params);
//       return Right(model.toEntity());
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, AuthResponseEntity>> refreshToken(
//     RefreshTokenParams params,
//   ) async {
//     try {
//       final model = await remoteDataSource.refreshAuthToken(params);
//       return Right(model.toEntity());
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, Unit>> changePassword(
//     ChangePasswordParams params,
//   ) async {
//     try {
//       await remoteDataSource.changePassword(params);
//       return const Right(unit);
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, Unit>> logout() async {
//     try {
//       await socialAuthDataSource.logout();
//       await remoteDataSource.logout();
//       return const Right(unit);
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, Unit>> forgotPassword(
//     ForgotPasswordParams params,
//   ) async {
//     try {
//       await remoteDataSource.forgotPassword(params);
//       return const Right(unit);
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, Unit>> resetPassword(
//     ResetPasswordParams params,
//   ) async {
//     try {
//       await remoteDataSource.resetPassword(params);
//       return const Right(unit);
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, SocialAuthResponseEntity>> socialLogin(
//     SocialProvider provider,
//   ) async {
//     try {
//       final socialAuthModel = await socialAuthDataSource.authenticate(provider);
//       final requestModel = SocialLoginRequestModel(
//         socialProvider: provider.name,
//         token: socialAuthModel.token,
//         firstName: socialAuthModel.firstName,
//         lastName: socialAuthModel.lastName,
//       );
//       final networkModel = await remoteDataSource.socialLogin(requestModel);
//       return Right(networkModel);
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, SocialAuthResponseEntity>> completeSocialRegistration(
//     CompleteSocialRegistrationParams params,
//   ) async {
//     try {
//       final networkModel = await remoteDataSource.completeSocialRegistration(
//         params,
//       );
//       return Right(networkModel);
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, AuthResponseEntity>> updatePhoneNumber(
//     UpdatePhoneParams params,
//   ) async {
//     try {
//       final model = await remoteDataSource.updatePhoneNumber(params);
//       return Right(model.toEntity());
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }
// }

import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_handler.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/auth_response_entity.dart';
import '../../domain/entities/social_provider.dart';
import '../../domain/entities/social_auth_response_entity.dart';
import '../../domain/usecases/params/change_password_params.dart';
import '../../domain/usecases/params/forgot_password_params.dart';
import '../../domain/usecases/params/login_params.dart';
import '../../domain/usecases/params/refresh_token_params.dart';
import '../../domain/usecases/params/register_params.dart';
import '../../domain/usecases/params/reset_password_params.dart';
import '../../domain/usecases/params/complete_social_registration_params.dart';
import '../../domain/usecases/params/update_phone_params.dart';
import '../datasources/auth_remote_data_source.dart';
import '../datasources/social_auth_data_source.dart';
import '../models/social_login_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SocialAuthDataSource socialAuthDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.socialAuthDataSource,
  });

  @override
  Future<Either<AppError, AuthResponseEntity>> login(LoginParams params) async {
    try {
      final model = await remoteDataSource.login(params);
      return Right(model.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, AuthResponseEntity>> register(
    RegisterParams params,
  ) async {
    try {
      final model = await remoteDataSource.register(params);
      return Right(model.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, AuthResponseEntity>> refreshToken(
    RefreshTokenParams params,
  ) async {
    try {
      final model = await remoteDataSource.refreshAuthToken(params);
      return Right(model.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, Unit>> changePassword(
    ChangePasswordParams params,
  ) async {
    try {
      await remoteDataSource.changePassword(params);
      return const Right(unit);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, Unit>> logout() async {
    try {
      await socialAuthDataSource.logout();
      await remoteDataSource.logout();
      return const Right(unit);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, Unit>> forgotPassword(
    ForgotPasswordParams params,
  ) async {
    try {
      await remoteDataSource.forgotPassword(params);
      return const Right(unit);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, Unit>> resetPassword(
    ResetPasswordParams params,
  ) async {
    try {
      await remoteDataSource.resetPassword(params);
      return const Right(unit);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, SocialAuthResponseEntity>> socialLogin(
    SocialProvider provider,
  ) async {
    try {
      final socialAuthModel = await socialAuthDataSource.authenticate(provider);
      final requestModel = SocialLoginRequestModel(
        socialProvider: provider.name,
        token: socialAuthModel.token,
        firstName: socialAuthModel.firstName,
        lastName: socialAuthModel.lastName,
      );
      final networkModel = await remoteDataSource.socialLogin(requestModel);
      return Right(networkModel);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, SocialAuthResponseEntity>> completeSocialRegistration(
    CompleteSocialRegistrationParams params,
  ) async {
    try {
      final networkModel = await remoteDataSource.completeSocialRegistration(
        params,
      );
      return Right(networkModel);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, AuthResponseEntity>> updatePhoneNumber(
    UpdatePhoneParams params,
  ) async {
    try {
      final model = await remoteDataSource.updatePhoneNumber(params);
      return Right(model.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  // 🎯 NEW: Process the deletion request
  @override
  Future<Either<AppError, Unit>> deleteAccount() async {
    try {
      await remoteDataSource.deleteAccount();
      return const Right(unit);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }
}
