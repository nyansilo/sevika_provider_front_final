import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_response_entity.dart';
import '../repositories/auth_repository.dart';
import 'params/login_params.dart';

class LoginUseCase implements UseCase<AuthResponseEntity, LoginParams> {
  final AuthRepository repository;
  LoginUseCase(this.repository);
  @override
  Future<Either<AppError, AuthResponseEntity>> call(LoginParams params) async =>
      await repository.login(params);
}
