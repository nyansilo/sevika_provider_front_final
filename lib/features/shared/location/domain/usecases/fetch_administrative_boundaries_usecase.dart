import 'package:dartz/dartz.dart';

import '../../../../../core/errors/app_error.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entities/location_boundaries_entity.dart';
import '../repositories/location_repository.dart';

class FetchAdministrativeBoundariesUseCase
    implements UseCase<LocationBoundariesEntity, NoParams> {
  final LocationRepository repository;

  FetchAdministrativeBoundariesUseCase(this.repository);

  @override
  Future<Either<AppError, LocationBoundariesEntity>> call(
    NoParams params,
  ) async {
    return await repository.fetchAdministrativeBoundaries();
  }
}
