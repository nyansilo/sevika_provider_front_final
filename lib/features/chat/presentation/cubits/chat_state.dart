import 'package:equatable/equatable.dart';
import '../../../../core/errors/app_error.dart';
import '../../domain/entities/chat_room_entity.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/chat_pagination_entity.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatRoomsLoading extends ChatState {
  const ChatRoomsLoading();
}

class ChatRoomsLoadSuccess extends ChatState {
  final List<ChatRoomEntity> rooms;
  final ChatPaginationEntity pagination;

  const ChatRoomsLoadSuccess({required this.rooms, required this.pagination});

  @override
  List<Object?> get props => [rooms, pagination];
}

class ChatRoomsLoadFailure extends ChatState {
  final AppError error;
  const ChatRoomsLoadFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class ChatStreamLoading extends ChatState {
  const ChatStreamLoading();
}

class ChatStreamLoadSuccess extends ChatState {
  final String roomId;
  final List<ChatMessageEntity> messages;
  final ChatPaginationEntity pagination;
  final bool isSending;

  const ChatStreamLoadSuccess({
    required this.roomId,
    required this.messages,
    required this.pagination,
    this.isSending = false,
  });

  ChatStreamLoadSuccess copyWith({
    List<ChatMessageEntity>? messages,
    ChatPaginationEntity? pagination,
    bool? isSending,
  }) {
    return ChatStreamLoadSuccess(
      roomId: roomId,
      messages: messages ?? this.messages,
      pagination: pagination ?? this.pagination,
      isSending: isSending ?? this.isSending,
    );
  }

  @override
  List<Object?> get props => [roomId, messages, pagination, isSending];
}

class ChatStreamLoadFailure extends ChatState {
  final AppError error;
  const ChatStreamLoadFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class ChatActionFailure extends ChatState {
  final AppError error;
  const ChatActionFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
