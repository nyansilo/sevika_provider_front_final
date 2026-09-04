// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../domain/entities/booking_entity.dart';
// import '../../../domain/usecases/get_provider_bookings_usecase.dart'; // 👨‍🔧 Provider Specific UseCase
// import '../../../domain/usecases/params/booking_pagination_params.dart';
// import 'booking_history_state.dart';

// class BookingHistoryCubit extends Cubit<BookingHistoryState> {
//   // 🎯 INJECTED: The new Provider-specific fetch pipeline
//   final GetProviderBookingsUseCase getProviderBookingsUseCase;

//   BookingHistoryCubit({required this.getProviderBookingsUseCase})
//     : super(const BookingHistoryInitial());

//   int _page = 1;
//   final int _perPage = 15;

//   /// 🔄 FETCH INITIAL PAGE (Used for initial load and pull-to-refresh)
//   Future<void> loadInitialBookings() async {
//     _page = 1;
//     emit(const BookingHistoryFirstPageLoading());

//     final result = await getProviderBookingsUseCase.call(
//       BookingPaginationParams(page: _page, perPage: _perPage),
//     );

//     if (isClosed) return;

//     result.fold(
//       (error) => emit(BookingHistoryLoadFailure(error)),
//       (response) => emit(
//         BookingHistoryLoadSuccess(
//           bookings: response.bookings,
//           currentPage: response.pagination.currentPage,
//           hasMore: response.pagination.hasMore,
//         ),
//       ),
//     );
//   }

//   /// 🔽 PAGINATION: FETCH NEXT BATCH
//   Future<void> loadNextPage() async {
//     final currentState = state;

//     if (currentState is! BookingHistoryLoadSuccess) return;
//     if (currentState.isMoreLoading || !currentState.hasMore) return;

//     // Show infinite scroll loader at the bottom
//     emit(
//       currentState.copyWith(isMoreLoading: true, paginationErrorMessage: null),
//     );

//     final int nextPage = currentState.currentPage + 1;

//     final result = await getProviderBookingsUseCase.call(
//       BookingPaginationParams(page: nextPage, perPage: _perPage),
//     );

//     if (isClosed) return;

//     result.fold(
//       (error) => emit(
//         currentState.copyWith(
//           isMoreLoading: false,
//           paginationErrorMessage: error.message,
//         ),
//       ),
//       (response) {
//         _page = response.pagination.currentPage;

//         // Append new jobs to the existing pipeline list
//         final List<BookingEntity> totalList = List.from(currentState.bookings)
//           ..addAll(response.bookings);

//         emit(
//           BookingHistoryLoadSuccess(
//             bookings: totalList,
//             currentPage: response.pagination.currentPage,
//             hasMore: response.pagination.hasMore,
//             isMoreLoading: false,
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/booking_entity.dart';
import '../../../domain/usecases/get_provider_bookings_usecase.dart'; // 👨‍🔧 Provider Specific UseCase
import '../../../domain/usecases/params/booking_pagination_params.dart';
import 'booking_history_state.dart';

class BookingHistoryCubit extends Cubit<BookingHistoryState> {
  // 🎯 INJECTED: The new Provider-specific fetch pipeline
  final GetProviderBookingsUseCase getProviderBookingsUseCase;

  BookingHistoryCubit({required this.getProviderBookingsUseCase})
    : super(const BookingHistoryInitial());

  int _page = 1;
  final int _perPage = 15;

  /// 🔄 FETCH INITIAL PAGE (Used for initial load and pull-to-refresh)
  Future<void> loadInitialBookings() async {
    _page = 1;
    emit(const BookingHistoryFirstPageLoading());

    final result = await getProviderBookingsUseCase.call(
      BookingPaginationParams(page: _page, perPage: _perPage),
    );

    if (isClosed) return;

    result.fold(
      (error) => emit(BookingHistoryLoadFailure(error)),
      (response) => emit(
        BookingHistoryLoadSuccess(
          bookings: response.bookings,
          currentPage: response.pagination.currentPage,
          hasMore: response.pagination.hasMore,
          summary: response
              .meta
              .summary, // 🎯 ADDED: Pushing global analytics to state
        ),
      ),
    );
  }

  /// 🔽 PAGINATION: FETCH NEXT BATCH
  Future<void> loadNextPage() async {
    final currentState = state;

    if (currentState is! BookingHistoryLoadSuccess) return;
    if (currentState.isMoreLoading || !currentState.hasMore) return;

    // Show infinite scroll loader at the bottom
    emit(
      currentState.copyWith(isMoreLoading: true, paginationErrorMessage: null),
    );

    final int nextPage = currentState.currentPage + 1;

    final result = await getProviderBookingsUseCase.call(
      BookingPaginationParams(page: nextPage, perPage: _perPage),
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

        // Append new jobs to the existing pipeline list
        final List<BookingEntity> totalList = List.from(currentState.bookings)
          ..addAll(response.bookings);

        emit(
          BookingHistoryLoadSuccess(
            bookings: totalList,
            currentPage: response.pagination.currentPage,
            hasMore: response.pagination.hasMore,
            isMoreLoading: false,
            summary: response.meta.summary, // 🎯 ADDED: Keep summary up to date
          ),
        );
      },
    );
  }
}
