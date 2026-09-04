import 'package:equatable/equatable.dart';
import 'chat_room_recipient_entity.dart';

class ChatRoomEntity extends Equatable {
  final String roomId;
  final String bookingId;
  final int unreadCount;
  final String? lastMessage;
  final String? lastMessageTime;
  final ChatRoomRecipientEntity recipient;

  const ChatRoomEntity({
    required this.roomId,
    required this.bookingId,
    required this.unreadCount,
    this.lastMessage,
    this.lastMessageTime,
    required this.recipient,
  });

  // 🎯 Add this copyWith method
  ChatRoomEntity copyWith({
    String? roomId,
    String? bookingId,
    int? unreadCount,
    String? lastMessage,
    String? lastMessageTime,
    ChatRoomRecipientEntity? recipient,
  }) {
    return ChatRoomEntity(
      roomId: roomId ?? this.roomId,
      bookingId: bookingId ?? this.bookingId,
      unreadCount: unreadCount ?? this.unreadCount,
      // Note: If you ever need to explicitly set nullable fields to null,
      // you might need a more advanced copyWith, but this handles 99% of cases.
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      recipient: recipient ?? this.recipient,
    );
  }

  @override
  List<Object?> get props => [
    roomId,
    bookingId,
    unreadCount,
    lastMessage,
    lastMessageTime,
    recipient,
  ];
}
