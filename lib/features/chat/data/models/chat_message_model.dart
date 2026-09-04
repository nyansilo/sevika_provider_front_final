import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/chat_message_type.dart';

class ChatMessageModel extends ChatMessageEntity {
  const ChatMessageModel({
    required super.messageId,
    required super.roomId,
    required super.isMe,
    required super.senderId,
    required super.type,
    required super.body,
    required super.metadata,
    required super.sentAt,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      messageId:
          json['messageId']?.toString() ?? json['message_id']?.toString() ?? '',
      roomId: json['roomId']?.toString() ?? json['room_id']?.toString() ?? '',
      isMe: json['isMe'] as bool? ?? json['is_me'] as bool? ?? false,
      senderId:
          json['senderId']?.toString() ?? json['sender_id']?.toString() ?? '',
      type: ChatMessageType.fromString(json['type']?.toString() ?? ''),
      body: json['body']?.toString() ?? '',
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      sentAt: json['sentAt']?.toString() ?? json['sent_at']?.toString() ?? '',
    );
  }
}
