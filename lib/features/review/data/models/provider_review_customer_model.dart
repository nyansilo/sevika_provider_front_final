// import '../../domain/entities/provider_review_customer_entity.dart';

// class ProviderReviewCustomerModel extends ProviderReviewCustomerEntity {
//   const ProviderReviewCustomerModel({
//     required super.id,
//     required super.name,
//     required super.avatar,
//   });

//   factory ProviderReviewCustomerModel.fromJson(Map<String, dynamic> json) {
//     return ProviderReviewCustomerModel(
//       id: json['id']?.toString() ?? '',
//       name: json['name']?.toString() ?? 'Anonymous',
//       avatar: json['avatar']?.toString() ?? '',
//     );
//   }
// }

// lib/features/reviews/data/models/provider_review_customer_model.dart
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

  /// 🚀 Explicit conversion to Entity
  ProviderReviewCustomerEntity toEntity() {
    return ProviderReviewCustomerEntity(id: id, name: name, avatar: avatar);
  }
}
