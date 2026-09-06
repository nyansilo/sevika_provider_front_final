import '../../domain/entities/provider_review_customer_entity.dart';

class ProviderReviewCustomerModel extends ProviderReviewCustomerEntity {
  const ProviderReviewCustomerModel({
    required super.id,
    required super.name,
    required super.avatar,
  });

  factory ProviderReviewCustomerModel.fromJson(Map<String, dynamic> json) {
    return ProviderReviewCustomerModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Anonymous',
      avatar: json['avatar']?.toString() ?? '',
    );
  }
}
