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
  });

  UserEntity toEntity() => this;

  factory UserModel.fromJson(Map<String, dynamic> json) {
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
  };
}
