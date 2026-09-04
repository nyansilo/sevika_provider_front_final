import 'package:equatable/equatable.dart';
import 'app_theme.dart';

class SettingEntity extends Equatable {
  final AppTheme theme;
  final String languageCode; // e.g., 'en' for English, 'sw' for Swahili
  final bool isNotificationEnabled;
  final bool isBiometricAuthEnabled;
  final String appVersion;

  const SettingEntity({
    required this.theme,
    required this.languageCode,
    required this.isNotificationEnabled,
    required this.isBiometricAuthEnabled,
    required this.appVersion,
  });

  /// Factory constructor to serve clean, logical defaults before local storage loads
  factory SettingEntity.initial() {
    return const SettingEntity(
      theme: AppTheme.system,
      languageCode: 'en',
      isNotificationEnabled: true,
      isBiometricAuthEnabled: false,
      appVersion: '1.0.0',
    );
  }

  @override
  List<Object?> get props => [
    theme,
    languageCode,
    isNotificationEnabled,
    isBiometricAuthEnabled,
    appVersion,
  ];
}
