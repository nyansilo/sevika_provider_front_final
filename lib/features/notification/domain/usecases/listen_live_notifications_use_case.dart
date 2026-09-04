import '../entities/notification_item_entity.dart';
import '../repositories/notification_repository.dart';
import 'params/live_stream_params.dart';

class ListenLiveNotificationsUseCase {
  final NotificationRepository repository;

  ListenLiveNotificationsUseCase(this.repository);

  Stream<NotificationItemEntity> call(LiveStreamParams params) {
    return repository.initializeLiveNotificationStream(
      params.userId,
      params.token,
    );
  }
}
