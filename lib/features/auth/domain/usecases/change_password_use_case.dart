import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';
import 'params/change_password_params.dart';

class ChangePasswordUseCase implements UseCase<Unit, ChangePasswordParams> {
  final AuthRepository repository;
  ChangePasswordUseCase(this.repository);
  @override
  Future<Either<AppError, Unit>> call(ChangePasswordParams params) async =>
      await repository.changePassword(params);
}
