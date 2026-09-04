import 'package:equatable/equatable.dart';

import '../../domain/entities/wallet_transaction_entity.dart';

abstract class WalletTransactionsState extends Equatable {
  const WalletTransactionsState();
  @override
  List<Object?> get props => [];
}

class WalletTransactionsInitial extends WalletTransactionsState {}

class WalletTransactionsFirstPageLoading extends WalletTransactionsState {}

class WalletTransactionsLoadSuccess extends WalletTransactionsState {
  final List<WalletTransactionEntity> transactions;
  final int currentPage;
  final bool hasMore;
  final bool isMoreLoading;
  final String? paginationErrorMessage;

  const WalletTransactionsLoadSuccess({
    required this.transactions,
    required this.currentPage,
    required this.hasMore,
    this.isMoreLoading = false,
    this.paginationErrorMessage,
  });

  WalletTransactionsLoadSuccess copyWith({
    List<WalletTransactionEntity>? transactions,
    int? currentPage,
    bool? hasMore,
    bool? isMoreLoading,
    String? paginationErrorMessage,
  }) {
    return WalletTransactionsLoadSuccess(
      transactions: transactions ?? this.transactions,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      paginationErrorMessage: paginationErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    transactions,
    currentPage,
    hasMore,
    isMoreLoading,
    paginationErrorMessage,
  ];
}

class WalletTransactionsLoadFailure extends WalletTransactionsState {
  final String message;
  const WalletTransactionsLoadFailure(this.message);
  @override
  List<Object?> get props => [message];
}
