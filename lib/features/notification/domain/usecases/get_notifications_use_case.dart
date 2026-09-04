import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/notification_entity.dart';
import '../repositories/notification_repository.dart';
import 'params/get_notifications_params.dart';

class GetNotificationsUseCase
    implements UseCase<NotificationEntity, GetNotificationsParams> {
  final NotificationRepository repository;

  GetNotificationsUseCase(this.repository);

  @override
  Future<Either<AppError, NotificationEntity>> call(
    GetNotificationsParams params,
  ) async {
    return await repository.getNotifications(params);
  }
}
