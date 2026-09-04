enum SocialAuthStatus {
  success,
  requiresEmail,
  passwordRequired;

  String get name => toString().split('.').last;

  static SocialAuthStatus fromString(String? status) {
    switch (status?.toUpperCase()) {
      case 'REQUIRES_EMAIL':
        return SocialAuthStatus.requiresEmail;
      case 'PASSWORD_REQUIRED':
        return SocialAuthStatus.passwordRequired;
      case 'SUCCESS':
      default:
        return SocialAuthStatus.success;
    }
  }
}
