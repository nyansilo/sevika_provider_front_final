// import 'package:dartz/dartz.dart';
// import '../../../../core/errors/app_error.dart';
// import '../../../../core/errors/error_handler.dart';
// import '../../domain/entities/auth_response_entity.dart';
// import '../../domain/entities/user_entity.dart';
// import '../../domain/repositories/auth_repository.dart';
// import '../../domain/usecases/params/change_password_params.dart';
// import '../../domain/usecases/params/login_params.dart';
// import '../../domain/usecases/params/refresh_token_params.dart';
// import '../../domain/usecases/params/register_params.dart';
// import '../../domain/usecases/params/update_profile_params.dart';
// import '../datasources/auth_remote_data_source.dart';

// class AuthRepositoryImplOld implements AuthRepositoryOld {
//   final AuthRemoteDataSource remoteDataSource;

//   AuthRepositoryImpl({required this.remoteDataSource});

//   @override
//   Future<Either<AppError, AuthResponseEntity>> login(LoginParams params) async {
//     try {
//       final remoteModel = await remoteDataSource.login(params);
//       return Right(remoteModel.toEntity());
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, AuthResponseEntity>> register(
//     RegisterParams params,
//   ) async {
//     try {
//       final remoteModel = await remoteDataSource.register(params);
//       return Right(remoteModel.toEntity());
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, UserEntity>> getCurrentUser() async {
//     try {
//       final remoteModel = await remoteDataSource.fetchUserProfile();
//       return Right(remoteModel.toEntity());
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, UserEntity>> updateProfile(
//     UpdateProfileParams params,
//   ) async {
//     try {
//       final remoteModel = await remoteDataSource.updateUserProfile(params);
//       return Right(remoteModel.toEntity());
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, AuthResponseEntity>> refreshToken(
//     RefreshTokenParams params,
//   ) async {
//     try {
//       final remoteModel = await remoteDataSource.refreshAuthToken(params);
//       return Right(remoteModel.toEntity());
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, Unit>> logout() async {
//     try {
//       await remoteDataSource.logout();
//       return const Right(
//         unit,
//       ); // 🚀 CLEANED: Returns the dartz global constant unit instance
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
// }
