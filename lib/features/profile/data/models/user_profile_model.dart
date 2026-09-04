import '../../../../features/auth/data/models/user_model.dart';
import '../../domain/entities/user_profile_entity.dart';
import 'provider_profile_model.dart';

class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    required super.userBase,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
    super.providerProfile,
  });

  UserProfileEntity toEntity() => this;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    // 1️⃣ Extract target dictionary envelope block safely (strips 'data' wrapper if present)
    final target = (json['data'] is Map<String, dynamic>)
        ? json['data'] as Map<String, dynamic>
        : json;

    // 2️⃣ Handle nested "user" node maps vs flat key structures dynamically
    final Map<String, dynamic> userMap =
        (target['user'] is Map<String, dynamic>)
        ? target['user'] as Map<String, dynamic>
        : target;

    return UserProfileModel(
      userBase: UserModel.fromJson(
        userMap,
      ), // 🚀 FIXED: Passes the isolated user attributes dictionary
      isActive: target['isActive'] is bool
          ? target['isActive'] as bool
          : (target['is_active'] == 1 ||
                target['isActive'] == true ||
                target['is_active'] == true),
      createdAt:
          target['createdAt']?.toString() ??
          target['created_at']?.toString() ??
          '',
      updatedAt:
          target['updatedAt']?.toString() ??
          target['updated_at']?.toString() ??
          '',
      providerProfile: target['providerProfile'] != null
          ? ProviderProfileModel.fromJson(
              target['providerProfile'] as Map<String, dynamic>,
            )
          : target['provider_profile'] != null
          ? ProviderProfileModel.fromJson(
              target['provider_profile'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}
