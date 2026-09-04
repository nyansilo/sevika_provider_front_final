import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/social_auth_response_entity.dart';
import '../repositories/auth_repository.dart';
import 'params/complete_social_registration_params.dart';

class CompleteSocialRegistrationUseCase
    implements
        UseCase<SocialAuthResponseEntity, CompleteSocialRegistrationParams> {
  final AuthRepository repository;
  CompleteSocialRegistrationUseCase(this.repository);

  @override
  Future<Either<AppError, SocialAuthResponseEntity>> call(
    CompleteSocialRegistrationParams params,
  ) async {
    return await repository.completeSocialRegistration(params);
  }
}
