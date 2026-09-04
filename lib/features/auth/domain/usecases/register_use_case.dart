import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_response_entity.dart';
import '../repositories/auth_repository.dart';
import 'params/register_params.dart';

class RegisterUseCase implements UseCase<AuthResponseEntity, RegisterParams> {
  final AuthRepository repository;
  RegisterUseCase(this.repository);
  @override
  Future<Either<AppError, AuthResponseEntity>> call(
    RegisterParams params,
  ) async => await repository.register(params);
}
