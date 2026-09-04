import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_response_entity.dart';
import '../repositories/auth_repository.dart';
import 'params/refresh_token_params.dart';

class RefreshAuthTokenUseCase
    implements UseCase<AuthResponseEntity, RefreshTokenParams> {
  final AuthRepository repository;
  RefreshAuthTokenUseCase(this.repository);
  @override
  Future<Either<AppError, AuthResponseEntity>> call(
    RefreshTokenParams params,
  ) async => await repository.refreshToken(params);
}
