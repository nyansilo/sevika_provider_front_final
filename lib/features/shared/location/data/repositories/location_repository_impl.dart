import 'package:dartz/dartz.dart';
import '../../../../../core/errors/app_error.dart';
import '../../../../../core/errors/error_handler.dart';
import '../../domain/entities/location_boundaries_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_remote_data_source.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource remoteDataSource;

  LocationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppError, LocationBoundariesEntity>>
  fetchAdministrativeBoundaries() async {
    try {
      final responseModel = await remoteDataSource
          .fetchAdministrativeBoundaries();

      final entity = LocationBoundariesEntity(
        regions: responseModel.regions.map((m) => m.toEntity()).toList(),
        districts: responseModel.districts.map((m) => m.toEntity()).toList(),
      );

      return Right(entity);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }
}
