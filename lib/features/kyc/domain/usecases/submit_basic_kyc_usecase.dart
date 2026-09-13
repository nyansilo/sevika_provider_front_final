// lib/features/kyc/domain/usecases/submit_basic_kyc_usecase.dart

import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../entities/provider_kyc_entity.dart';
import '../repositories/provider_kyc_repository.dart';
import 'params/submit_basic_kyc_params.dart';

class SubmitBasicKycUseCase {
  final ProviderKycRepository repository;

  SubmitBasicKycUseCase(this.repository);

  Future<Either<AppError, ProviderKycEntity>> call(
    SubmitBasicKycParams params,
  ) {
    return repository.submitBasicKyc(params);
  }
}
