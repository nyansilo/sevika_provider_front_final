// lib/features/analytics/presentation/cubits/analytics_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_provider_analytics_usecase.dart';
import '../../domain/usecases/params/get_provider_analytics_params.dart';
import 'analytics_state.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  final GetProviderAnalyticsUseCase getAnalyticsUseCase;

  AnalyticsCubit({required this.getAnalyticsUseCase})
    : super(const AnalyticsInitial());

  /// 🚀 Loads analytics and handles timeframe filtering ('thisMonth', 'thisWeek', 'thisYear', 'allTime')
  Future<void> loadAnalytics({String timeframe = 'thisMonth'}) async {
    emit(const AnalyticsLoading());

    final result = await getAnalyticsUseCase.call(
      GetProviderAnalyticsParams(timeframe: timeframe),
    );

    if (isClosed) return;

    result.fold(
      (error) => emit(AnalyticsLoadFailure(error: error)),
      (analytics) => emit(AnalyticsLoadSuccess(analytics: analytics)),
    );
  }
}
