import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/params/pagination_params.dart';
import '../../domain/entities/earning_entity.dart';
import '../../domain/usecases/earnings_usecases.dart';
import 'earnings_state.dart';

class EarningsCubit extends Cubit<EarningsState> {
  final GetEarningsUseCase getEarningsUseCase;

  EarningsCubit(this.getEarningsUseCase) : super(EarningsInitial());

  int _page = 1;
  final int _perPage = 15;

  Future<void> loadInitialEarnings() async {
    _page = 1;
    emit(EarningsFirstPageLoading());

    final result = await getEarningsUseCase.call(
      PaginationParams(page: _page, perPage: _perPage),
    );

    if (isClosed) return;

    result.fold(
      (error) =>
          emit(EarningsLoadFailure(error.message ?? 'Failed to load earnings')),
      (response) => emit(
        EarningsLoadSuccess(
          ledger: response.ledger,
          analytics: response
              .analytics, // 🎯 Automatically passes the unified analytics!
          currentPage: response.pagination.currentPage,
          hasMore: response.pagination.hasMore,
        ),
      ),
    );
  }

  Future<void> loadNextPage() async {
    final currentState = state;
    if (currentState is! EarningsLoadSuccess) return;
    if (currentState.isMoreLoading || !currentState.hasMore) return;

    emit(
      currentState.copyWith(isMoreLoading: true, paginationErrorMessage: null),
    );

    final int nextPage = currentState.currentPage + 1;
    final result = await getEarningsUseCase.call(
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
        final totalLedger = List<EarningEntity>.from(currentState.ledger)
          ..addAll(response.ledger);

        emit(
          EarningsLoadSuccess(
            ledger: totalLedger,
            analytics:
                response.analytics, // Update analytics to the latest snapshot
            currentPage: response.pagination.currentPage,
            hasMore: response.pagination.hasMore,
            isMoreLoading: false,
          ),
        );
      },
    );
  }
}
