// import 'package:flutter/foundation.dart';

// import '../../domain/entities/booking_response_entity.dart';
// import '../../domain/entities/booking_entity.dart';
// import 'booking_meta_model.dart';
// import 'booking_model.dart';
// import 'pagination_model.dart';

// class BookingResponseModel extends BookingResponseEntity {
//   const BookingResponseModel({
//     required super.bookings,
//     required super.pagination,
//     required super.meta,
//   });

//   BookingResponseEntity toEntity() => this;

//   factory BookingResponseModel.fromJson(Map<String, dynamic> json) {
//     final Map<String, dynamic> dataContainer = json['data'] is Map
//         ? Map<String, dynamic>.from(json['data'])
//         : json;

//     // 🎯 FIXED: The API returns the list inside 'jobs', not 'bookings'.
//     final List<dynamic> arrayData = (dataContainer['jobs'] is List)
//         ? dataContainer['jobs']
//         : (dataContainer['bookings'] is List)
//         ? dataContainer['bookings']
//         : [];

//     final List<BookingEntity> bookingsList = [];

//     for (var item in arrayData) {
//       if (item is Map) {
//         try {
//           final safeMap = Map<String, dynamic>.from(item);
//           bookingsList.add(BookingModel.fromJson(safeMap).toEntity());
//         } catch (e, stack) {
//           debugPrint('🔴 JSON PARSE ERROR FOR A BOOKING: $e');
//           debugPrint('Stack: $stack');
//         }
//       }
//     }

//     return BookingResponseModel(
//       bookings: bookingsList,
//       pagination: PaginationModel.fromJson(
//         dataContainer['pagination'] is Map
//             ? Map<String, dynamic>.from(dataContainer['pagination'])
//             : {},
//       ).toEntity(),
//       // 🎯 FIXED: Feed 'analytics' block into the MetaModel
//       meta: BookingMetaModel.fromJson(
//         dataContainer['analytics'] is Map
//             ? Map<String, dynamic>.from(dataContainer['analytics'])
//             : (dataContainer['meta'] is Map
//                   ? Map<String, dynamic>.from(dataContainer['meta'])
//                   : {}),
//       ).toEntity(),
//     );
//   }
// }

import 'package:flutter/foundation.dart';

import '../../../../core/global/data/models/pagination_model.dart';
import '../../domain/entities/booking_response_entity.dart';
import '../../domain/entities/booking_entity.dart';
import 'booking_meta_model.dart';
import 'booking_model.dart';

class BookingResponseModel extends BookingResponseEntity {
  const BookingResponseModel({
    required super.bookings,
    required super.pagination,
    required super.meta,
  });

  BookingResponseEntity toEntity() => this;

  factory BookingResponseModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> dataContainer = json['data'] is Map
        ? Map<String, dynamic>.from(json['data'])
        : json;

    // 🎯 FIXED: The API returns the list inside 'jobs', not 'bookings'.
    final List<dynamic> arrayData = (dataContainer['jobs'] is List)
        ? dataContainer['jobs']
        : (dataContainer['bookings'] is List)
        ? dataContainer['bookings']
        : [];

    final List<BookingEntity> bookingsList = [];

    for (var item in arrayData) {
      if (item is Map) {
        try {
          final safeMap = Map<String, dynamic>.from(item);
          bookingsList.add(BookingModel.fromJson(safeMap).toEntity());
        } catch (e, stack) {
          debugPrint('🔴 JSON PARSE ERROR FOR A BOOKING: $e');
          debugPrint('Stack: $stack');
        }
      }
    }

    return BookingResponseModel(
      bookings: bookingsList,
      pagination: PaginationModel.fromJson(
        dataContainer['pagination'] is Map
            ? Map<String, dynamic>.from(dataContainer['pagination'])
            : {},
      ).toEntity(),
      // 🎯 FIXED: Pass the 'meta' object (or the root container) so BookingMetaModel can extract 'analytics'
      meta: BookingMetaModel.fromJson(
        dataContainer['meta'] is Map
            ? Map<String, dynamic>.from(dataContainer['meta'])
            : dataContainer,
      ).toEntity(),
    );
  }
}
