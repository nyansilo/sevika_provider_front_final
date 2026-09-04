import '../../domain/entities/social_auth_response_entity.dart';
import '../../domain/entities/social_auth_status.dart';
import 'auth_response_model.dart';

class SocialAuthResponseModel extends SocialAuthResponseEntity {
  const SocialAuthResponseModel({
    required super.status,
    super.message,
    super.tempToken,
    super.authData,
  });

  factory SocialAuthResponseModel.fromJson(Map<String, dynamic> json) {
    final status = SocialAuthStatus.fromString(json['status']?.toString());

    return SocialAuthResponseModel(
      status: status,
      message: json['message']?.toString(),
      tempToken: json['tempToken']?.toString(), // 🚀 CamelCase support
      authData: status == SocialAuthStatus.success && json['data'] != null
          ? AuthResponseModel.fromJson(json['data']).toEntity()
          : null,
    );
  }
}
