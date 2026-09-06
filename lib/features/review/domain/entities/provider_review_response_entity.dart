import 'package:equatable/equatable.dart';

import 'provider_review_item_entity.dart';
import 'provider_review_metrics_entity.dart';
import 'provider_review_pagination_entity.dart';

class ProviderReviewResponseEntity extends Equatable {
  final List<ProviderReviewItemEntity> reviews;
  final ProviderReviewMetricsEntity metrics;
  final ProviderReviewPaginationEntity pagination;

  const ProviderReviewResponseEntity({
    required this.reviews,
    required this.metrics,
    required this.pagination,
  });

  @override
  List<Object?> get props => [reviews, metrics, pagination];
}
