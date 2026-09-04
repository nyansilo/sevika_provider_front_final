enum UserRole {
  customer,
  provider;

  String get name => toString().split('.').last;

  static UserRole fromString(String? role) {
    if (role == null) return UserRole.customer;
    return UserRole.values.firstWhere(
      (e) => e.name == role.toLowerCase(),
      orElse: () => UserRole.customer,
    );
  }
}
