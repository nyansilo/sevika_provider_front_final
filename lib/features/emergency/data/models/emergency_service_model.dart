import '../../domain/entities/emergency_entity.dart';

class EmergencyServiceModel extends EmergencyServiceEntity {
  const EmergencyServiceModel({
    required super.id,
    required super.title,
    super.image,
    required super.pricingType,
  });

  factory EmergencyServiceModel.fromJson(Map<String, dynamic> json) {
    return EmergencyServiceModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      image: json['image']?.toString(),
      // 🎯 Dual-key parsing for pricing type
      pricingType:
          json['pricingType']?.toString() ??
          json['pricing_type']?.toString() ??
          'fixed',
    );
  }
}
