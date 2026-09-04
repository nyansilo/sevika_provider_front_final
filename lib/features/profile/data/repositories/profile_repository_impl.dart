import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_handler.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/usecases/params/update_profile_params.dart';
import '../datasources/profile_remote_data_source.dart.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppError, UserProfileEntity>> getProfile() async {
    try {
      final model = await remoteDataSource.fetchUserProfile();
      return Right(model.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, UserProfileEntity>> updateProfile(
    UpdateProfileParams params,
  ) async {
    try {
      final model = await remoteDataSource.updateUserProfile(params);
      return Right(model.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }
}
