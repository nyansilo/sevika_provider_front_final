import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../entities/provider_service_entity.dart';
import '../repositories/provider_service_repository.dart';
import 'params/update_offering_params.dart';

class UpdateServiceOfferingUseCase {
  final ProviderServiceRepository repository;
  UpdateServiceOfferingUseCase(this.repository);

  Future<Either<AppError, ProviderServiceEntity>> call(
    UpdateOfferingParams params,
  ) {
    return repository.updateOffering(params);
  }
}
