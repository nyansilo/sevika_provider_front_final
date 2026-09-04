import 'package:equatable/equatable.dart';

import '../../../booking/domain/entities/pagination_entity.dart';

class EarningEntity extends Equatable {
  final String payoutId;
  final String? bookingReference;
  final double netEarnings;
  final String currency;
  final String gatewayMethod;
  final String escrowStatus;
  final DateTime? allocatedTime;
  final String serviceTitle;
  final String clientName;

  const EarningEntity({
    required this.payoutId,
    this.bookingReference,
    required this.netEarnings,
    required this.currency,
    required this.gatewayMethod,
    required this.escrowStatus,
    this.allocatedTime,
    required this.serviceTitle,
    required this.clientName,
  });

  @override
  List<Object?> get props => [payoutId, netEarnings, escrowStatus];
}
