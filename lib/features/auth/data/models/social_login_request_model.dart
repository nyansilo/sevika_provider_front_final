import 'package:equatable/equatable.dart';

/// 🚀 STRICT CLEAN ARCHITECTURE:
/// This is a DTO (Data Transfer Object) specifically shaped for the Laravel Network API.
/// It lives in the Data Layer because the Domain Layer shouldn't care about JSON mapping.
class SocialLoginRequestModel extends Equatable {
  final String socialProvider;
  final String token;
  final String? firstName;
  final String? lastName;

  const SocialLoginRequestModel({
    required this.socialProvider,
    required this.token,
    this.firstName,
    this.lastName,
  });

  Map<String, dynamic> toMap() => {
    'socialProvider': socialProvider,
    'token': token,
    if (firstName != null) 'firstName': firstName,
    if (lastName != null) 'lastName': lastName,
  };

  @override
  List<Object?> get props => [socialProvider, token, firstName, lastName];
}
