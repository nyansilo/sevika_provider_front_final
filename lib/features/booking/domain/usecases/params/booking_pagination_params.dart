import 'package:equatable/equatable.dart';

/// 🎯 PAGINATION PARAMS
/// Encapsulates the page and perPage limits when the Provider requests their
/// list of assigned leads, active jobs, or historical bookings.
class BookingPaginationParams extends Equatable {
  final int page;
  final int perPage;

  const BookingPaginationParams({required this.page, this.perPage = 15});

  /// Converts the parameters into a map safely consumable by Dio query parameters
  Map<String, dynamic> toQueryParameters() => {
    'page': page,
    'per_page': perPage,
  };

  @override
  List<Object?> get props => [page, perPage];
}
