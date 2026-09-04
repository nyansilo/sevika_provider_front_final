import 'package:flutter/foundation.dart';
import '../../domain/entities/emergency_entity.dart';
import 'emergency_service_model.dart';

class EmergencyModel extends EmergencyEntity {
  const EmergencyModel({
    required super.id,
    super.bookingId,
    super.bookingReference,
    required super.serviceId,
    super.service,
    super.category,
    required super.status,
    required super.latitude,
    required super.longitude,
    super.addressText,
    required super.dispatchedAt,
    super.acceptedAt,
  });

  factory EmergencyModel.fromJson(Map<String, dynamic> json) {
    try {
      return EmergencyModel(
        id: json['id']?.toString() ?? '',
        bookingId: json['bookingId'] as int? ?? json['booking_id'] as int?,
        bookingReference:
            json['bookingReference']?.toString() ??
            json['booking_reference']?.toString(),
        serviceId:
            json['serviceId']?.toString() ??
            json['service_id']?.toString() ??
            '',
        service: json['service'] != null
            ? EmergencyServiceModel.fromJson(
                json['service'] as Map<String, dynamic>,
              )
            : null,
        category: json['category']?.toString(),
        status: json['status']?.toString() ?? 'pending',
        latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
        longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
        addressText:
            json['addressText']?.toString() ?? json['address_text']?.toString(),
        dispatchedAt:
            json['dispatchedAt']?.toString() ??
            json['dispatched_at']?.toString() ??
            '',
        acceptedAt:
            json['acceptedAt']?.toString() ?? json['accepted_at']?.toString(),
      );
    } catch (e, stackTrace) {
      debugPrint('Parsing Exception inside EmergencyModel: $e\n$stackTrace');
      throw FormatException('Invalid Emergency structural model mapping: $e');
    }
  }

  EmergencyEntity toEntity() => this;
}
