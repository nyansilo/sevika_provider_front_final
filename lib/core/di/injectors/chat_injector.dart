import 'package:get_it/get_it.dart';
import '../../../features/chat/data/datasources/chat_remote_data_source.dart';
import '../../../features/chat/data/datasources/chat_websocket_data_source.dart';
import '../../../features/chat/data/repositories/chat_repository_impl.dart';
import '../../../features/chat/domain/repositories/chat_repository.dart';
import '../../../features/chat/domain/usecases/get_chat_rooms_use_case.dart';
import '../../../features/chat/domain/usecases/initialize_chat_use_case.dart';
import '../../../features/chat/domain/usecases/get_message_stream_use_case.dart';
import '../../../features/chat/domain/usecases/listen_live_chat_use_case.dart';
import '../../../features/chat/domain/usecases/send_text_message_use_case.dart';
import '../../../features/chat/domain/usecases/send_location_message_use_case.dart';
import '../../../features/chat/domain/usecases/mark_room_as_read_use_case.dart';
import '../../../features/chat/presentation/cubits/chat_cubit.dart';

void initChat(GetIt sl) {
  // Data Sources
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ChatWebSocketDataSource>(
    () => ChatWebSocketDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(remoteDataSource: sl(), webSocketDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetChatRoomsUseCase(sl()));
  sl.registerLazySingleton(() => InitializeChatUseCase(sl()));
  sl.registerLazySingleton(() => GetMessageStreamUseCase(sl()));
  sl.registerLazySingleton(() => SendTextMessageUseCase(sl()));
  sl.registerLazySingleton(() => SendLocationMessageUseCase(sl()));
  sl.registerLazySingleton(() => MarkRoomAsReadUseCase(sl()));

  // 🎯 CRITICAL: Register the new WebSocket Use Case
  sl.registerLazySingleton(() => ListenLiveChatUseCase(sl()));

  // Presentation Cubit
  sl.registerFactory(
    () => ChatCubit(
      getChatRoomsUseCase: sl(),
      initializeChatUseCase: sl(),
      getMessageStreamUseCase: sl(),
      sendTextMessageUseCase: sl(),
      sendLocationMessageUseCase: sl(),
      markRoomAsReadUseCase: sl(),
      listenLiveChatUseCase: sl(), // 🎯 Inject it here
    ),
  );
}
