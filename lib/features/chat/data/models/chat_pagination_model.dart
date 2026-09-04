import '../../domain/entities/chat_pagination_entity.dart';

class ChatPaginationModel extends ChatPaginationEntity {
  const ChatPaginationModel({
    required super.total,
    required super.count,
    required super.perPage,
    required super.currentPage,
    required super.lastPage,
    required super.hasMore,
  });

  factory ChatPaginationModel.fromJson(Map<String, dynamic> json) {
    return ChatPaginationModel(
      total: json['total'] as int? ?? 0,
      count: json['count'] as int? ?? 0,
      perPage: json['perPage'] as int? ?? json['per_page'] as int? ?? 20,
      currentPage:
          json['currentPage'] as int? ?? json['current_page'] as int? ?? 1,
      lastPage: json['lastPage'] as int? ?? json['last_page'] as int? ?? 1,
      hasMore: json['hasMore'] as bool? ?? json['has_more'] as bool? ?? false,
    );
  }
}
