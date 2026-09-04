import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/notification_repository.dart';

class ClearAllNotificationsUseCase implements UseCase<void, NoParams> {
  final NotificationRepository repository;

  ClearAllNotificationsUseCase(this.repository);

  @override
  Future<Either<AppError, void>> call(NoParams params) async {
    return await repository.clearAllNotifications();
  }
}
