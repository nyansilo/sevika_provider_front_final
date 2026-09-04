import 'package:equatable/equatable.dart';
import '../../../../../core/errors/app_error.dart';
import '../../../domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthChecking extends AuthState {
  const AuthChecking();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final UserEntity user;
  final AppError? error;
  final String? successMessage;
  final bool isLoading;

  const AuthAuthenticated({
    required this.user,
    this.error,
    this.successMessage,
    this.isLoading = false,
  });

  AuthAuthenticated copyWith({
    UserEntity? user,
    AppError? error,
    String? successMessage,
    bool? isLoading,
    bool clearAlerts = false,
  }) {
    return AuthAuthenticated(
      user: user ?? this.user,
      error: clearAlerts ? null : (error ?? this.error),
      successMessage: clearAlerts
          ? null
          : (successMessage ?? this.successMessage),
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [user, error, successMessage, isLoading];
}

// 🎯 UPDATED: Added an optional message so we can inform the user their account was deleted!
class AuthUnauthenticated extends AuthState {
  final String? message;
  const AuthUnauthenticated({this.message});

  @override
  List<Object?> get props => [message];
}

class AuthError extends AuthState {
  final AppError error;
  const AuthError(this.error);

  @override
  List<Object?> get props => [error];
}

// 🚀 Social Flow Dialog States
class AuthRequiresEmail extends AuthState {
  final String tempToken;
  final String message;

  const AuthRequiresEmail({required this.tempToken, required this.message});

  @override
  List<Object?> get props => [tempToken, message];
}

class AuthRequiresPassword extends AuthState {
  final String tempToken;
  final String email;
  final String message;

  const AuthRequiresPassword({
    required this.tempToken,
    required this.email,
    required this.message,
  });

  @override
  List<Object?> get props => [tempToken, email, message];
}

class AuthRequiresPhoneNumber extends AuthState {
  final UserEntity user;

  const AuthRequiresPhoneNumber({required this.user});

  @override
  List<Object?> get props => [user];
}
