// }

import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase implements UseCase<Unit, NoParams> {
  final AuthRepository repository;
  LogoutUseCase(this.repository);
  @override
  Future<Either<AppError, Unit>> call(NoParams params) async =>
      await repository.logout();
}
