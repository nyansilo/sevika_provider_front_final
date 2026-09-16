import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../entities/user_profile_entity.dart';
import '../usecases/params/update_profile_params.dart';

abstract class ProfileRepository {
  Future<Either<AppError, UserProfileEntity>> getProfile();
  Future<Either<AppError, UserProfileEntity>> updateProfile(
    UpdateProfileParams params,
  );

  // 🚀 ADDED: Contract for toggling provider availability status
  Future<Either<AppError, bool>> toggleAvailability({required bool isOnline});
}
