import '../../../../core/constants/api_endpoints.dart';
import '../../domain/entities/customer_entity.dart';

class CustomerModel extends CustomerEntity {
  const CustomerModel({
    required super.fullName,
    required super.phoneNumber,
    required super.avatar,
  });

  CustomerEntity toEntity() => this;

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    // 🎯 FIXED: Sanitize the URL immediately upon parsing!
    final rawAvatar = json['avatar']?.toString() ?? '';
    final safeAvatarUrl = ApiEndpoints.sanitizeBackendUrl(rawAvatar);

    return CustomerModel(
      fullName: json['fullName']?.toString() ?? 'Verified Client',
      phoneNumber: json['phoneNumber']?.toString() ?? 'Hidden until accepted',
      avatar: safeAvatarUrl,
    );
  }
}
