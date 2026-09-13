import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../repositories/provider_service_repository.dart';

class DeleteServiceOfferingUseCase {
  final ProviderServiceRepository repository;
  DeleteServiceOfferingUseCase(this.repository);

  Future<Either<AppError, String>> call(String serviceId) {
    return repository.deleteOffering(serviceId);
  }
}
