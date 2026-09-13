// lib/features/kyc/domain/usecases/upgrade_to_pro_usecase.dart

import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../entities/provider_kyc_entity.dart';
import '../repositories/provider_kyc_repository.dart';
import 'params/upgrade_to_pro_params.dart';

class UpgradeToProUseCase {
  final ProviderKycRepository repository;

  UpgradeToProUseCase(this.repository);

  Future<Either<AppError, ProviderKycEntity>> call(UpgradeToProParams params) {
    return repository.upgradeToPro(params);
  }
}
