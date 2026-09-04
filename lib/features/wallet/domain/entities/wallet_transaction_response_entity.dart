import 'package:equatable/equatable.dart';

import '../../../booking/domain/entities/pagination_entity.dart';
import 'wallet_transaction_entity.dart';

class WalletTransactionsResponseEntity extends Equatable {
  final List<WalletTransactionEntity> transactions;
  final PaginationEntity pagination;

  const WalletTransactionsResponseEntity({
    required this.transactions,
    required this.pagination,
  });

  @override
  List<Object?> get props => [transactions, pagination];
}
