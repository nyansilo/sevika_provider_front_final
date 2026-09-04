import '../../domain/entities/earning_entity.dart';

class EarningModel extends EarningEntity {
  const EarningModel({
    required super.payoutId,
    super.bookingReference,
    required super.netEarnings,
    required super.currency,
    required super.gatewayMethod,
    required super.escrowStatus,
    super.allocatedTime,
    required super.serviceTitle,
    required super.clientName,
  });

  factory EarningModel.fromJson(Map<String, dynamic> json) {
    return EarningModel(
      payoutId: json['payoutId']?.toString() ?? '',
      bookingReference: json['bookingReference']?.toString(),
      netEarnings: (json['netEarnings'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency']?.toString() ?? 'TZS',
      gatewayMethod: json['gatewayMethod']?.toString() ?? 'cash',
      escrowStatus: json['escrowStatus']?.toString() ?? 'cleared',
      allocatedTime: json['allocatedTime'] != null
          ? DateTime.tryParse(json['allocatedTime'])
          : null,
      serviceTitle: json['serviceDetails']?['title']?.toString() ?? 'Service',
      clientName: json['serviceDetails']?['clientName']?.toString() ?? 'Client',
    );
  }
}
