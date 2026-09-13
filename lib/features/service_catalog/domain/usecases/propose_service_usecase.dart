import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../entities/provider_service_entity.dart';
import '../repositories/provider_service_repository.dart';
import 'params/propose_service_params.dart';

class ProposeServiceUseCase {
  final ProviderServiceRepository repository;
  ProposeServiceUseCase(this.repository);

  Future<Either<AppError, ProviderServiceEntity>> call(
    ProposeServiceParams params,
  ) {
    return repository.proposeService(params);
  }
}
