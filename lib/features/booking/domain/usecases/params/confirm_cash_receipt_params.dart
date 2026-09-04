import 'package:equatable/equatable.dart';

class ConfirmCashReceiptParams extends Equatable {
  final String bookingReference;
  const ConfirmCashReceiptParams({required this.bookingReference});

  @override
  List<Object?> get props => [bookingReference];
}
