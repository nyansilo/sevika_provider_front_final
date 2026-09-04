enum AppTheme {
  light,
  dark,
  system;

  static AppTheme fromString(String value) {
    return AppTheme.values.firstWhere(
      (element) => element.name == value.toLowerCase(),
      orElse: () => AppTheme.system,
    );
  }
}
