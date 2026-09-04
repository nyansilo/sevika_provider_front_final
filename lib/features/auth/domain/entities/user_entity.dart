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

  const UserEntity({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.role,
    required this.profileImage,
    required this.pushNotificationsEnabled,
  });

  String get name => '$firstName $lastName'.trim();

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
  ];
}
