// import '../../domain/entities/provider_review_metrics_entity.dart';
// import '../../domain/entities/provider_review_pagination_entity.dart';
// import '../../domain/entities/provider_review_response_entity.dart';
// import 'provider_review_item_model.dart';

// class ProviderReviewResponseModel extends ProviderReviewResponseEntity {
//   const ProviderReviewResponseModel({
//     required super.reviews,
//     required super.metrics,
//     required super.pagination,
//   });

//   factory ProviderReviewResponseModel.fromMap(
//     Map<String, dynamic> rootJson,
//     List<Map<String, dynamic>> extractedReviews,
//   ) {
//     // Safely un-nest the Laravel 'data' wrapper
//     final targetJson = rootJson['data'] is Map<String, dynamic>
//         ? rootJson['data'] as Map<String, dynamic>
//         : rootJson;

//     final metaBlock = targetJson['meta'] as Map<String, dynamic>? ?? {};
//     final metricsBlock =
//         metaBlock['businessMetrics'] as Map<String, dynamic>? ?? {};
//     final paginationBlock =
//         metaBlock['pagination'] as Map<String, dynamic>? ?? {};

//     return ProviderReviewResponseModel(
//       reviews: extractedReviews
//           .map((e) => ProviderReviewItemModel.fromJson(e))
//           .toList(),
//       metrics: ProviderReviewMetricsEntity(
//         averageRating:
//             (metricsBlock['averageRating'] as num?)?.toDouble() ?? 5.0,
//         totalReviewCount: metricsBlock['totalReviewCount'] as int? ?? 0,
//       ),
//       pagination: ProviderReviewPaginationEntity(
//         currentPage: paginationBlock['currentPage'] as int? ?? 1,
//         hasMore: paginationBlock['hasMore'] as bool? ?? false,
//       ),
//     );
//   }
// }

// lib/features/reviews/data/models/provider_review_response_model.dart
import '../../domain/entities/provider_review_metrics_entity.dart';
import '../../domain/entities/provider_review_pagination_entity.dart';
import '../../domain/entities/provider_review_response_entity.dart';
import 'provider_review_item_model.dart';

class ProviderReviewResponseModel extends ProviderReviewResponseEntity {
  const ProviderReviewResponseModel({
    required super.reviews,
    required super.metrics,
    required super.pagination,
  });

  factory ProviderReviewResponseModel.fromMap(
    Map<String, dynamic> rootJson,
    List<Map<String, dynamic>> extractedReviews,
  ) {
    // Safely un-nest the Laravel 'data' wrapper
    final targetJson = rootJson['data'] is Map<String, dynamic>
        ? rootJson['data'] as Map<String, dynamic>
        : rootJson;

    final metaBlock = targetJson['meta'] as Map<String, dynamic>? ?? {};
    final metricsBlock =
        metaBlock['businessMetrics'] as Map<String, dynamic>? ?? {};
    final paginationBlock =
        metaBlock['pagination'] as Map<String, dynamic>? ?? {};

    return ProviderReviewResponseModel(
      reviews: extractedReviews
          .map((e) => ProviderReviewItemModel.fromJson(e))
          .toList(),
      metrics: ProviderReviewMetricsEntity(
        averageRating:
            (metricsBlock['averageRating'] as num?)?.toDouble() ?? 5.0,
        totalReviewCount: metricsBlock['totalReviewCount'] as int? ?? 0,
      ),
      pagination: ProviderReviewPaginationEntity(
        currentPage: paginationBlock['currentPage'] as int? ?? 1,
        hasMore: paginationBlock['hasMore'] as bool? ?? false,
      ),
    );
  }

  /// 🚀 Explicit conversion to Entity for architectural safety
  ProviderReviewResponseEntity toEntity() {
    return ProviderReviewResponseEntity(
      reviews: reviews
          .map((item) => (item as ProviderReviewItemModel).toEntity())
          .toList(),
      metrics: metrics,
      pagination: pagination,
    );
  }
}
