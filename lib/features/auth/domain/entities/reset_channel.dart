/// Defines how the user wants to receive their OTP code.
enum ResetChannel {
  email,
  phone;

  String get name => toString().split('.').last;
}
