import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/open_job_request_entity.dart';
import '../repositories/marketplace_repository.dart';
import 'params/marketplace_pagination_params.dart';

class ExploreOpenJobsUseCase
    implements
        UseCase<List<OpenJobRequestEntity>, MarketplacePaginationParams> {
  final MarketplaceRepository repository;
  ExploreOpenJobsUseCase(this.repository);

  @override
  Future<Either<AppError, List<OpenJobRequestEntity>>> call(
    MarketplacePaginationParams params,
  ) async {
    return await repository.exploreOpenJobs(params);
  }
}
