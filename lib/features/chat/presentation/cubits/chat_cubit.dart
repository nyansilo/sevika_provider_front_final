import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_chat_rooms_use_case.dart';
import '../../domain/usecases/initialize_chat_use_case.dart';
import '../../domain/usecases/get_message_stream_use_case.dart';
import '../../domain/usecases/params/live_chat_params.dart';
import '../../domain/usecases/send_text_message_use_case.dart';
import '../../domain/usecases/send_location_message_use_case.dart';
import '../../domain/usecases/mark_room_as_read_use_case.dart';
import '../../domain/usecases/listen_live_chat_use_case.dart';

import '../../domain/usecases/params/get_chat_rooms_params.dart';
import '../../domain/usecases/params/initialize_chat_params.dart';
import '../../domain/usecases/params/get_message_stream_params.dart';
import '../../domain/usecases/params/send_text_message_params.dart';
import '../../domain/usecases/params/send_location_message_params.dart';
import '../../domain/entities/chat_message_entity.dart';

import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GetChatRoomsUseCase getChatRoomsUseCase;
  final InitializeChatUseCase initializeChatUseCase;
  final GetMessageStreamUseCase getMessageStreamUseCase;
  final SendTextMessageUseCase sendTextMessageUseCase;
  final SendLocationMessageUseCase sendLocationMessageUseCase;
  final MarkRoomAsReadUseCase markRoomAsReadUseCase;
  final ListenLiveChatUseCase listenLiveChatUseCase;

  StreamSubscription<ChatMessageEntity>? _liveMessageSubscription;

  ChatCubit({
    required this.getChatRoomsUseCase,
    required this.initializeChatUseCase,
    required this.getMessageStreamUseCase,
    required this.sendTextMessageUseCase,
    required this.sendLocationMessageUseCase,
    required this.markRoomAsReadUseCase,
    required this.listenLiveChatUseCase,
  }) : super(const ChatInitial());

  // ==========================================================================
  // ROOM LOGIC
  // ==========================================================================

  Future<void> loadChatRooms({int page = 1}) async {
    emit(const ChatRoomsLoading());
    final result = await getChatRoomsUseCase.call(
      GetChatRoomsParams(page: page),
    );

    if (isClosed) {
      return; // 🎯 FIX: Prevent emitting if Cubit was disposed during network call
    }

    result.fold(
      (error) => emit(ChatRoomsLoadFailure(error: error)),
      (response) => emit(
        ChatRoomsLoadSuccess(
          rooms: response.rooms,
          pagination: response.pagination,
        ),
      ),
    );
  }

  Future<void> markAllRoomsAsRead() async {
    final currentState = state;
    if (currentState is! ChatRoomsLoadSuccess) return;

    final unreadRooms = currentState.rooms
        .where((r) => r.unreadCount > 0)
        .toList();
    if (unreadRooms.isEmpty) return;

    final updatedRooms = currentState.rooms.map((room) {
      if (room.unreadCount > 0) return room.copyWith(unreadCount: 0);
      return room;
    }).toList();

    emit(
      ChatRoomsLoadSuccess(
        rooms: updatedRooms,
        pagination: currentState.pagination,
      ),
    );

    await Future.wait(
      unreadRooms.map((room) => markRoomAsReadUseCase.call(room.roomId)),
    );
  }

  // ==========================================================================
  // MESSAGE STREAM & LIVE SOCKET LOGIC
  // ==========================================================================

  Future<void> enterRoomContext({
    required String recipientId,
    required String bookingId,
  }) async {
    emit(const ChatStreamLoading());
    final result = await initializeChatUseCase.call(
      InitializeChatParams(recipientId: recipientId, bookingId: bookingId),
    );

    if (isClosed) return; // 🎯 FIX applied here

    result.fold(
      (error) => emit(ChatStreamLoadFailure(error: error)),
      (room) => loadMessageStream(roomId: room.roomId),
    );
  }

  Future<void> loadMessageStream({required String roomId, int page = 1}) async {
    if (page == 1) emit(const ChatStreamLoading());

    final result = await getMessageStreamUseCase.call(
      GetMessageStreamParams(roomId: roomId, page: page),
    );

    if (isClosed) return; // 🎯 FIX applied here

    result.fold((error) => emit(ChatStreamLoadFailure(error: error)), (
      response,
    ) {
      emit(
        ChatStreamLoadSuccess(
          roomId: roomId,
          messages: response.messages,
          pagination: response.pagination,
        ),
      );
      markRoomAsRead(roomId: roomId);
    });
  }

  void initLiveChatListener({
    required String userId,
    required String roomId,
    required String token,
  }) {
    _liveMessageSubscription?.cancel();

    _liveMessageSubscription = listenLiveChatUseCase
        .call(LiveChatParams(userId: userId, roomId: roomId, token: token))
        .listen((liveMessage) {
          if (isClosed) return; // 🎯 FIX: Guard against lingering stream events

          final currentState = state;
          if (currentState is ChatStreamLoadSuccess) {
            if (currentState.messages.any(
              (m) => m.messageId == liveMessage.messageId,
            )) {
              return;
            }
            final updatedMessages = List<ChatMessageEntity>.from(
              currentState.messages,
            )..insert(0, liveMessage);

            emit(currentState.copyWith(messages: updatedMessages));
            markRoomAsRead(roomId: roomId);
          }
        }, onError: (error) => debugPrint('⚠️ WebSocket Stream Error: $error'));
  }

  // ==========================================================================
  // SENDING MESSAGES
  // ==========================================================================

  Future<void> sendTextMessage({required String text}) async {
    final currentState = state;
    if (currentState is! ChatStreamLoadSuccess) return;

    final String activeRoomId = currentState.roomId;
    emit(currentState.copyWith(isSending: true));

    final result = await sendTextMessageUseCase.call(
      SendTextMessageParams(roomId: activeRoomId, text: text),
    );

    if (isClosed) return; // 🎯 FIX applied here

    result.fold(
      (error) {
        emit(currentState.copyWith(isSending: false));
        emit(ChatActionFailure(error: error));
      },
      (newMessage) {
        final messageExists = currentState.messages.any(
          (m) => m.messageId == newMessage.messageId,
        );
        if (!messageExists) {
          final updatedMessages = List<ChatMessageEntity>.from(
            currentState.messages,
          )..insert(0, newMessage);
          emit(
            currentState.copyWith(messages: updatedMessages, isSending: false),
          );
        } else {
          emit(currentState.copyWith(isSending: false));
        }
      },
    );
  }

  Future<void> sendLocationMessage({
    required double latitude,
    required double longitude,
    required String label,
  }) async {
    final currentState = state;
    if (currentState is! ChatStreamLoadSuccess) return;

    final String activeRoomId = currentState.roomId;
    emit(currentState.copyWith(isSending: true));

    final result = await sendLocationMessageUseCase.call(
      SendLocationMessageParams(
        roomId: activeRoomId,
        latitude: latitude,
        longitude: longitude,
        label: label,
      ),
    );

    if (isClosed) return; // 🎯 FIX applied here

    result.fold(
      (error) {
        emit(currentState.copyWith(isSending: false));
        emit(ChatActionFailure(error: error));
      },
      (newMessage) {
        final messageExists = currentState.messages.any(
          (m) => m.messageId == newMessage.messageId,
        );
        if (!messageExists) {
          final updatedMessages = List<ChatMessageEntity>.from(
            currentState.messages,
          )..insert(0, newMessage);
          emit(
            currentState.copyWith(messages: updatedMessages, isSending: false),
          );
        } else {
          emit(currentState.copyWith(isSending: false));
        }
      },
    );
  }

  Future<void> markRoomAsRead({required String roomId}) async {
    await markRoomAsReadUseCase.call(roomId);
  }

  @override
  Future<void> close() {
    _liveMessageSubscription?.cancel();
    return super.close();
  }
}
