import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/usecases/params/pagination_params.dart';
import '../../domain/entities/wallet_entity.dart';
import '../../domain/entities/wallet_transaction_response_entity.dart';
import '../../domain/usecases/params/request_withdrawal_params.dart';
import '../../domain/repositories/wallet_repository.dart'; // From your domain layer
import '../datasources/wallet_remote_data_source.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource remoteDataSource;

  WalletRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppError, WalletEntity>> getWalletBalance() async {
    try {
      // 🎯 The remote data source returns a WalletModel, which extends WalletEntity
      final model = await remoteDataSource.fetchWalletBalance();
      return Right(model);
    } catch (e) {
      // 🛡️ Catch all network/server errors and map them to your AppError
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, WalletTransactionsResponseEntity>> getTransactions(
    PaginationParams params,
  ) async {
    try {
      final responseModel = await remoteDataSource.fetchTransactions(params);
      return Right(responseModel);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, void>> requestWithdrawal(
    RequestWithdrawalParams params,
  ) async {
    try {
      await remoteDataSource.requestWithdrawal(params);
      // 🚀 Returns void (Right) on success
      return const Right(null);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }
}
