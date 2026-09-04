import '../../domain/entities/provider_profile_entity.dart';

class ProviderProfileModel extends ProviderProfileEntity {
  const ProviderProfileModel({
    required super.id,
    required super.defaultAddress,
    required super.city,
    super.alternativePhone,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProviderProfileModel.fromJson(Map<String, dynamic> json) {
    return ProviderProfileModel(
      // 🎯 FIXED: Safely convert the UUID to a string instead of trying to parse an int
      id: json['id']?.toString() ?? '',

      defaultAddress:
          json['defaultAddress']?.toString() ??
          json['default_address']?.toString() ??
          '',
      city: json['city']?.toString() ?? '',
      alternativePhone:
          json['alternativePhone']?.toString() ??
          json['alternative_phone']?.toString(),
      createdAt:
          json['createdAt']?.toString() ?? json['created_at']?.toString() ?? '',
      updatedAt:
          json['updatedAt']?.toString() ?? json['updated_at']?.toString() ?? '',
    );
  }
}
