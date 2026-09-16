// import '../../domain/entities/user_entity.dart';
// import '../../domain/entities/user_role.dart';

// class UserModel extends UserEntity {
//   const UserModel({
//     required super.userId,
//     required super.firstName,
//     required super.lastName,
//     required super.phoneNumber,
//     required super.email,
//     required super.role,
//     required super.profileImage,
//     required super.pushNotificationsEnabled,
//     required super.kycStatus,
//     required super.kycTier, // 🎯 NEW: Injected into constructor
//     required super.isKycApproved,
//   });

//   UserEntity toEntity() => this;

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     // 🚀 KYC INTEGRATION: Safely extract the conditional KYC block.
//     // Customers won't have this, so it will be null and fallback gracefully.
//     final kycBlock = json['kyc'] as Map<String, dynamic>?;

//     return UserModel(
//       userId: json['userId']?.toString() ?? json['id']?.toString() ?? '',
//       firstName:
//           json['firstName']?.toString() ?? json['first_name']?.toString() ?? '',
//       lastName:
//           json['lastName']?.toString() ?? json['last_name']?.toString() ?? '',
//       phoneNumber:
//           json['phoneNumber']?.toString() ??
//           json['phone_number']?.toString() ??
//           '',
//       email: json['email']?.toString() ?? '',
//       role: UserRole.fromString(json['role']?.toString()),
//       profileImage:
//           json['profileImage']?.toString() ??
//           json['profile_image']?.toString() ??
//           '',
//       pushNotificationsEnabled:
//           json['pushNotificationsEnabled'] == true ||
//           json['push_notifications_enabled'] == true ||
//           json['push_notifications_enabled'] == 1,

//       // 🚀 KYC INTEGRATION: Map the nested values or provide safe defaults
//       kycStatus: kycBlock?['status']?.toString() ?? 'unsubmitted',

//       // 🎯 NEW: Safely extract the tier string, defaulting to unverified
//       kycTier: kycBlock?['tier']?.toString() ?? 'unverified',

//       // 🎯 UPDATED: Check both the boolean AND the tier string for maximum safety
//       isKycApproved:
//           kycBlock?['isApproved'] == true ||
//           kycBlock?['tier'] == 'basic' ||
//           kycBlock?['tier'] == 'professional',
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'userId': userId,
//     'firstName': firstName,
//     'lastName': lastName,
//     'phoneNumber': phoneNumber,
//     'email': email,
//     'role': role.name,
//     'profileImage': profileImage,
//     'pushNotificationsEnabled': pushNotificationsEnabled,
//     // Serialize back to JSON for local storage
//     'kyc': {
//       'status': kycStatus,
//       'tier': kycTier, // 🎯 Included in serialization
//       'isApproved': isKycApproved,
//     },
//   };
// }

import '../../domain/entities/user_entity.dart';
import '../../domain/entities/user_role.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.userId,
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
    required super.email,
    required super.role,
    required super.profileImage,
    required super.pushNotificationsEnabled,
    required super.isOnline, // 🎯 NEW
    required super.kycStatus,
    required super.kycTier,
    required super.isKycApproved,
  });

  UserEntity toEntity() => this;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // 🚀 KYC INTEGRATION: Safely extract the conditional KYC block.
    final kycBlock = json['kyc'] as Map<String, dynamic>?;

    return UserModel(
      userId: json['userId']?.toString() ?? json['id']?.toString() ?? '',
      firstName:
          json['firstName']?.toString() ?? json['first_name']?.toString() ?? '',
      lastName:
          json['lastName']?.toString() ?? json['last_name']?.toString() ?? '',
      phoneNumber:
          json['phoneNumber']?.toString() ??
          json['phone_number']?.toString() ??
          '',
      email: json['email']?.toString() ?? '',
      role: UserRole.fromString(json['role']?.toString()),
      profileImage:
          json['profileImage']?.toString() ??
          json['profile_image']?.toString() ??
          '',
      pushNotificationsEnabled:
          json['pushNotificationsEnabled'] == true ||
          json['push_notifications_enabled'] == true ||
          json['push_notifications_enabled'] == 1,

      // 🚀 THE FIX: Parse the new isOnline state directly from the Auth Payload.
      // Defaults to false if the user is a customer or the key is missing.
      isOnline: json['isOnline'] == true || json['is_online'] == true,

      // 🚀 KYC INTEGRATION
      kycStatus: kycBlock?['status']?.toString() ?? 'unsubmitted',
      kycTier: kycBlock?['tier']?.toString() ?? 'unverified',
      isKycApproved:
          kycBlock?['isApproved'] == true ||
          kycBlock?['tier'] == 'basic' ||
          kycBlock?['tier'] == 'professional',
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'firstName': firstName,
    'lastName': lastName,
    'phoneNumber': phoneNumber,
    'email': email,
    'role': role.name,
    'profileImage': profileImage,
    'pushNotificationsEnabled': pushNotificationsEnabled,
    'isOnline':
        isOnline, // 🎯 NEW: Serialize for local Hive/SharedPrefs caching
    'kyc': {'status': kycStatus, 'tier': kycTier, 'isApproved': isKycApproved},
  };
}
