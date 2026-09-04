import 'package:equatable/equatable.dart';
import 'chat_message_type.dart';

class ChatMessageEntity extends Equatable {
  final String messageId;
  final String roomId;
  final bool isMe;
  final String senderId;
  final ChatMessageType type;
  final String body;
  final Map<String, dynamic> metadata;
  final String sentAt;

  const ChatMessageEntity({
    required this.messageId,
    required this.roomId,
    required this.isMe,
    required this.senderId,
    required this.type,
    required this.body,
    required this.metadata,
    required this.sentAt,
  });

  bool get isLocation => type == ChatMessageType.location;

  @override
  List<Object?> get props => [
    messageId,
    roomId,
    isMe,
    senderId,
    type,
    body,
    metadata,
    sentAt,
  ];
}
