import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/params/pagination_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/earning_entity.dart';
import '../entities/earning_response_entity.dart';
import '../repositories/earnings_repository.dart';

class GetEarningsUseCase
    implements UseCase<EarningsResponseEntity, PaginationParams> {
  final EarningsRepository repository;
  GetEarningsUseCase(this.repository);
  @override
  Future<Either<AppError, EarningsResponseEntity>> call(
    PaginationParams params,
  ) => repository.getEarnings(params);
}

// 🎯 THE MISSING SINGLE PAYOUT USE CASE
class GetSinglePayoutUseCase implements UseCase<EarningEntity, String> {
  final EarningsRepository repository;
  GetSinglePayoutUseCase(this.repository);
  @override
  Future<Either<AppError, EarningEntity>> call(String paymentId) =>
      repository.getSinglePayout(paymentId);
}
