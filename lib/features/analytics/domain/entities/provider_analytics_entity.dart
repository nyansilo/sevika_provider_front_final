// lib/features/analytics/domain/entities/provider_analytics_entity.dart
import 'package:equatable/equatable.dart';

import 'provider_analytics_trends_entity.dart';

class ProviderAnalyticsEntity extends Equatable {
  final String timeframe;
  final double totalEarnings;
  final int jobsCompleted;
  final int profileViews;
  final double cancellationRate;
  final double customerRating;
  final int totalReviews;
  final double responseRate;
  final double onTimeArrival;
  final ProviderAnalyticsTrendsEntity trends;

  const ProviderAnalyticsEntity({
    required this.timeframe,
    required this.totalEarnings,
    required this.jobsCompleted,
    required this.profileViews,
    required this.cancellationRate,
    required this.customerRating,
    required this.totalReviews,
    required this.responseRate,
    required this.onTimeArrival,
    required this.trends,
  });

  @override
  List<Object?> get props => [
    timeframe,
    totalEarnings,
    jobsCompleted,
    profileViews,
    cancellationRate,
    customerRating,
    totalReviews,
    responseRate,
    onTimeArrival,
    trends,
  ];
}
