import 'package:equatable/equatable.dart';
import 'notification_metadata_entity.dart';

class NotificationDataEntity extends Equatable {
  final String title;
  final String message;
  final NotificationMetadataEntity metadata;

  const NotificationDataEntity({
    required this.title,
    required this.message,
    required this.metadata,
  });

  @override
  List<Object?> get props => [title, message, metadata];
}
