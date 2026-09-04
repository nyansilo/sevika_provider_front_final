// import '../../domain/entities/booking_entity.dart';
// import '../../domain/entities/booking_status.dart';
// import '../../domain/entities/booking_item_entity.dart';
// import '../../domain/entities/customer_entity.dart';
// import '../../domain/entities/quote_metadata_entity.dart';
// import 'booking_item_model.dart';
// import 'customer_model.dart';
// import 'quote_metadata_model.dart';

// class BookingModel extends BookingEntity {
//   const BookingModel({
//     required super.bookingId,
//     required super.bookingReference,
//     required super.bookingType,
//     super.chatRoomId,
//     required super.status,
//     super.paymentMethod,
//     required super.isPaid,
//     super.paymentStatus, // 🎯 Added back
//     super.invoiceUrl, // 🎯 Added back
//     super.startedAt,
//     super.payoutAmount,
//     required super.scheduledAt,
//     super.specialInstructions,
//     super.quoteMetadata,
//     required super.executionCity,
//     required super.executionAddress,
//     super.customer,
//     required super.items,
//     required super.requestedService,
//   });

//   BookingEntity toEntity() => this;

//   factory BookingModel.fromJson(Map<String, dynamic> json) {
//     // 1. Map items safely
//     final List<BookingItemEntity> parsedItems = [];
//     if (json['items'] is List) {
//       for (var itemRaw in json['items']) {
//         if (itemRaw is Map) {
//           parsedItems.add(
//             BookingItemModel.fromJson(Map<String, dynamic>.from(itemRaw))
//                 .toEntity(),
//           );
//         }
//       }
//     }

//     // 2. Map customer
//     CustomerEntity? customer;
//     if (json['customer'] is Map) {
//       customer = CustomerModel.fromJson(
//         Map<String, dynamic>.from(json['customer']),
//       ).toEntity();
//     }

//     // 3. Map quote metadata
//     QuoteMetadataEntity? metadata;
//     if (json['quoteMetadata'] is Map) {
//       metadata = QuoteMetadataModel.fromJson(
//         Map<String, dynamic>.from(json['quoteMetadata']),
//       ).toEntity();
//     }

//     return BookingModel(
//       bookingId: json['bookingId'] != null
//           ? (num.tryParse(json['bookingId'].toString())?.toInt() ?? 0)
//           : 0,
//       bookingReference: json['bookingReference']?.toString() ?? '',
//       bookingType: json['bookingType']?.toString() ?? 'instant',
//       chatRoomId: json['chatRoomId']?.toString(),
//       status: BookingStatus.fromString(json['jobStatus']?.toString() ?? ''),
//       paymentMethod: json['paymentMethod']?.toString(),
//       isPaid: json['isPaid'] == true || json['isPaid'] == 'true',

//       // 🎯 FIXED: Map the invoiceUrl from Laravel to the Flutter Entity!
//       invoiceUrl: json['invoiceUrl']?.toString(),
//       paymentStatus: json['paymentStatus']
//           ?.toString(), // Just in case you need it later

//       startedAt: json['startedAt']?.toString(),
//       payoutAmount: json['payoutAmount'] != null
//           ? (num.tryParse(json['payoutAmount'].toString())?.toDouble())
//           : null,
//       scheduledAt: json['scheduledTime']?.toString() ?? '',
//       specialInstructions: json['specialInstructions']?.toString(),
//       quoteMetadata: metadata,
//       executionCity: json['location']?['city']?.toString() ?? '',
//       executionAddress:
//           json['location']?['address']?.toString() ??
//           'Hidden until contract accepted',
//       customer: customer,
//       items: parsedItems,
//       requestedService:
//           json['requestedService']?.toString() ?? 'Service Details Unavailable',
//     );
//   }
// }

import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/booking_status.dart';
import '../../domain/entities/booking_item_entity.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/quote_metadata_entity.dart';
import 'booking_item_model.dart';
import 'customer_model.dart';
import 'quote_metadata_model.dart';

class BookingModel extends BookingEntity {
  const BookingModel({
    required super.bookingId,
    required super.bookingReference,
    required super.bookingType,
    super.chatRoomId,
    required super.status,
    super.paymentMethod,
    required super.isPaid,
    super.paymentStatus,
    super.invoiceUrl,
    super.startedAt,
    super.payoutAmount,
    super.totalAmount, // 🎯 Mapped properly
    required super.scheduledAt,
    super.specialInstructions,
    super.quoteMetadata,
    required super.executionCity,
    required super.executionAddress,
    super.customer,
    required super.items,
    required super.requestedService,
  });

  BookingEntity toEntity() => this;

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    // 🎯 INDUSTRY STANDARD: Robust parser to catch and clean numbers
    double? safeParseDouble(dynamic value) {
      if (value == null) return null;
      if (value is num) return value.toDouble();
      final cleanString = value.toString().replaceAll(RegExp(r'[^0-9.]'), '');
      return double.tryParse(cleanString);
    }

    // 1. Map items safely
    final List<BookingItemEntity> parsedItems = [];
    if (json['items'] is List) {
      for (var itemRaw in json['items']) {
        if (itemRaw is Map) {
          parsedItems.add(
            BookingItemModel.fromJson(Map<String, dynamic>.from(itemRaw))
                .toEntity(),
          );
        }
      }
    }

    // 2. Map customer
    CustomerEntity? customer;
    if (json['customer'] is Map) {
      customer = CustomerModel.fromJson(
        Map<String, dynamic>.from(json['customer']),
      ).toEntity();
    }

    // 3. Map quote metadata
    QuoteMetadataEntity? metadata;
    if (json['quoteMetadata'] is Map) {
      metadata = QuoteMetadataModel.fromJson(
        Map<String, dynamic>.from(json['quoteMetadata']),
      ).toEntity();
    }

    return BookingModel(
      bookingId: json['bookingId'] != null
          ? (num.tryParse(json['bookingId'].toString())?.toInt() ?? 0)
          : 0,
      bookingReference: json['bookingReference']?.toString() ?? '',
      bookingType: json['bookingType']?.toString() ?? 'instant',
      chatRoomId: json['chatRoomId']?.toString(),
      status: BookingStatus.fromString(json['jobStatus']?.toString() ?? ''),
      paymentMethod: json['paymentMethod']?.toString(),
      isPaid: json['isPaid'] == true || json['isPaid'] == 'true',
      invoiceUrl: json['invoiceUrl']?.toString(),
      paymentStatus: json['paymentStatus']?.toString(),
      startedAt: json['startedAt']?.toString(),

      // 🎯 FIXED: payoutAmount expects a double?, so we leave it as is
      payoutAmount: safeParseDouble(
        json['payoutAmount'] ?? json['payout_amount'],
      ),

      // 🎯 FIXED: totalAmount expects a String? in your entity, so we safely parse it, then cast to string
      totalAmount: safeParseDouble(
        json['totalAmount'] ?? json['total_amount'] ?? json['amount'],
      )?.toString(),

      scheduledAt: json['scheduledTime']?.toString() ?? '',
      specialInstructions: json['specialInstructions']?.toString(),
      quoteMetadata: metadata,
      executionCity: json['location']?['city']?.toString() ?? '',
      executionAddress:
          json['location']?['address']?.toString() ??
          'Hidden until contract accepted',
      customer: customer,
      items: parsedItems,
      requestedService:
          json['requestedService']?.toString() ?? 'Service Details Unavailable',
    );
  }
}
