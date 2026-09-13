// lib/features/analytics/domain/usecases/get_provider_analytics_usecase.dart
import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/provider_analytics_entity.dart';
import '../repositories/provider_analytics_repository.dart';
import 'params/get_provider_analytics_params.dart';

class GetProviderAnalyticsUseCase
    implements UseCase<ProviderAnalyticsEntity, GetProviderAnalyticsParams> {
  final ProviderAnalyticsRepository repository;

  GetProviderAnalyticsUseCase(this.repository);

  @override
  Future<Either<AppError, ProviderAnalyticsEntity>> call(
    GetProviderAnalyticsParams params,
  ) async {
    return await repository.getAnalytics(params);
  }
}
