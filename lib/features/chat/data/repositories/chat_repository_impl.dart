import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_handler.dart';
import '../../domain/entities/chat_rooms_response_entity.dart';
import '../../domain/entities/chat_room_entity.dart';
import '../../domain/entities/chat_stream_response_entity.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/usecases/params/get_chat_rooms_params.dart';
import '../../domain/usecases/params/initialize_chat_params.dart';
import '../../domain/usecases/params/get_message_stream_params.dart';
import '../../domain/usecases/params/send_text_message_params.dart';
import '../../domain/usecases/params/send_location_message_params.dart';

// Data Sources
import '../datasources/chat_remote_data_source.dart';
import '../datasources/chat_websocket_data_source.dart';

// Models
import '../models/chat_room_model.dart';
import '../models/chat_pagination_model.dart';
import '../models/chat_message_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final ChatWebSocketDataSource
  webSocketDataSource; // 🎯 WebSocket injected here

  ChatRepositoryImpl({
    required this.remoteDataSource,
    required this.webSocketDataSource,
  });

  // ==========================================================================
  // REST API IMPLEMENTATIONS
  // ==========================================================================

  @override
  Future<Either<AppError, ChatRoomsResponseEntity>> fetchChatRooms(
    GetChatRoomsParams params,
  ) async {
    try {
      final rawResponse = await remoteDataSource.getRooms(params);
      final dataMap = rawResponse['data'] as Map<String, dynamic>? ?? const {};

      final List<ChatRoomModel> parsedRooms = [];
      if (dataMap['rooms'] is List) {
        for (var rawItem in dataMap['rooms']) {
          parsedRooms.add(
            ChatRoomModel.fromJson(rawItem as Map<String, dynamic>),
          );
        }
      }

      final pagination = ChatPaginationModel.fromJson(
        dataMap['pagination'] as Map<String, dynamic>? ?? const {},
      );

      return Right(
        ChatRoomsResponseEntity(rooms: parsedRooms, pagination: pagination),
      );
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, ChatRoomEntity>> initializeRoomContext(
    InitializeChatParams params,
  ) async {
    try {
      final model = await remoteDataSource.initializeRoom(params);
      return Right(model);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, ChatStreamResponseEntity>> fetchMessageStream(
    GetMessageStreamParams params,
  ) async {
    try {
      final rawResponse = await remoteDataSource.getMessageStream(params);
      final dataMap = rawResponse['data'] as Map<String, dynamic>? ?? const {};

      final List<ChatMessageModel> parsedMessages = [];
      if (dataMap['messages'] is List) {
        for (var rawItem in dataMap['messages']) {
          parsedMessages.add(
            ChatMessageModel.fromJson(rawItem as Map<String, dynamic>),
          );
        }
      }

      final pagination = ChatPaginationModel.fromJson(
        dataMap['pagination'] as Map<String, dynamic>? ?? const {},
      );

      return Right(
        ChatStreamResponseEntity(
          messages: parsedMessages,
          pagination: pagination,
        ),
      );
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, ChatMessageEntity>> sendTextMessage(
    SendTextMessageParams params,
  ) async {
    try {
      final model = await remoteDataSource.sendTextMessage(params);
      return Right(model);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, ChatMessageEntity>> sendLocationMessage(
    SendLocationMessageParams params,
  ) async {
    try {
      final model = await remoteDataSource.sendLocationMessage(params);
      return Right(model);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, void>> markRoomAsRead({
    required String roomId,
  }) async {
    try {
      await remoteDataSource.syncReadState(roomId);
      return const Right(null);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  // ==========================================================================
  // REAL-TIME WEBSOCKET IMPLEMENTATIONS
  // ==========================================================================

  @override
  Stream<ChatMessageEntity> initializeLiveChatStream(
    String userId,
    String roomId,
    String token,
  ) {
    // 🎯 Maps the raw WebSocket Model stream intoS your Domain Entity stream
    return webSocketDataSource
        .listenToLiveMessages(userId, roomId, token)
        .map((model) => model);
  }

  @override
  void disposeWebSocketStream() {
    // 🧹 Cleanly severs the Pusher/Reverb connection
    webSocketDataSource.disconnect();
  }
}
