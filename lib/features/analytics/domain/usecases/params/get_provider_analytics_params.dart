// lib/features/analytics/domain/usecases/params/get_provider_analytics_params.dart
import 'package:equatable/equatable.dart';

class GetProviderAnalyticsParams extends Equatable {
  final String timeframe;

  const GetProviderAnalyticsParams({this.timeframe = 'thisMonth'});

  Map<String, dynamic> toQueryParameters() => {'timeframe': timeframe};

  @override
  List<Object?> get props => [timeframe];
}
