import 'package:equatable/equatable.dart';
import 'chat_message_entity.dart';
import 'chat_pagination_entity.dart';

class ChatStreamResponseEntity extends Equatable {
  final List<ChatMessageEntity> messages;
  final ChatPaginationEntity pagination;

  const ChatStreamResponseEntity({
    required this.messages,
    required this.pagination,
  });

  @override
  List<Object?> get props => [messages, pagination];
}
