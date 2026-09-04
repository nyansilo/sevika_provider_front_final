import 'package:equatable/equatable.dart';

class EarningsAnalyticsEntity extends Equatable {
  final int totalPayoutsAllocated;
  final double totalWithdrawn;
  final double pendingEscrow;
  final double cashOnDeliveryVolume;
  final double digitalGatewayVolume;

  const EarningsAnalyticsEntity({
    required this.totalPayoutsAllocated,
    required this.totalWithdrawn,
    required this.pendingEscrow,
    required this.cashOnDeliveryVolume,
    required this.digitalGatewayVolume,
  });

  @override
  List<Object?> get props => [
    totalPayoutsAllocated,
    totalWithdrawn,
    pendingEscrow,
  ];
}
