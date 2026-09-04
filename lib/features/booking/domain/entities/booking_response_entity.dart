import 'package:equatable/equatable.dart';

import 'booking_entity.dart';
import 'booking_meta_entity.dart';
import 'pagination_entity.dart';

class BookingResponseEntity extends Equatable {
  final List<BookingEntity> bookings;
  final PaginationEntity pagination;
  final BookingMetaEntity meta;

  const BookingResponseEntity({
    required this.bookings,
    required this.pagination,
    required this.meta,
  });

  @override
  List<Object?> get props => [bookings, pagination, meta];
}
