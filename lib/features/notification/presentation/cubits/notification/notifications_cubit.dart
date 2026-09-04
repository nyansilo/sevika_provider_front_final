import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/notification_item_entity.dart';
import '../../../domain/entities/notification_pagination_entity.dart';
import '../../../domain/usecases/get_notifications_use_case.dart';
import '../../../domain/usecases/mark_all_as_read_use_case.dart';
import '../../../domain/usecases/mark_as_read_use_case.dart';
import '../../../domain/usecases/delete_notification_use_case.dart';
import '../../../domain/usecases/clear_all_notifications_use_case.dart';

import '../../../domain/usecases/disconnect_live_notifications_use_case.dart';
import '../../../domain/usecases/params/get_notifications_params.dart';
import '../../../domain/usecases/listen_live_notifications_use_case.dart';
import '../../../domain/usecases/params/live_stream_params.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkAsReadUseCase markAsReadUseCase;
  final MarkAllAsReadUseCase markAllAsReadUseCase;
  final DeleteNotificationUseCase deleteNotificationUseCase;
  final ClearAllNotificationsUseCase clearAllNotificationsUseCase;
  final ListenLiveNotificationsUseCase listenLiveNotificationsUseCase;
  final DisconnectLiveNotificationsUseCase disconnectLiveNotificationsUseCase;

  StreamSubscription<NotificationItemEntity>? _liveNotificationSubscription;

  NotificationsCubit({
    required this.getNotificationsUseCase,
    required this.markAsReadUseCase,
    required this.markAllAsReadUseCase,
    required this.deleteNotificationUseCase,
    required this.clearAllNotificationsUseCase,
    required this.listenLiveNotificationsUseCase,
    required this.disconnectLiveNotificationsUseCase,
  }) : super(const NotificationsInitial());

  bool _isLiveListening = false; // 🎯 ADD THIS LOCK

  /// 🛠️ Establish real-time persistent event listener channel
  void initLiveNotificationListener({
    required String userId,
    required String token,
  }) {
    // 🎯 PREVENT DOUBLE CONNECTIONS: If already listening, do nothing.
    if (_isLiveListening) {
      debugPrint(
        '🛡️ Notifications WS is already running. Skipping duplicate connection.',
      );
      return;
    }

    _isLiveListening = true;
    _liveNotificationSubscription?.cancel();

    final streamParams = LiveStreamParams(userId: userId, token: token);

    _liveNotificationSubscription = listenLiveNotificationsUseCase
        .call(streamParams)
        .listen(
          (liveEntity) {
            final currentState = state;

            if (currentState is NotificationsLoadSuccess) {
              // Prevent duplicate event attachments
              if (currentState.notifications.any(
                (n) => n.id == liveEntity.id,
              )) {
                return;
              }

              final List<NotificationItemEntity> updatedList = List.from(
                currentState.notifications,
              )..insert(0, liveEntity);

              emit(
                currentState.copyWith(
                  notifications: updatedList,
                  unreadCount:
                      currentState.unreadCount + 1, // 🎯 Triggers the Pop-up!
                ),
              );
            } else {
              emit(
                NotificationsLoadSuccess(
                  notifications: [liveEntity],
                  unreadCount: 1,
                  pagination: const NotificationPaginationEntity(
                    currentPage: 1,
                    perPage: 25,
                    hasNextPage: false,
                    total: 1,
                    count: 1,
                    lastPage: 1,
                  ),
                ),
              );
            }
          },
          onError: (error) {
            debugPrint('⚠️ Live Notification Stream Error: $error');
            _isLiveListening = false; // 🎯 FIX: Allow it to try reconnecting!
          },
          onDone: () {
            debugPrint(
              '⚠️ 🛑 Live Notification Stream was Closed/Disconnected!',
            );
            _isLiveListening = false; // 🎯 FIX: Reset lock if the socket drops!
          },
        );
  }

  // 💡 THE FIX: Preserves incoming websocket events during background first-page history pulls
  Future<void> loadNotifications({int perPage = 25}) async {
    final currentState = state;
    List<NotificationItemEntity> cachedLiveItems = [];
    int cachedUnreadCount = 0;

    // Capture early real-time payloads if they arrived before this network query executed
    if (currentState is NotificationsLoadSuccess) {
      cachedLiveItems = List.from(currentState.notifications);
      cachedUnreadCount = currentState.unreadCount;
    }

    emit(const NotificationsFirstPageLoading());
    final params = GetNotificationsParams(perPage: perPage, page: 1);
    final result = await getNotificationsUseCase.call(params);

    result.fold((appError) => emit(NotificationsLoadFailure(error: appError)), (
      entity,
    ) {
      // 🚀 MERGE ACTION: Combine local temporary memory stream items with remote DB history
      final List<NotificationItemEntity> mergedList = List.from(
        cachedLiveItems,
      );

      for (var historicalItem in entity.notifications) {
        if (!mergedList.any((n) => n.id == historicalItem.id)) {
          mergedList.add(historicalItem);
        }
      }

      emit(
        NotificationsLoadSuccess(
          notifications: mergedList,
          unreadCount: entity.unreadCount + cachedUnreadCount,
          pagination: entity.pagination,
        ),
      );
    });
  }

  Future<void> markNotificationAsRead(String id) async {
    final currentState = state;
    if (currentState is! NotificationsLoadSuccess) return;

    final targetIndex = currentState.notifications.indexWhere(
      (n) => n.id == id,
    );
    if (targetIndex == -1 || currentState.notifications[targetIndex].isRead) {
      return;
    }

    // Optimistic memory tracking list update
    final updatedNotifications = currentState.notifications.map((notification) {
      if (notification.id == id) {
        return NotificationItemEntity(
          id: notification.id,
          type: notification.type,
          data: notification.data,
          readAt: DateTime.now().toIso8601String(),
          createdAt: notification.createdAt,
        );
      }
      return notification;
    }).toList();

    final int dynamicUnreadCount = (currentState.unreadCount > 0)
        ? currentState.unreadCount - 1
        : 0;

    emit(
      currentState.copyWith(
        notifications: updatedNotifications,
        unreadCount: dynamicUnreadCount,
      ),
    );

    final result = await markAsReadUseCase.call(id);
    result.fold(
      (appError) {
        // Rollback state mapping safely on failure
        emit(currentState);
        emit(NotificationActionFailure(error: appError));
      },
      (_) => null, // Keep current list state intact
    );
  }

  Future<void> markAllNotificationsAsRead() async {
    final currentState = state;
    if (currentState is! NotificationsLoadSuccess ||
        currentState.unreadCount == 0) {
      return;
    }

    final updatedNotifications = currentState.notifications.map((notification) {
      if (!notification.isRead) {
        return NotificationItemEntity(
          id: notification.id,
          type: notification.type,
          data: notification.data,
          readAt: DateTime.now().toIso8601String(),
          createdAt: notification.createdAt,
        );
      }
      return notification;
    }).toList();

    emit(
      currentState.copyWith(
        notifications: updatedNotifications,
        unreadCount: 0,
      ),
    );

    final result = await markAllAsReadUseCase.call(NoParams());
    result.fold(
      (appError) {
        emit(currentState); // Rollback state mapping safely on failure
        emit(NotificationActionFailure(error: appError));
      },
      (_) => null, // Keep current list state intact
    );
  }

  Future<void> removeSingleNotification(String id) async {
    final currentState = state;
    if (currentState is! NotificationsLoadSuccess) return;

    final targetNotification = currentState.notifications.firstWhere(
      (n) => n.id == id,
    );
    final bool wasUnread = !targetNotification.isRead;

    // Optimistic single-row slice modification layout update
    final filteredNotifications = currentState.notifications
        .where((n) => n.id != id)
        .toList();
    final int dynamicUnreadCount = wasUnread && currentState.unreadCount > 0
        ? currentState.unreadCount - 1
        : currentState.unreadCount;

    emit(
      currentState.copyWith(
        notifications: filteredNotifications,
        unreadCount: dynamicUnreadCount,
      ),
    );

    final result = await deleteNotificationUseCase.call(id);
    result.fold(
      (appError) {
        emit(currentState); // Rollback state mapping safely on failure
        emit(NotificationActionFailure(error: appError));
      },
      (_) => null, // Keep current sliced list state intact
    );
  }

  Future<void> clearAllNotificationHistory() async {
    final currentState = state;
    if (currentState is! NotificationsLoadSuccess) return;

    // Optimistic complete collection wipe update
    emit(currentState.copyWith(notifications: const [], unreadCount: 0));

    final result = await clearAllNotificationsUseCase.call(NoParams());
    result.fold(
      (appError) {
        emit(currentState); // Rollback state mapping safely on failure
        emit(NotificationActionFailure(error: appError));
      },
      (_) => null, // Keep empty list state intact
    );
  }

  @override
  Future<void> close() {
    debugPrint(
      '💀 [NOTIFICATIONS CUBIT] Cubit is closing, but leaving WS alive for background notifications!',
    );
    _isLiveListening = false;
    _liveNotificationSubscription?.cancel();

    // 🎯 FIX: We removed `disconnectLiveNotificationsUseCase.call();`
    // This prevents Flutter UI rebuilds from severing the global notification WebSocket!

    return super.close();
  }
}
