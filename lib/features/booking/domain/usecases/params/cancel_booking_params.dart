import 'package:equatable/equatable.dart';

/// 👨‍🔧 CANCEL BOOKING PARAMS (PROVIDER)
///
/// Encapsulates the required data for a provider to cancel a booking.
/// It requires the unique booking reference and a reason code to log
/// why the job was rejected or abandoned (useful for platform analytics).
class CancelBookingParams extends Equatable {
  final String bookingReference;
  final String reasonCode;

  const CancelBookingParams({
    required this.bookingReference,
    required this.reasonCode,
  });

  /// Converts the parameters into a JSON map safely consumable by Dio
  Map<String, dynamic> toJson() => {'reasonCode': reasonCode};

  @override
  List<Object?> get props => [bookingReference, reasonCode];
}
