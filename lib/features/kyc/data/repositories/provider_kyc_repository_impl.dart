// lib/features/kyc/data/repositories/provider_kyc_repository_impl.dart

import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_handler.dart';
import '../../domain/entities/provider_kyc_entity.dart';
import '../../domain/repositories/provider_kyc_repository.dart';
import '../../domain/usecases/params/submit_basic_kyc_params.dart';
import '../../domain/usecases/params/upgrade_to_pro_params.dart';
import '../datasources/provider_kyc_remote_datasource.dart';

class ProviderKycRepositoryImpl implements ProviderKycRepository {
  final ProviderKycRemoteDataSource remoteDataSource;

  ProviderKycRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppError, ProviderKycEntity>> getKycStatus() async {
    try {
      final model = await remoteDataSource.fetchKycStatus();
      return Right(model.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, ProviderKycEntity>> submitBasicKyc(
    SubmitBasicKycParams params,
  ) async {
    try {
      final model = await remoteDataSource.submitBasicKyc(params);
      return Right(model.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, ProviderKycEntity>> upgradeToPro(
    UpgradeToProParams params,
  ) async {
    try {
      final model = await remoteDataSource.upgradeToPro(params);
      return Right(model.toEntity());
    } catch (e) {
      // 🚀 This perfectly catches the 403 and 400 errors returned by Laravel
      // (e.g. "Access restricted. Please complete your NIDA biometric verification")
      // and passes them seamlessly to the UI.
      return Left(await ErrorHandler.handle(e));
    }
  }
}
