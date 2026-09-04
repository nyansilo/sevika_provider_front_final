import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../entities/open_job_request_entity.dart';
import '../usecases/params/marketplace_pagination_params.dart';
import '../usecases/params/place_bid_params.dart';

abstract class MarketplaceRepository {
  Future<Either<AppError, List<OpenJobRequestEntity>>> exploreOpenJobs(
    MarketplacePaginationParams params,
  );
  Future<Either<AppError, void>> placeBid(PlaceBidParams params);
}
