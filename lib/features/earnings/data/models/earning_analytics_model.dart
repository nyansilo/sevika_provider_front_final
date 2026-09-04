import '../../domain/entities/earnings_analytics_entity.dart';

class EarningsAnalyticsModel extends EarningsAnalyticsEntity {
  const EarningsAnalyticsModel({
    required super.totalPayoutsAllocated,
    required super.totalWithdrawn,
    required super.pendingEscrow,
    required super.cashOnDeliveryVolume,
    required super.digitalGatewayVolume,
  });

  factory EarningsAnalyticsModel.fromJson(Map<String, dynamic> json) {
    return EarningsAnalyticsModel(
      totalPayoutsAllocated:
          (json['totalPayoutsAllocated'] as num?)?.toInt() ?? 0,
      totalWithdrawn: (json['totalWithdrawn'] as num?)?.toDouble() ?? 0.0,
      pendingEscrow: (json['pendingEscrow'] as num?)?.toDouble() ?? 0.0,
      cashOnDeliveryVolume:
          (json['cashOnDeliveryVolume'] as num?)?.toDouble() ?? 0.0,
      digitalGatewayVolume:
          (json['digitalGatewayVolume'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
