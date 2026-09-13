// lib/features/analytics/data/models/provider_analytics_model.dart
import '../../domain/entities/provider_analytics_entity.dart';
import 'provider_analytics_trends_model.dart';

class ProviderAnalyticsModel extends ProviderAnalyticsEntity {
  const ProviderAnalyticsModel({
    required super.timeframe,
    required super.totalEarnings,
    required super.jobsCompleted,
    required super.profileViews,
    required super.cancellationRate,
    required super.customerRating,
    required super.totalReviews,
    required super.responseRate,
    required super.onTimeArrival,
    required super.trends,
  });

  factory ProviderAnalyticsModel.fromJson(Map<String, dynamic> json) {
    final trendsJson = json['trends'] is Map<String, dynamic>
        ? json['trends'] as Map<String, dynamic>
        : <String, dynamic>{};

    return ProviderAnalyticsModel(
      timeframe: json['timeframe']?.toString() ?? 'this_month',
      totalEarnings: (json['totalEarnings'] as num?)?.toDouble() ?? 0.0,
      jobsCompleted: (json['jobsCompleted'] as num?)?.toInt() ?? 0,
      profileViews: (json['profileViews'] as num?)?.toInt() ?? 0,
      cancellationRate: (json['cancellationRate'] as num?)?.toDouble() ?? 0.0,
      customerRating: (json['customerRating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: (json['totalReviews'] as num?)?.toInt() ?? 0,
      responseRate: (json['responseRate'] as num?)?.toDouble() ?? 0.0,
      onTimeArrival: (json['onTimeArrival'] as num?)?.toDouble() ?? 100.0,
      trends: ProviderAnalyticsTrendsModel.fromJson(trendsJson),
    );
  }

  /// 🚀 Explicit conversion to Entity for architectural safety
  ProviderAnalyticsEntity toEntity() {
    return ProviderAnalyticsEntity(
      timeframe: timeframe,
      totalEarnings: totalEarnings,
      jobsCompleted: jobsCompleted,
      profileViews: profileViews,
      cancellationRate: cancellationRate,
      customerRating: customerRating,
      totalReviews: totalReviews,
      responseRate: responseRate,
      onTimeArrival: onTimeArrival,
      trends: (trends as ProviderAnalyticsTrendsModel).toEntity(),
    );
  }
}
