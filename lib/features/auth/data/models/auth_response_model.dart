// import '../../domain/entities/auth_response_entity.dart';
// import '../../domain/entities/user_entity.dart';

// import '../../domain/entities/user_role.dart';
// import 'user_model.dart';

// class AuthResponseModel {
//   final String tokenType;
//   final String accessToken;
//   final String refreshToken;
//   final UserModel? user;

//   AuthResponseModel({
//     required this.tokenType,
//     required this.accessToken,
//     required this.refreshToken,
//     this.user,
//   });

//   AuthResponseEntity toEntity() {
//     return AuthResponseEntity(
//       tokenType: tokenType,
//       accessToken: accessToken,
//       refreshToken: refreshToken,
//       user:
//           user ??
//           const UserEntity(
//             userId: '',
//             firstName: '',
//             lastName: '',
//             phoneNumber: '',
//             email: '',
//             role: UserRole.customer,
//             profileImage: '',
//             //pushNotificationsEnabled: true,
//           ),
//     );
//   }

//   factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
//     final Map<String, dynamic> target = (json['data'] is Map<String, dynamic>)
//         ? json['data'] as Map<String, dynamic>
//         : json;
//     return AuthResponseModel(
//       tokenType:
//           target['tokenType']?.toString() ??
//           target['token_type']?.toString() ??
//           'Bearer',
//       accessToken:
//           target['accessToken']?.toString() ??
//           target['access_token']?.toString() ??
//           '',
//       refreshToken:
//           target['refreshToken']?.toString() ??
//           target['refresh_token']?.toString() ??
//           '',
//       user: target['user'] != null
//           ? UserModel.fromJson(target['user'] as Map<String, dynamic>)
//           : null,
//     );
//   }
// }

import 'package:equatable/equatable.dart';

import '../../domain/entities/auth_response_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/user_role.dart';
import 'user_model.dart';

class AuthResponseModel extends Equatable {
  final String tokenType;
  final String accessToken;
  final String refreshToken;
  final UserModel? user;

  const AuthResponseModel({
    required this.tokenType,
    required this.accessToken,
    required this.refreshToken,
    this.user,
  });

  /// 🔄 MAP TO DOMAIN ENTITY
  AuthResponseEntity toEntity() {
    return AuthResponseEntity(
      tokenType: tokenType,
      accessToken: accessToken,
      refreshToken: refreshToken,
      // 🛡️ Provide a safe fallback if user payload is missing (e.g., on token refresh)
      user:
          user ??
          const UserEntity(
            userId: '',
            firstName: '',
            lastName: '',
            phoneNumber: '',
            email: '',
            role: UserRole.customer,
            profileImage: '',
            pushNotificationsEnabled:
                true, // 🎯 Restored to align with AuthCubit requirements
          ),
    );
  }

  /// 📥 PARSE FROM JSON
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    // 🛡️ Safely unwrap the 'data' payload if the backend wrapped it
    final Map<String, dynamic> target =
        json.containsKey('data') && json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    return AuthResponseModel(
      tokenType:
          target['tokenType']?.toString() ??
          target['token_type']?.toString() ??
          'Bearer',
      accessToken:
          target['accessToken']?.toString() ??
          target['access_token']?.toString() ??
          '',
      refreshToken:
          target['refreshToken']?.toString() ??
          target['refresh_token']?.toString() ??
          '',
      user: target['user'] != null
          ? UserModel.fromJson(target['user'] as Map<String, dynamic>)
          : null,
    );
  }

  /// 📤 SERIALIZE TO JSON
  /// Standard practice ensures models can be converted back to JSON for local caching or debugging.
  Map<String, dynamic> toJson() {
    return {
      'token_type': tokenType,
      'access_token': accessToken,
      'refresh_token': refreshToken,
      if (user != null) 'user': user!.toJson(),
    };
  }

  @override
  List<Object?> get props => [tokenType, accessToken, refreshToken, user];
}
