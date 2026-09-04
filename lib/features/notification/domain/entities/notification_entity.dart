import 'package:equatable/equatable.dart';
import 'notification_item_entity.dart';
import 'notification_pagination_entity.dart';

class NotificationEntity extends Equatable {
  final List<NotificationItemEntity> notifications;
  final int unreadCount;
  final NotificationPaginationEntity pagination;

  const NotificationEntity({
    required this.notifications,
    required this.unreadCount,
    required this.pagination,
  });

  @override
  List<Object?> get props => [notifications, unreadCount, pagination];
}
