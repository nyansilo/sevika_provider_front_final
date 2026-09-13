import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../entities/provider_service_entity.dart';
import '../entities/provider_catalog_response_entity.dart';
import '../usecases/params/catalog_pagination_params.dart';
import '../usecases/params/propose_service_params.dart';
import '../usecases/params/update_offering_params.dart';

abstract class ProviderServiceRepository {
  Future<Either<AppError, ProviderCatalogResponseEntity>> getCatalog(
    CatalogPaginationParams params,
  );
  Future<Either<AppError, ProviderServiceEntity>> proposeService(
    ProposeServiceParams params,
  );
  Future<Either<AppError, ProviderServiceEntity>> updateOffering(
    UpdateOfferingParams params,
  );
  Future<Either<AppError, String>> deleteOffering(String serviceId);
}
