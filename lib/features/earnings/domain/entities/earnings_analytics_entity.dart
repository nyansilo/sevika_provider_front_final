// import 'package:equatable/equatable.dart';

// class EarningsAnalyticsEntity extends Equatable {
//   final int totalPayoutsAllocated;
//   final double totalWithdrawn;
//   final double pendingEscrow;
//   final double cashOnDeliveryVolume;
//   final double digitalGatewayVolume;

//   const EarningsAnalyticsEntity({
//     required this.totalPayoutsAllocated,
//     required this.totalWithdrawn,
//     required this.pendingEscrow,
//     required this.cashOnDeliveryVolume,
//     required this.digitalGatewayVolume,
//   });

//   @override
//   List<Object?> get props => [
//     totalPayoutsAllocated,
//     totalWithdrawn,
//     pendingEscrow,
//   ];
// }

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

  // =========================================================================
  // 🚀 UI HELPER GETTERS (The Bridge)
  // These compute the simplified values needed by the Home Dashboard UI
  // without requiring any changes to your JSON Models or Laravel backend!
  // =========================================================================

  /// Represents the total number of completed jobs that resulted in a payout.
  int get totalJobs => totalPayoutsAllocated;

  /// Represents the total earnings (Money already in bank + Money waiting in escrow).
  double get totalEarned => totalWithdrawn + pendingEscrow;

  @override
  List<Object?> get props => [
    totalPayoutsAllocated,
    totalWithdrawn,
    pendingEscrow,
    cashOnDeliveryVolume, // 🎯 FIXED: Added missing props for strict Equatable comparison
    digitalGatewayVolume, // 🎯 FIXED: Added missing props for strict Equatable comparison
  ];
}
