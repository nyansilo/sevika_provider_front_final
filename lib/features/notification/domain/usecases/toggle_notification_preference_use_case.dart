// lib/features/notification/domain/usecases/toggle_notification_preference_use_case.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/notification_repository.dart';
import 'params/toggle_notification_params.dart';

class ToggleNotificationPreferenceUseCase
    implements UseCase<void, ToggleNotificationParams> {
  final NotificationRepository repository;
  ToggleNotificationPreferenceUseCase(this.repository);

  @override
  Future<Either<AppError, void>> call(ToggleNotificationParams params) async {
    return await repository.toggleNotificationPreference(params);
  }
}
