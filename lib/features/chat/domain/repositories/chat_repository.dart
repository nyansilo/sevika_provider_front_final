import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../entities/chat_rooms_response_entity.dart';
import '../entities/chat_room_entity.dart';
import '../entities/chat_stream_response_entity.dart';
import '../entities/chat_message_entity.dart';
import '../usecases/params/get_chat_rooms_params.dart';
import '../usecases/params/initialize_chat_params.dart';
import '../usecases/params/get_message_stream_params.dart';
import '../usecases/params/send_text_message_params.dart';
import '../usecases/params/send_location_message_params.dart';

abstract class ChatRepository {
  // ==========================================================================
  // REST API CONTRACTS (Standard HTTP Operations)
  // ==========================================================================
  Future<Either<AppError, ChatRoomsResponseEntity>> fetchChatRooms(
    GetChatRoomsParams params,
  );
  Future<Either<AppError, ChatRoomEntity>> initializeRoomContext(
    InitializeChatParams params,
  );
  Future<Either<AppError, ChatStreamResponseEntity>> fetchMessageStream(
    GetMessageStreamParams params,
  );
  Future<Either<AppError, ChatMessageEntity>> sendTextMessage(
    SendTextMessageParams params,
  );
  Future<Either<AppError, ChatMessageEntity>> sendLocationMessage(
    SendLocationMessageParams params,
  );
  Future<Either<AppError, void>> markRoomAsRead({required String roomId});

  // ==========================================================================
  // REAL-TIME WEBSOCKET CONTRACTS (Laravel Reverb / Pusher)
  // ==========================================================================
  Stream<ChatMessageEntity> initializeLiveChatStream(
    String userId,
    String roomId,
    String token,
  );
  void disposeWebSocketStream();
}
