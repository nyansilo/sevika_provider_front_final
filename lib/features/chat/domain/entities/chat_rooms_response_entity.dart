import 'package:equatable/equatable.dart';
import 'chat_room_entity.dart';
import 'chat_pagination_entity.dart';

class ChatRoomsResponseEntity extends Equatable {
  final List<ChatRoomEntity> rooms;
  final ChatPaginationEntity pagination;

  const ChatRoomsResponseEntity({
    required this.rooms,
    required this.pagination,
  });

  @override
  List<Object?> get props => [rooms, pagination];
}
