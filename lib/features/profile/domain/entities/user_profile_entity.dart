import 'package:equatable/equatable.dart';

import '../../../auth/domain/entities/user_entity.dart';
import 'provider_profile_entity.dart';

class UserProfileEntity extends Equatable {
  final UserEntity userBase;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final ProviderProfileEntity? providerProfile;

  const UserProfileEntity({
    required this.userBase,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.providerProfile,
  });

  @override
  List<Object?> get props => [
    userBase,
    isActive,
    createdAt,
    updatedAt,
    providerProfile,
  ];
}
