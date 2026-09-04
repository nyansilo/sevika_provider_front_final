import 'package:equatable/equatable.dart';

/// 🎯 SHARED PAGINATION PARAMS
/// Reusable across Bookings, Wallet Transactions, and Earnings Ledgers.
class PaginationParams extends Equatable {
  final int page;
  final int perPage;

  const PaginationParams({required this.page, this.perPage = 15});

  Map<String, dynamic> toQueryParameters() => {
    'page': page,
    'per_page': perPage,
  };

  @override
  List<Object?> get props => [page, perPage];
}
