// lib/features/analytics/domain/repositories/provider_analytics_repository.dart
import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../entities/provider_analytics_entity.dart';
import '../usecases/params/get_provider_analytics_params.dart';

abstract class ProviderAnalyticsRepository {
  Future<Either<AppError, ProviderAnalyticsEntity>> getAnalytics(
    GetProviderAnalyticsParams params,
  );
}
