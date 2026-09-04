import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_profile_entity.dart';
import '../repositories/profile_repository.dart';
import 'params/update_profile_params.dart';

class UpdateProfileUseCase
    implements UseCase<UserProfileEntity, UpdateProfileParams> {
  final ProfileRepository repository;
  UpdateProfileUseCase(this.repository);
  @override
  Future<Either<AppError, UserProfileEntity>> call(
    UpdateProfileParams params,
  ) async => await repository.updateProfile(params);
}
