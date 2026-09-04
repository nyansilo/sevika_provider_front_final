import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/social_auth_response_entity.dart';
import '../repositories/auth_repository.dart';
import 'params/perform_social_login_params.dart';

class SocialLoginUseCase
    implements UseCase<SocialAuthResponseEntity, PerformSocialLoginParams> {
  final AuthRepository repository;
  SocialLoginUseCase(this.repository);

  @override
  Future<Either<AppError, SocialAuthResponseEntity>> call(
    PerformSocialLoginParams params,
  ) async {
    return await repository.socialLogin(params.provider);
  }
}
