// lib/features/analytics/data/models/provider_analytics_trends_model.dart
import '../../domain/entities/provider_analytics_trends_entity.dart';

class ProviderAnalyticsTrendsModel extends ProviderAnalyticsTrendsEntity {
  const ProviderAnalyticsTrendsModel({
    required super.earnings,
    required super.jobs,
    required super.views,
    required super.cancellationRate,
  });

  factory ProviderAnalyticsTrendsModel.fromJson(Map<String, dynamic> json) {
    return ProviderAnalyticsTrendsModel(
      earnings: json['earnings']?.toString() ?? '0%',
      jobs: json['jobs']?.toString() ?? '0%',
      views: json['views']?.toString() ?? '0%',
      cancellationRate: json['cancellationRate']?.toString() ?? '0%',
    );
  }

  ProviderAnalyticsTrendsEntity toEntity() {
    return ProviderAnalyticsTrendsEntity(
      earnings: earnings,
      jobs: jobs,
      views: views,
      cancellationRate: cancellationRate,
    );
  }
}
