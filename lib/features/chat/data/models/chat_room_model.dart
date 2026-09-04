import '../../domain/entities/chat_room_entity.dart';
import 'chat_room_recipient_model.dart';

class ChatRoomModel extends ChatRoomEntity {
  const ChatRoomModel({
    required super.roomId,
    required super.bookingId,
    required super.unreadCount,
    super.lastMessage,
    super.lastMessageTime,
    required ChatRoomRecipientModel super.recipient,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      roomId: json['roomId']?.toString() ?? json['room_id']?.toString() ?? '',
      bookingId:
          json['bookingId']?.toString() ?? json['booking_id']?.toString() ?? '',
      unreadCount:
          json['unreadCount'] as int? ?? json['unread_count'] as int? ?? 0,
      lastMessage:
          json['lastMessage']?.toString() ?? json['last_message']?.toString(),
      lastMessageTime:
          json['lastMessageTime']?.toString() ??
          json['last_message_time']?.toString(),
      recipient: ChatRoomRecipientModel.fromJson(
        json['recipient'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }
}
