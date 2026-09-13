// lib/features/analytics/presentation/cubits/analytics_state.dart
import 'package:equatable/equatable.dart';

import '../../../../core/errors/app_error.dart';
import '../../domain/entities/provider_analytics_entity.dart';

abstract class AnalyticsState extends Equatable {
  const AnalyticsState();

  @override
  List<Object?> get props => [];
}

class AnalyticsInitial extends AnalyticsState {
  const AnalyticsInitial();
}

class AnalyticsLoading extends AnalyticsState {
  const AnalyticsLoading();
}

class AnalyticsLoadSuccess extends AnalyticsState {
  final ProviderAnalyticsEntity analytics;

  const AnalyticsLoadSuccess({required this.analytics});

  @override
  List<Object?> get props => [analytics];
}

class AnalyticsLoadFailure extends AnalyticsState {
  final AppError error;

  const AnalyticsLoadFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
