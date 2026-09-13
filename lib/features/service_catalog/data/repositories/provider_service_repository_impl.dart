import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_handler.dart';
import '../../domain/entities/provider_service_entity.dart';
import '../../domain/entities/provider_catalog_response_entity.dart';
import '../../domain/repositories/provider_service_repository.dart';
import '../../domain/usecases/params/catalog_pagination_params.dart';
import '../../domain/usecases/params/propose_service_params.dart';
import '../../domain/usecases/params/update_offering_params.dart';
import '../datasources/provider_service_remote_datasource.dart';

class ProviderServiceRepositoryImpl implements ProviderServiceRepository {
  final ProviderServiceRemoteDataSource remoteDataSource;

  ProviderServiceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppError, ProviderCatalogResponseEntity>> getCatalog(
    CatalogPaginationParams params,
  ) async {
    try {
      final responseModel = await remoteDataSource.fetchCatalog(params);
      return Right(responseModel.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, ProviderServiceEntity>> proposeService(
    ProposeServiceParams params,
  ) async {
    try {
      final model = await remoteDataSource.proposeService(params);
      return Right(model.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, ProviderServiceEntity>> updateOffering(
    UpdateOfferingParams params,
  ) async {
    try {
      final model = await remoteDataSource.updateOffering(params);
      return Right(model.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, String>> deleteOffering(String serviceId) async {
    try {
      final message = await remoteDataSource.deleteOffering(serviceId);
      return Right(message);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }
}
