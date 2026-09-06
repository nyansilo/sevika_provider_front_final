import 'package:equatable/equatable.dart';

import '../../../../core/errors/app_error.dart';
import '../../domain/entities/provider_review_item_entity.dart';
import '../../domain/entities/provider_review_metrics_entity.dart';
import '../../domain/entities/provider_review_pagination_entity.dart';

abstract class ProviderReviewsState extends Equatable {
  const ProviderReviewsState();

  @override
  List<Object?> get props => [];
}

class ProviderReviewsInitial extends ProviderReviewsState {
  const ProviderReviewsInitial();
}

class ProviderReviewsLoading extends ProviderReviewsState {
  const ProviderReviewsLoading();
}

class ProviderReviewsLoadSuccess extends ProviderReviewsState {
  final List<ProviderReviewItemEntity> reviews;
  final ProviderReviewMetricsEntity metrics;
  final ProviderReviewPaginationEntity pagination;
  final bool isMoreLoading;

  const ProviderReviewsLoadSuccess({
    required this.reviews,
    required this.metrics,
    required this.pagination,
    this.isMoreLoading = false,
  });

  ProviderReviewsLoadSuccess copyWith({
    List<ProviderReviewItemEntity>? reviews,
    ProviderReviewMetricsEntity? metrics,
    ProviderReviewPaginationEntity? pagination,
    bool? isMoreLoading,
  }) {
    return ProviderReviewsLoadSuccess(
      reviews: reviews ?? this.reviews,
      metrics: metrics ?? this.metrics,
      pagination: pagination ?? this.pagination,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
    );
  }

  @override
  List<Object?> get props => [reviews, metrics, pagination, isMoreLoading];
}

class ProviderReviewsLoadFailure extends ProviderReviewsState {
  final AppError error;

  const ProviderReviewsLoadFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class ProviderReviewReplyLoading extends ProviderReviewsState {
  const ProviderReviewReplyLoading();
}

class ProviderReviewReplySuccess extends ProviderReviewsState {
  const ProviderReviewReplySuccess();
}

class ProviderReviewReplyFailure extends ProviderReviewsState {
  final AppError error;

  const ProviderReviewReplyFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
