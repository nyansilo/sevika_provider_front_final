import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../entities/provider_catalog_response_entity.dart';
import '../repositories/provider_service_repository.dart';
import 'params/catalog_pagination_params.dart';

class GetProviderCatalogUseCase {
  final ProviderServiceRepository repository;
  GetProviderCatalogUseCase(this.repository);

  Future<Either<AppError, ProviderCatalogResponseEntity>> call(
    CatalogPaginationParams params,
  ) {
    return repository.getCatalog(params);
  }
}
