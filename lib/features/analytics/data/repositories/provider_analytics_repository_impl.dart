// lib/features/analytics/data/repositories/provider_analytics_repository_impl.dart
import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_handler.dart';
import '../../domain/entities/provider_analytics_entity.dart';
import '../../domain/repositories/provider_analytics_repository.dart';
import '../../domain/usecases/params/get_provider_analytics_params.dart';
import '../datasources/provider_analytics_remote_data_source.dart';

class ProviderAnalyticsRepositoryImpl implements ProviderAnalyticsRepository {
  final ProviderAnalyticsRemoteDataSource remoteDataSource;

  ProviderAnalyticsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppError, ProviderAnalyticsEntity>> getAnalytics(
    GetProviderAnalyticsParams params,
  ) async {
    try {
      final responseModel = await remoteDataSource.fetchAnalytics(params);
      // 🚀 Explicit conversion using .toEntity()
      return Right(responseModel.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }
}
