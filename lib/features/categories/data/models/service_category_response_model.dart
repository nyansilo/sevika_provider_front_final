import 'service_category_model.dart';

class ServiceCategoryResponseModel {
  final List<ServiceCategoryModel> categories;
  final int totalActiveCategories;
  final String systemTimestamp;
  final bool success;

  ServiceCategoryResponseModel({
    required this.categories,
    required this.totalActiveCategories,
    required this.systemTimestamp,
    required this.success,
  });

  factory ServiceCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    final bool isSuccess = json['success'] as bool? ?? true;
    final Map<String, dynamic> targetJson =
        (json['data'] is Map<String, dynamic>)
        ? json['data'] as Map<String, dynamic>
        : json;

    final List<ServiceCategoryModel> categoriesList = [];
    final dynamic rawCategories =
        targetJson['categories'] ?? json['categories'];

    if (rawCategories is List) {
      for (final item in rawCategories) {
        if (item is Map<String, dynamic>) {
          categoriesList.add(ServiceCategoryModel.fromJson(item));
        }
      }
    }

    final Map<String, dynamic> meta = targetJson['meta'] is Map<String, dynamic>
        ? targetJson['meta'] as Map<String, dynamic>
        : (json['meta'] is Map<String, dynamic>
              ? json['meta'] as Map<String, dynamic>
              : const {});

    return ServiceCategoryResponseModel(
      success: isSuccess,
      categories: categoriesList,
      totalActiveCategories:
          meta['totalActiveCategories'] as int? ??
          meta['featuredCount'] as int? ??
          categoriesList.length,
      systemTimestamp:
          meta['systemTimestamp']?.toString() ??
          DateTime.now().toIso8601String(),
    );
  }
}
