import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/params/pagination_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/wallet_entity.dart';
import '../entities/wallet_transaction_response_entity.dart';
import '../repositories/wallet_repository.dart';
import '../usecases/params/request_withdrawal_params.dart';

class GetWalletBalanceUseCase implements UseCase<WalletEntity, NoParams> {
  final WalletRepository repository;
  GetWalletBalanceUseCase(this.repository);
  @override
  Future<Either<AppError, WalletEntity>> call(NoParams params) =>
      repository.getWalletBalance();
}

class GetWalletTransactionsUseCase
    implements UseCase<WalletTransactionsResponseEntity, PaginationParams> {
  final WalletRepository repository;
  GetWalletTransactionsUseCase(this.repository);
  @override
  Future<Either<AppError, WalletTransactionsResponseEntity>> call(
    PaginationParams params,
  ) => repository.getTransactions(params);
}

class RequestWithdrawalUseCase
    implements UseCase<void, RequestWithdrawalParams> {
  final WalletRepository repository;
  RequestWithdrawalUseCase(this.repository);
  @override
  Future<Either<AppError, void>> call(RequestWithdrawalParams params) =>
      repository.requestWithdrawal(params);
}
