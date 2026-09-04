import '../../domain/entities/notification_data_entity.dart';
import 'notification_metadata_model.dart';

class NotificationDataModel extends NotificationDataEntity {
  const NotificationDataModel({
    required super.title,
    required super.message,
    required NotificationMetadataModel super.metadata,
  });

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) {
    return NotificationDataModel(
      title: json['title']?.toString() ?? 'Notification Update',
      message: json['message']?.toString() ?? '',
      metadata: NotificationMetadataModel.fromJson(
        json['metadata'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'message': message,
    'metadata': (metadata as NotificationMetadataModel).toJson(),
  };
}
