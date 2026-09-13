// lib/features/analytics/domain/entities/provider_analytics_trends_entity.dart
import 'package:equatable/equatable.dart';

class ProviderAnalyticsTrendsEntity extends Equatable {
  final String earnings;
  final String jobs;
  final String views;
  final String cancellationRate;

  const ProviderAnalyticsTrendsEntity({
    required this.earnings,
    required this.jobs,
    required this.views,
    required this.cancellationRate,
  });

  @override
  List<Object?> get props => [earnings, jobs, views, cancellationRate];
}
