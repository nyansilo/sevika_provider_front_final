import 'package:get_it/get_it.dart';

import '../../../features/notification/data/datasources/notification_remote_data_source.dart';
import '../../../features/notification/data/datasources/notification_websocket_source.dart';
import '../../../features/notification/data/repositories/notification_repository_impl.dart';
import '../../../features/notification/domain/repositories/notification_repository.dart';

// 🎯 USE CASES
import '../../../features/notification/domain/usecases/get_notifications_use_case.dart';
import '../../../features/notification/domain/usecases/mark_all_as_read_use_case.dart';
import '../../../features/notification/domain/usecases/mark_as_read_use_case.dart';
import '../../../features/notification/domain/usecases/delete_notification_use_case.dart';
import '../../../features/notification/domain/usecases/clear_all_notifications_use_case.dart';
import '../../../features/notification/domain/usecases/disconnect_live_notifications_use_case.dart';
import '../../../features/notification/domain/usecases/listen_live_notifications_use_case.dart';
import '../../../features/notification/domain/usecases/update_fcm_token_use_case.dart';
import '../../../features/notification/domain/usecases/toggle_notification_preference_use_case.dart'; // 🎯 NEW IMPORT

// 🎯 CUBITS
import '../../../features/notification/presentation/cubits/notification/notifications_cubit.dart';

void initNotification(GetIt sl) {
  // =========================================================================
  // PRESENTATION LAYER (CUBITS)
  // =========================================================================
  sl.registerFactory<NotificationsCubit>(
    () => NotificationsCubit(
      getNotificationsUseCase: sl(),
      markAsReadUseCase: sl(),
      markAllAsReadUseCase: sl(),
      deleteNotificationUseCase: sl(),
      clearAllNotificationsUseCase: sl(),
      listenLiveNotificationsUseCase: sl(),
      disconnectLiveNotificationsUseCase: sl(),
    ),
  );

  // =========================================================================
  // DOMAIN LAYER (USE CASES)
  // =========================================================================
  sl.registerLazySingleton<GetNotificationsUseCase>(
    () => GetNotificationsUseCase(sl()),
  );
  sl.registerLazySingleton<MarkAsReadUseCase>(() => MarkAsReadUseCase(sl()));
  sl.registerLazySingleton<MarkAllAsReadUseCase>(
    () => MarkAllAsReadUseCase(sl()),
  );
  sl.registerLazySingleton<DeleteNotificationUseCase>(
    () => DeleteNotificationUseCase(sl()),
  );
  sl.registerLazySingleton<ClearAllNotificationsUseCase>(
    () => ClearAllNotificationsUseCase(sl()),
  );
  sl.registerLazySingleton<ListenLiveNotificationsUseCase>(
    () => ListenLiveNotificationsUseCase(sl()),
  );
  sl.registerLazySingleton<DisconnectLiveNotificationsUseCase>(
    () => DisconnectLiveNotificationsUseCase(sl()),
  );

  // 🎯 FCM & Settings UseCases
  sl.registerLazySingleton<UpdateFcmTokenUseCase>(
    () => UpdateFcmTokenUseCase(sl()),
  );

  // 🎯 ADDED: This satisfies the dependency requirement for NotificationSettingsCubit!
  sl.registerLazySingleton<ToggleNotificationPreferenceUseCase>(
    () => ToggleNotificationPreferenceUseCase(sl()),
  );

  // =========================================================================
  // DATA LAYER (REPOSITORIES & DATASOURCES)
  // =========================================================================
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(
      remoteDataSource: sl(),
      webSocketSource: sl(),
    ),
  );
  sl.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<NotificationWebSocketSource>(
    () => NotificationWebSocketSourceImpl(),
  );
}
