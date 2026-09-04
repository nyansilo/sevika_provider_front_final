import 'package:equatable/equatable.dart';

import '../../domain/entities/earning_entity.dart';
import '../../domain/entities/earnings_analytics_entity.dart';

abstract class EarningsState extends Equatable {
  const EarningsState();
  @override
  List<Object?> get props => [];
}

class EarningsInitial extends EarningsState {}

class EarningsFirstPageLoading extends EarningsState {}

class EarningsLoadSuccess extends EarningsState {
  final List<EarningEntity> ledger;
  final EarningsAnalyticsEntity analytics;
  final int currentPage;
  final bool hasMore;
  final bool isMoreLoading;
  final String? paginationErrorMessage;

  const EarningsLoadSuccess({
    required this.ledger,
    required this.analytics,
    required this.currentPage,
    required this.hasMore,
    this.isMoreLoading = false,
    this.paginationErrorMessage,
  });

  EarningsLoadSuccess copyWith({
    List<EarningEntity>? ledger,
    EarningsAnalyticsEntity? analytics,
    int? currentPage,
    bool? hasMore,
    bool? isMoreLoading,
    String? paginationErrorMessage,
  }) {
    return EarningsLoadSuccess(
      ledger: ledger ?? this.ledger,
      analytics: analytics ?? this.analytics,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      paginationErrorMessage: paginationErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    ledger,
    analytics,
    currentPage,
    hasMore,
    isMoreLoading,
    paginationErrorMessage,
  ];
}

class EarningsLoadFailure extends EarningsState {
  final String message;
  const EarningsLoadFailure(this.message);
  @override
  List<Object?> get props => [message];
}
