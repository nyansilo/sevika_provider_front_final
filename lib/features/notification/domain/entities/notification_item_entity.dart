import 'package:equatable/equatable.dart';
import 'notification_data_entity.dart';
import 'notification_type.dart';

class NotificationItemEntity extends Equatable {
  final String id;
  final NotificationType type;
  final NotificationDataEntity data;
  final String? readAt;
  final String createdAt;

  const NotificationItemEntity({
    required this.id,
    required this.type,
    required this.data,
    this.readAt,
    required this.createdAt,
  });

  bool get isRead => readAt != null;

  @override
  List<Object?> get props => [id, type, data, readAt, createdAt];
}
