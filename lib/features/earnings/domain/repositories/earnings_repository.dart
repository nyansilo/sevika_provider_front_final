import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/params/pagination_params.dart';
import '../entities/earning_entity.dart';
import '../entities/earning_response_entity.dart';

abstract class EarningsRepository {
  Future<Either<AppError, EarningsResponseEntity>> getEarnings(
    PaginationParams params,
  );
  Future<Either<AppError, EarningEntity>> getSinglePayout(String paymentId);
}
