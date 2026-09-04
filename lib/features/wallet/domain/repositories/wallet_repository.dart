import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/params/pagination_params.dart';
import '../entities/wallet_entity.dart';
import '../entities/wallet_transaction_response_entity.dart';
import '../usecases/params/request_withdrawal_params.dart';

abstract class WalletRepository {
  Future<Either<AppError, WalletEntity>> getWalletBalance();
  Future<Either<AppError, WalletTransactionsResponseEntity>> getTransactions(
    PaginationParams params,
  );
  Future<Either<AppError, void>> requestWithdrawal(
    RequestWithdrawalParams params,
  );
}
