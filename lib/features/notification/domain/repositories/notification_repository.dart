// import 'package:dartz/dartz.dart';
// import '../../../../core/errors/app_error.dart';
// import '../entities/notification_entity.dart';
// import '../entities/notification_item_entity.dart';
// import '../usecases/params/get_notifications_params.dart';
// import '../usecases/params/update_fcm_token_params.dart';

// abstract class NotificationRepository {
//   Future<Either<AppError, NotificationEntity>> getNotifications(
//     GetNotificationsParams params,
//   );
//   Future<Either<AppError, void>> markAsRead(String id);
//   Future<Either<AppError, void>> markAllAsRead();
//   Future<Either<AppError, void>> deleteNotification(String id);
//   Future<Either<AppError, void>> clearAllNotifications();

//   // Stream Architecture Control Contracts
//   Stream<NotificationItemEntity> initializeLiveNotificationStream(
//     String userId,
//     String token,
//   );
//   void disposeWebSocketStream();

//   // 🎯 ADDED: Contract for syncing the token
//   Future<Either<AppError, void>> updateFcmToken(UpdateFcmTokenParams params);
// }

import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../entities/notification_entity.dart';
import '../entities/notification_item_entity.dart';
import '../usecases/params/get_notifications_params.dart';
import '../usecases/params/toggle_notification_params.dart';
import '../usecases/params/update_fcm_token_params.dart';

abstract class NotificationRepository {
  Future<Either<AppError, NotificationEntity>> getNotifications(
    GetNotificationsParams params,
  );
  Future<Either<AppError, void>> markAsRead(String id);
  Future<Either<AppError, void>> markAllAsRead();
  Future<Either<AppError, void>> deleteNotification(String id);
  Future<Either<AppError, void>> clearAllNotifications();

  // Stream Architecture Control Contracts
  Stream<NotificationItemEntity> initializeLiveNotificationStream(
    String userId,
    String token,
  );

  // 🎯 FIXED: Now forces the Repository to return an Either type wrapper
  Future<Either<AppError, void>> disposeWebSocketStream();

  // Contract for syncing the token
  Future<Either<AppError, void>> updateFcmToken(UpdateFcmTokenParams params);
  Future<Either<AppError, void>> toggleNotificationPreference(
    ToggleNotificationParams params,
  );
}
