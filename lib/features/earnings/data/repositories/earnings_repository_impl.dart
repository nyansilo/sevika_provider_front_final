import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/usecases/params/pagination_params.dart';
import '../../domain/entities/earning_entity.dart';
import '../../domain/entities/earning_response_entity.dart';
import '../../domain/repositories/earnings_repository.dart';
import '../datasources/earnings_remote_data_source.dart';

class EarningsRepositoryImpl implements EarningsRepository {
  final EarningsRemoteDataSource remoteDataSource;

  EarningsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppError, EarningsResponseEntity>> getEarnings(
    PaginationParams params,
  ) async {
    try {
      // 🎯 Fetches the paginated ledger along with the analytics block
      final responseModel = await remoteDataSource.fetchEarnings(params);
      return Right(responseModel);
    } catch (e) {
      // 🛡️ Prevents the app from crashing by wrapping Dio errors
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, EarningEntity>> getSinglePayout(
    String paymentId,
  ) async {
    try {
      // 🎯 Fetches the specific details of a single payout reference
      final model = await remoteDataSource.fetchSinglePayout(paymentId);
      return Right(model);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }
}
