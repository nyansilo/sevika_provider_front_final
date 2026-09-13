import '../../domain/entities/pagination_entity.dart';

class PaginationModel extends PaginationEntity {
  const PaginationModel({
    required super.total,
    required super.count,
    required super.perPage,
    required super.currentPage,
    required super.lastPage,
    required super.hasMore,
  });

  PaginationEntity toEntity() => this;

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    // 🎯 Helper for camelCase and snake_case API flexibility
    int parse(String camel, String snake, int fallback) {
      if (json[camel] != null) {
        return num.tryParse(json[camel].toString())?.toInt() ?? fallback;
      }
      if (json[snake] != null) {
        return num.tryParse(json[snake].toString())?.toInt() ?? fallback;
      }
      return fallback;
    }

    final total = parse('total', 'total', 0);
    final currentPage = parse('currentPage', 'current_page', 1);
    final lastPage = parse('lastPage', 'last_page', 1);

    return PaginationModel(
      total: total,
      count: parse('count', 'count', 0),
      perPage: parse('perPage', 'per_page', 15),
      currentPage: currentPage,
      lastPage: lastPage,
      hasMore: json['hasMore'] is bool
          ? json['hasMore']
          : (currentPage < lastPage),
    );
  }
}
