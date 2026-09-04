import 'package:equatable/equatable.dart';
import 'auth_response_entity.dart';
import 'social_auth_status.dart';

class SocialAuthResponseEntity extends Equatable {
  final SocialAuthStatus status;
  final String? message;
  final String? tempToken;
  final AuthResponseEntity? authData;

  const SocialAuthResponseEntity({
    required this.status,
    this.message,
    this.tempToken,
    this.authData,
  });

  @override
  List<Object?> get props => [status, message, tempToken, authData];
}
