import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_handler.dart';
import '../../domain/entities/open_job_request_entity.dart';
import '../../domain/repositories/marketplace_repository.dart';
import '../../domain/usecases/params/marketplace_pagination_params.dart';
import '../../domain/usecases/params/place_bid_params.dart';
import '../datasources/marketplace_remote_data_source.dart';

class MarketplaceRepositoryImpl implements MarketplaceRepository {
  final MarketplaceRemoteDataSource remoteDataSource;
  MarketplaceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppError, List<OpenJobRequestEntity>>> exploreOpenJobs(
    MarketplacePaginationParams params,
  ) async {
    try {
      final models = await remoteDataSource.exploreOpenJobs(params);
      // 🎯 STRICT MAPPING: Explicitly calls toEntity()
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, void>> placeBid(PlaceBidParams params) async {
    try {
      await remoteDataSource.placeBid(params);
      return const Right(null);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }
}
