// import 'package:dartz/dartz.dart';
// import '../../../../core/errors/app_error.dart';
// import '../../../../core/errors/error_handler.dart';
// import '../../domain/entities/notification_entity.dart';
// import '../../domain/entities/notification_item_entity.dart';
// import '../../domain/repositories/notification_repository.dart';
// import '../../domain/usecases/params/get_notifications_params.dart';
// import '../../domain/usecases/params/update_fcm_token_params.dart';
// import '../datasources/notification_remote_data_source.dart';
// import '../datasources/notification_websocket_source.dart';

// class NotificationRepositoryImpl implements NotificationRepository {
//   final NotificationRemoteDataSource remoteDataSource;
//   final NotificationWebSocketSource webSocketSource;

//   NotificationRepositoryImpl({
//     required this.remoteDataSource,
//     required this.webSocketSource,
//   });

//   @override
//   Future<Either<AppError, NotificationEntity>> getNotifications(
//     GetNotificationsParams params,
//   ) async {
//     try {
//       final responseModel = await remoteDataSource.fetchNotifications(params);
//       return Right(responseModel.toEntity());
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, void>> markAsRead(String id) async {
//     try {
//       await remoteDataSource.markAsRead(id);
//       return const Right(null);
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, void>> markAllAsRead() async {
//     try {
//       await remoteDataSource.markAllAsRead();
//       return const Right(null);
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, void>> deleteNotification(String id) async {
//     try {
//       await remoteDataSource.deleteNotification(id);
//       return const Right(null);
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, void>> clearAllNotifications() async {
//     try {
//       await remoteDataSource.clearAllNotifications();
//       return const Right(null);
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   // ==========================================================================
//   // 🚀 REAL-TIME STREAM PIPELINE HANDLING
//   // ==========================================================================

//   @override
//   Stream<NotificationItemEntity> initializeLiveNotificationStream(
//     String userId,
//     String token,
//   ) {
//     return webSocketSource
//         .listenToLiveNotifications(userId, token)
//         .map((model) => model.toEntity())
//         .handleError((error) async {
//           // 🛡️ Catch stream-level network failures or malformed packet anomalies safely
//           final appError = await ErrorHandler.handle(error);
//           throw appError;
//         });
//   }

//   @override
//   Future<Either<AppError, void>> updateFcmToken(
//     UpdateFcmTokenParams params,
//   ) async {
//     try {
//       await remoteDataSource.updateFcmToken(params);
//       return const Right(null);
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   void disposeWebSocketStream() {
//     webSocketSource.disconnect();
//   }
// }

import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_handler.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/notification_item_entity.dart';
import '../../domain/repositories/notification_repository.dart';
import '../../domain/usecases/params/get_notifications_params.dart';
import '../../domain/usecases/params/toggle_notification_params.dart';
import '../../domain/usecases/params/update_fcm_token_params.dart';
import '../datasources/notification_remote_data_source.dart';
import '../datasources/notification_websocket_source.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;
  final NotificationWebSocketSource webSocketSource;

  NotificationRepositoryImpl({
    required this.remoteDataSource,
    required this.webSocketSource,
  });

  @override
  Future<Either<AppError, NotificationEntity>> getNotifications(
    GetNotificationsParams params,
  ) async {
    try {
      final responseModel = await remoteDataSource.fetchNotifications(params);
      return Right(responseModel.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, void>> markAsRead(String id) async {
    try {
      await remoteDataSource.markAsRead(id);
      return const Right(null);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, void>> markAllAsRead() async {
    try {
      await remoteDataSource.markAllAsRead();
      return const Right(null);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, void>> deleteNotification(String id) async {
    try {
      await remoteDataSource.deleteNotification(id);
      return const Right(null);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, void>> clearAllNotifications() async {
    try {
      await remoteDataSource.clearAllNotifications();
      return const Right(null);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  // ==========================================================================
  // 🚀 REAL-TIME STREAM PIPELINE HANDLING
  // ==========================================================================

  @override
  Stream<NotificationItemEntity> initializeLiveNotificationStream(
    String userId,
    String token,
  ) {
    return webSocketSource
        .listenToLiveNotifications(userId, token)
        .map((model) => model.toEntity())
        .handleError((error) async {
          // 🛡️ Catch stream-level network failures or malformed packet anomalies safely
          final appError = await ErrorHandler.handle(error);
          throw appError;
        });
  }

  @override
  Future<Either<AppError, void>> updateFcmToken(
    UpdateFcmTokenParams params,
  ) async {
    try {
      await remoteDataSource.updateFcmToken(params);
      return const Right(null);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  // 🎯 FIXED: Try/Catch now lives in the Data Layer, returning Right(null) or Left(AppError)
  @override
  Future<Either<AppError, void>> disposeWebSocketStream() async {
    try {
      webSocketSource.disconnect();
      return const Right(null);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, void>> toggleNotificationPreference(
    ToggleNotificationParams params,
  ) async {
    try {
      await remoteDataSource.toggleNotificationPreference(params);
      return const Right(null);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }
}
