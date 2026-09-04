import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_error.dart';
import '../../../domain/entities/user_profile_entity.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

/// 🔄 Initial state prior to fetching the resource from Sevika API services
class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

/// ⏳ Full-screen loading state for the initial retrieval pass
class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

/// 🏎️ The primary loaded data model matrix container
class ProfileLoaded extends ProfileState {
  final UserProfileEntity profile;
  final bool isUpdating;
  final AppError? error;
  final String? successMessage;

  const ProfileLoaded({
    required this.profile,
    this.isUpdating = false,
    this.error,
    this.successMessage,
  });

  ProfileLoaded copyWith({
    UserProfileEntity? profile,
    bool? isUpdating,
    AppError? error,
    String? successMessage,
    bool clearAlerts = false,
  }) {
    return ProfileLoaded(
      profile: profile ?? this.profile,
      isUpdating: isUpdating ?? this.isUpdating,
      error: clearAlerts ? null : (error ?? this.error),
      successMessage: clearAlerts
          ? null
          : (successMessage ?? this.successMessage),
    );
  }

  @override
  List<Object?> get props => [profile, isUpdating, error, successMessage];
}

/// ❌ Terminal failure state if initial data loading crashes completely
class ProfileFailure extends ProfileState {
  final AppError error;

  const ProfileFailure(this.error);

  @override
  List<Object?> get props => [error];
}
