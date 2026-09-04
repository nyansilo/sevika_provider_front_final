import 'package:dartz/dartz.dart';

import '../../../../../core/errors/app_error.dart';
import '../entities/location_boundaries_entity.dart';

abstract class LocationRepository {
  Future<Either<AppError, LocationBoundariesEntity>>
  fetchAdministrativeBoundaries();
}
