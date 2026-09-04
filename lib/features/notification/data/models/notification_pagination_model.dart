import '../../domain/entities/notification_pagination_entity.dart';

class NotificationPaginationModel extends NotificationPaginationEntity {
  const NotificationPaginationModel({
    required super.total,
    required super.count,
    required super.perPage,
    required super.currentPage,
    required super.lastPage,
    required super.hasNextPage,
  });

  factory NotificationPaginationModel.fromJson(Map<String, dynamic> json) {
    return NotificationPaginationModel(
      total: json['total'] as int? ?? 0,
      count: json['count'] as int? ?? 0,
      perPage: json['perPage'] as int? ?? 25,
      currentPage: json['currentPage'] as int? ?? 1,
      lastPage: json['lastPage'] as int? ?? 1,
      // 🎯 FIX: JSON uses 'hasMore', mapping it to the entity's 'hasNextPage'
      hasNextPage:
          json['hasMore'] as bool? ?? json['hasNextPage'] as bool? ?? false,
    );
  }
}
