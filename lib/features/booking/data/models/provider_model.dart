import '../../domain/entities/provider_entity.dart';

class ProviderModel extends ProviderEntity {
  const ProviderModel({
    required super.id,
    required super.fullName,
    required super.businessName,
    required super.profileImageUrl,
    required super.phone,
    required super.rating,
  });

  ProviderEntity toEntity() => this;

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: json['id']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? 'Independent Professional',
      businessName: json['businessName']?.toString() ?? 'Independent Business',
      phone: json['phone']?.toString() ?? '',
      profileImageUrl: json['profileImageUrl']?.toString() ?? '',
      rating: json['rating'] != null
          ? (num.tryParse(json['rating'].toString())?.toDouble() ?? 5.0)
          : 5.0,
    );
  }
}
