// lib/features/kyc/domain/usecases/get_kyc_status_usecase.dart

import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/provider_kyc_entity.dart';
import '../repositories/provider_kyc_repository.dart';

class GetKycStatusUseCase {
  final ProviderKycRepository repository;

  GetKycStatusUseCase(this.repository);

  Future<Either<AppError, ProviderKycEntity>> call(NoParams params) {
    return repository.getKycStatus();
  }
}
