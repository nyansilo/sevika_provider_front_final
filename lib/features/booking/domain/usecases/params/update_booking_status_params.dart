// import 'package:equatable/equatable.dart';

// class UpdateBookingStatusParams extends Equatable {
//   // 🎯 FIXED: Changed from bookingId (int) to bookingReference (String) to match URL
//   final String bookingReference;
//   final String status;

//   // 🎯 ADDED: Required by Laravel to transition to 'in_progress'
//   final String? verificationCode;

//   final double? estimatedPrice;
//   final double? finalPrice;

//   const UpdateBookingStatusParams({
//     required this.bookingReference,
//     required this.status,
//     this.verificationCode,
//     this.estimatedPrice,
//     this.finalPrice,
//   });

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{'status': status};

//     // 🎯 ADDED: Inject verification code into the JSON payload if provided
//     if (verificationCode != null) {
//       map['verification_code'] = verificationCode;
//     }

//     if (estimatedPrice != null) map['estimated_price'] = estimatedPrice;
//     if (finalPrice != null) map['final_price'] = finalPrice;
//     return map;
//   }

//   @override
//   List<Object?> get props => [
//     bookingReference,
//     status,
//     verificationCode,
//     estimatedPrice,
//     finalPrice,
//   ];
// }

import 'package:equatable/equatable.dart';

class UpdateBookingStatusParams extends Equatable {
  // 🎯 FIXED: Changed from bookingId (int) to bookingReference (String) to match URL
  final String bookingReference;
  final String status;

  // 🎯 ADDED: Required by Laravel to transition to 'in_progress'
  final String? verificationCode;

  final double? estimatedPrice;

  // 🚀 ADDED: Required for SOS Post-Job Billing
  final double? finalPrice;

  const UpdateBookingStatusParams({
    required this.bookingReference,
    required this.status,
    this.verificationCode,
    this.estimatedPrice,
    this.finalPrice,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{'status': status};

    // 🎯 ADDED: Inject verification code into the JSON payload if provided
    if (verificationCode != null) {
      map['verification_code'] = verificationCode;
    }

    if (estimatedPrice != null) map['estimated_price'] = estimatedPrice;

    // 🚀 Maps directly to Laravel's $request->input('final_price')
    if (finalPrice != null) map['final_price'] = finalPrice;

    return map;
  }

  @override
  List<Object?> get props => [
    bookingReference,
    status,
    verificationCode,
    estimatedPrice,
    finalPrice,
  ];
}
