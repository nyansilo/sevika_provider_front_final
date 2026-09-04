import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/notification_repository.dart';
import 'params/update_fcm_token_params.dart';

class UpdateFcmTokenUseCase implements UseCase<void, UpdateFcmTokenParams> {
  final NotificationRepository repository;

  UpdateFcmTokenUseCase(this.repository);

  @override
  Future<Either<AppError, void>> call(UpdateFcmTokenParams params) async {
    return await repository.updateFcmToken(params);
  }
}
