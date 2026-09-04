import '../../domain/entities/notification_entity.dart';
import 'notification_item_model.dart';
import 'notification_pagination_model.dart';

class NotificationResponseModel {
  final List<NotificationItemModel> notifications;
  final int unreadCount;
  final NotificationPaginationModel pagination;

  NotificationResponseModel({
    required this.notifications,
    required this.unreadCount,
    required this.pagination,
  });

  NotificationEntity toEntity() {
    return NotificationEntity(
      notifications: notifications.map((model) => model.toEntity()).toList(),
      unreadCount: unreadCount,
      pagination: pagination,
    );
  }

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> rootData = (json['data'] is Map<String, dynamic>)
        ? json['data'] as Map<String, dynamic>
        : const {};

    final List<NotificationItemModel> notificationList = [];
    final dynamic notificationsData = rootData['notifications'];

    if (notificationsData is List) {
      for (var element in notificationsData) {
        if (element is Map<String, dynamic>) {
          notificationList.add(NotificationItemModel.fromJson(element));
        }
      }
    }

    final Map<String, dynamic> metaData =
        rootData['meta'] is Map<String, dynamic>
        ? rootData['meta'] as Map<String, dynamic>
        : const {};

    // 🎯 FIX: Pagination is at the root data level, not inside meta
    final Map<String, dynamic> paginationData =
        rootData['pagination'] is Map<String, dynamic>
        ? rootData['pagination'] as Map<String, dynamic>
        : const {};

    return NotificationResponseModel(
      notifications: notificationList,
      // 🎯 FIX: unreadCount is inside the meta object
      unreadCount: metaData['unreadCount'] as int? ?? 0,
      pagination: NotificationPaginationModel.fromJson(paginationData),
    );
  }
}
