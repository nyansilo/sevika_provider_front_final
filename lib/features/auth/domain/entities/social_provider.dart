/// Strongly typed enum for the available social login platforms.
enum SocialProvider {
  google,
  facebook,
  apple;

  String get name => toString().split('.').last;

  static SocialProvider fromString(String? provider) {
    if (provider == null) return SocialProvider.google;
    return SocialProvider.values.firstWhere(
      (e) => e.name == provider.toLowerCase(),
      orElse: () => SocialProvider.google,
    );
  }
}
