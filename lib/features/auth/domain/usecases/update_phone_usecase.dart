import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_response_entity.dart';
import '../repositories/auth_repository.dart';
import 'params/update_phone_params.dart';

class UpdatePhoneUseCase
    implements UseCase<AuthResponseEntity, UpdatePhoneParams> {
  final AuthRepository repository;
  UpdatePhoneUseCase(this.repository);

  @override
  Future<Either<AppError, AuthResponseEntity>> call(
    UpdatePhoneParams params,
  ) async {
    return await repository.updatePhoneNumber(params);
  }
}
