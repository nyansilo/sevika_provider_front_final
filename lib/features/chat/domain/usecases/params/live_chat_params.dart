import 'package:equatable/equatable.dart';

class LiveChatParams extends Equatable {
  final String userId; // 🎯 Added User ID
  final String roomId;
  final String token;

  const LiveChatParams({
    required this.userId,
    required this.roomId,
    required this.token,
  });

  @override
  List<Object?> get props => [userId, roomId, token];
}
