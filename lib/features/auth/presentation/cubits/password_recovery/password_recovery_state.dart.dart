import 'package:equatable/equatable.dart';
import '../../../../../core/errors/app_error.dart';

abstract class PasswordRecoveryState extends Equatable {
  const PasswordRecoveryState();

  @override
  List<Object?> get props => [];
}

class PasswordRecoveryInitial extends PasswordRecoveryState {}

class PasswordRecoveryLoading extends PasswordRecoveryState {}

class ForgotPasswordSuccess extends PasswordRecoveryState {
  final String message;
  const ForgotPasswordSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ResetPasswordSuccess extends PasswordRecoveryState {
  final String message;
  const ResetPasswordSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class PasswordRecoveryError extends PasswordRecoveryState {
  final AppError error;
  const PasswordRecoveryError(this.error);

  @override
  List<Object?> get props => [error];
}
