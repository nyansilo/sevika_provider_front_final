import 'package:equatable/equatable.dart';
import '../../../../../core/errors/app_error.dart';
import '../../../domain/entities/notification_item_entity.dart';
import '../../../domain/entities/notification_pagination_entity.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {
  const NotificationsInitial();
}

class NotificationsFirstPageLoading extends NotificationsState {
  const NotificationsFirstPageLoading();
}

class NotificationsLoadSuccess extends NotificationsState {
  final List<NotificationItemEntity> notifications;
  final int unreadCount;
  final NotificationPaginationEntity pagination;
  final bool isMoreLoading;

  const NotificationsLoadSuccess({
    required this.notifications,
    required this.unreadCount,
    required this.pagination,
    this.isMoreLoading = false,
  });

  NotificationsLoadSuccess copyWith({
    List<NotificationItemEntity>? notifications,
    int? unreadCount,
    NotificationPaginationEntity? pagination,
    bool? isMoreLoading,
  }) {
    return NotificationsLoadSuccess(
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      pagination: pagination ?? this.pagination,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
    );
  }

  @override
  List<Object?> get props => [
    notifications,
    unreadCount,
    pagination,
    isMoreLoading,
  ];
}

class NotificationsLoadFailure extends NotificationsState {
  final AppError error;

  const NotificationsLoadFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

// ==========================================================================
// 🚀 Dynamic Action Lifecycle Mutation States
// ==========================================================================
class NotificationActionSuccess extends NotificationsState {
  const NotificationActionSuccess();
}

class NotificationActionFailure extends NotificationsState {
  final AppError error;

  const NotificationActionFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
