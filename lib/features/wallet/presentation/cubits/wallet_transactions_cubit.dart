import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/params/pagination_params.dart';
import '../../domain/entities/wallet_transaction_entity.dart';
import '../../domain/usecases/wallet_usecases.dart';
import 'wallet_transactions_state.dart'; // Adjust path

class WalletTransactionsCubit extends Cubit<WalletTransactionsState> {
  final GetWalletTransactionsUseCase getWalletTransactionsUseCase;

  WalletTransactionsCubit(this.getWalletTransactionsUseCase)
    : super(WalletTransactionsInitial());

  int _page = 1;
  final int _perPage = 15;

  /// 🔄 FETCH INITIAL PAGE (Used for initial load and pull-to-refresh)
  Future<void> loadInitialTransactions() async {
    _page = 1;
    emit(WalletTransactionsFirstPageLoading());

    final result = await getWalletTransactionsUseCase.call(
      PaginationParams(page: _page, perPage: _perPage),
    );

    if (isClosed) return;

    result.fold(
      (error) => emit(
        WalletTransactionsLoadFailure(
          error.message ?? 'Failed to load transactions',
        ),
      ),
      (response) => emit(
        WalletTransactionsLoadSuccess(
          transactions: response.transactions,
          currentPage: response.pagination.currentPage,
          hasMore: response.pagination.hasMore,
        ),
      ),
    );
  }

  /// 🔽 PAGINATION: FETCH NEXT BATCH
  Future<void> loadNextPage() async {
    final currentState = state;
    if (currentState is! WalletTransactionsLoadSuccess) return;
    if (currentState.isMoreLoading || !currentState.hasMore) return;

    emit(
      currentState.copyWith(isMoreLoading: true, paginationErrorMessage: null),
    );

    final int nextPage = currentState.currentPage + 1;
    final result = await getWalletTransactionsUseCase.call(
      PaginationParams(page: nextPage, perPage: _perPage),
    );

    if (isClosed) return;

    result.fold(
      (error) => emit(
        currentState.copyWith(
          isMoreLoading: false,
          paginationErrorMessage: error.message,
        ),
      ),
      (response) {
        _page = response.pagination.currentPage;
        final totalList = List<WalletTransactionEntity>.from(
          currentState.transactions,
        )..addAll(response.transactions);

        emit(
          WalletTransactionsLoadSuccess(
            transactions: totalList,
            currentPage: response.pagination.currentPage,
            hasMore: response.pagination.hasMore,
            isMoreLoading: false,
          ),
        );
      },
    );
  }
}
