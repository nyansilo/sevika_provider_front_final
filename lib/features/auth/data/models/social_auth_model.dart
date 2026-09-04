/// A transient Data Model capturing raw data directly from the Native SDKs.
class SocialAuthModel {
  final String token;
  final String? firstName;
  final String? lastName;

  SocialAuthModel({required this.token, this.firstName, this.lastName});
}
