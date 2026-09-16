// import 'package:equatable/equatable.dart';

// import 'user_role.dart';

// class UserEntity extends Equatable {
//   final String userId;
//   final String firstName;
//   final String lastName;
//   final String phoneNumber;
//   final String email;
//   final UserRole role;
//   final String profileImage;
//   final bool pushNotificationsEnabled;

//   // 🚀 ADDED: KYC Trust & Safety fields
//   final String kycStatus;
//   final String
//   kycTier; // 🎯 NEW: Tracks 'unverified', 'basic', or 'professional' globally
//   final bool isKycApproved; // 🎯 KEPT: Convenience boolean for quick Tier 1 baseline checks

//   const UserEntity({
//     required this.userId,
//     required this.firstName,
//     required this.lastName,
//     required this.phoneNumber,
//     required this.email,
//     required this.role,
//     required this.profileImage,
//     required this.pushNotificationsEnabled,
//     // 🚀 ADDED
//     required this.kycStatus,
//     required this.kycTier,
//     required this.isKycApproved,
//   });

//   String get name => '$firstName $lastName'.trim();

//   // 🛡️ DECISION ENGINE HELPERS (Use these on your UI buttons!)
//   bool get canAcceptInstantJobs =>
//       kycTier == 'basic' || kycTier == 'professional';
//   bool get canBidOnCustomJobs => kycTier == 'professional';

//   @override
//   List<Object?> get props => [
//     userId,
//     firstName,
//     lastName,
//     phoneNumber,
//     email,
//     role,
//     profileImage,
//     pushNotificationsEnabled,
//     kycStatus,
//     kycTier,
//     isKycApproved,
//   ];
// }

import 'package:equatable/equatable.dart';

import 'user_role.dart';

class UserEntity extends Equatable {
  final String userId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final UserRole role;
  final String profileImage;
  final bool pushNotificationsEnabled;

  // 🚀 ADDED: System Availability State
  final bool isOnline;

  // 🚀 ADDED: KYC Trust & Safety fields
  final String kycStatus;
  final String kycTier;
  final bool isKycApproved;

  const UserEntity({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.role,
    required this.profileImage,
    required this.pushNotificationsEnabled,
    required this.isOnline, // 🎯 NEW
    required this.kycStatus,
    required this.kycTier,
    required this.isKycApproved,
  });

  String get name => '$firstName $lastName'.trim();

  // 🛡️ DECISION ENGINE HELPERS
  bool get canAcceptInstantJobs =>
      kycTier == 'basic' || kycTier == 'professional';
  bool get canBidOnCustomJobs => kycTier == 'professional';

  @override
  List<Object?> get props => [
    userId,
    firstName,
    lastName,
    phoneNumber,
    email,
    role,
    profileImage,
    pushNotificationsEnabled,
    isOnline, // 🎯 NEW
    kycStatus,
    kycTier,
    isKycApproved,
  ];
}
