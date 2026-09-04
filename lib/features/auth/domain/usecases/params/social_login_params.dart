import 'package:equatable/equatable.dart';
import '../../entities/social_provider.dart';

class SocialLoginParams extends Equatable {
  final SocialProvider socialProvider;
  final String token;
  final String? firstName;
  final String? lastName;

  const SocialLoginParams({
    required this.socialProvider,
    required this.token,
    this.firstName,
    this.lastName,
  });

  Map<String, dynamic> toMap() => {
    'socialProvider': socialProvider.name,
    'token': token,
    if (firstName != null) 'firstName': firstName,
    if (lastName != null) 'lastName': lastName,
  };

  @override
  List<Object?> get props => [socialProvider, token, firstName, lastName];
}
