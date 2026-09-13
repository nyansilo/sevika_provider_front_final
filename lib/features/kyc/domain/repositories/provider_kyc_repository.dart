// lib/features/kyc/domain/repositories/provider_kyc_repository.dart
import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../entities/provider_kyc_entity.dart';
import '../usecases/params/submit_basic_kyc_params.dart';
import '../usecases/params/upgrade_to_pro_params.dart';

abstract class ProviderKycRepository {
  Future<Either<AppError, ProviderKycEntity>> getKycStatus();
  Future<Either<AppError, ProviderKycEntity>> submitBasicKyc(
    SubmitBasicKycParams params,
  );
  Future<Either<AppError, ProviderKycEntity>> upgradeToPro(
    UpgradeToProParams params,
  );
}
