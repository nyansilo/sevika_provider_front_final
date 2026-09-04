import 'package:equatable/equatable.dart';

class CompleteSocialRegistrationParams extends Equatable {
  final String tempToken;
  final String email;
  final String? password;

  const CompleteSocialRegistrationParams({
    required this.tempToken,
    required this.email,
    this.password,
  });

  Map<String, dynamic> toMap() => {
    'tempToken': tempToken,
    'email': email,
    if (password != null) 'password': password,
  };

  @override
  List<Object?> get props => [tempToken, email, password];
}
