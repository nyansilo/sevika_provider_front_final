// import 'package:equatable/equatable.dart';

// import '../../../../../core/errors/app_error.dart';
// import '../../../domain/entities/booking_entity.dart';

// abstract class BookingHistoryState extends Equatable {
//   const BookingHistoryState();

//   @override
//   List<Object?> get props => [];
// }

// class BookingHistoryInitial extends BookingHistoryState {
//   const BookingHistoryInitial();
// }

// class BookingHistoryFirstPageLoading extends BookingHistoryState {
//   const BookingHistoryFirstPageLoading();
// }

// class BookingHistoryLoadSuccess extends BookingHistoryState {
//   final List<BookingEntity> bookings;
//   final int currentPage;
//   final bool hasMore;
//   final bool isMoreLoading;
//   final String? paginationErrorMessage;

//   const BookingHistoryLoadSuccess({
//     required this.bookings,
//     required this.currentPage,
//     required this.hasMore,
//     this.isMoreLoading = false,
//     this.paginationErrorMessage,
//   });

//   BookingHistoryLoadSuccess copyWith({
//     List<BookingEntity>? bookings,
//     int? currentPage,
//     bool? hasMore,
//     bool? isMoreLoading,
//     String? paginationErrorMessage,
//   }) {
//     return BookingHistoryLoadSuccess(
//       bookings: bookings ?? this.bookings,
//       currentPage: currentPage ?? this.currentPage,
//       hasMore: hasMore ?? this.hasMore,
//       isMoreLoading: isMoreLoading ?? this.isMoreLoading,
//       // Pass null if clear is needed, otherwise preserve existing
//       paginationErrorMessage: paginationErrorMessage,
//     );
//   }

//   @override
//   List<Object?> get props => [
//     bookings,
//     currentPage,
//     hasMore,
//     isMoreLoading,
//     paginationErrorMessage,
//   ];
// }

// class BookingHistoryLoadFailure extends BookingHistoryState {
//   final AppError error;
//   const BookingHistoryLoadFailure(this.error);

//   @override
//   List<Object?> get props => [error];
// }

import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_error.dart';
import '../../../domain/entities/booking_entity.dart';
import '../../../domain/entities/booking_summary_entity.dart'; // 🎯 ADDED: Global analytics import

abstract class BookingHistoryState extends Equatable {
  const BookingHistoryState();

  @override
  List<Object?> get props => [];
}

class BookingHistoryInitial extends BookingHistoryState {
  const BookingHistoryInitial();
}

class BookingHistoryFirstPageLoading extends BookingHistoryState {
  const BookingHistoryFirstPageLoading();
}

class BookingHistoryLoadSuccess extends BookingHistoryState {
  final List<BookingEntity> bookings;
  final int currentPage;
  final bool hasMore;
  final bool isMoreLoading;
  final String? paginationErrorMessage;
  final BookingSummaryEntity? summary; // 🎯 ADDED: Exposes global backend stats

  const BookingHistoryLoadSuccess({
    required this.bookings,
    required this.currentPage,
    required this.hasMore,
    this.isMoreLoading = false,
    this.paginationErrorMessage,
    this.summary, // 🎯 ADDED
  });

  BookingHistoryLoadSuccess copyWith({
    List<BookingEntity>? bookings,
    int? currentPage,
    bool? hasMore,
    bool? isMoreLoading,
    String? paginationErrorMessage,
    BookingSummaryEntity? summary, // 🎯 ADDED
  }) {
    return BookingHistoryLoadSuccess(
      bookings: bookings ?? this.bookings,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      paginationErrorMessage:
          paginationErrorMessage, // Passed as-is to allow nulling
      summary: summary ?? this.summary, // 🎯 ADDED
    );
  }

  @override
  List<Object?> get props => [
    bookings,
    currentPage,
    hasMore,
    isMoreLoading,
    paginationErrorMessage,
    summary, // 🎯 ADDED
  ];
}

class BookingHistoryLoadFailure extends BookingHistoryState {
  final AppError error;
  const BookingHistoryLoadFailure(this.error);

  @override
  List<Object?> get props => [error];
}
