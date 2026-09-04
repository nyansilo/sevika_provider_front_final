import 'package:equatable/equatable.dart';
import 'user_entity.dart';

class AuthResponseEntity extends Equatable {
  final String tokenType;
  final String accessToken;
  final String refreshToken;
  final UserEntity user;

  const AuthResponseEntity({
    required this.tokenType,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  @override
  List<Object?> get props => [tokenType, accessToken, refreshToken, user];
}
