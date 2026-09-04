import '../../domain/entities/app_theme.dart';
import '../../domain/entities/setting_entity.dart';

class SettingModel extends SettingEntity {
  const SettingModel({
    required super.theme,
    required super.languageCode,
    required super.isNotificationEnabled,
    required super.isBiometricAuthEnabled,
    required super.appVersion,
  });

  /// Instantiates settings from an internal Key-Value JSON map string cached locally
  factory SettingModel.fromJson(Map<String, dynamic> json) {
    return SettingModel(
      theme: AppTheme.fromString(json['theme'] ?? 'system'),
      languageCode: json['language_code'] ?? 'en',
      // Handles standard defensive casting for booleans
      isNotificationEnabled: json['is_notification_enabled'] ?? true,
      isBiometricAuthEnabled: json['is_biometric_auth_enabled'] ?? false,
      appVersion: json['app_version'] ?? '1.0.0',
    );
  }

  /// Packages configuration blocks back down into simple formats for SharedPreferences/Hive writes
  Map<String, dynamic> toJson() {
    return {
      'theme': theme.name,
      'language_code': languageCode,
      'is_notification_enabled': isNotificationEnabled,
      'is_biometric_auth_enabled': isBiometricAuthEnabled,
      'app_version': appVersion,
    };
  }

  /// Vital method for BLoCs. Allows modifying isolated preferences while copying forward the remaining state.
  SettingModel copyWith({
    AppTheme? theme,
    String? languageCode,
    bool? isNotificationEnabled,
    bool? isBiometricAuthEnabled,
    String? appVersion,
  }) {
    return SettingModel(
      theme: theme ?? this.theme,
      languageCode: languageCode ?? this.languageCode,
      isNotificationEnabled:
          isNotificationEnabled ?? this.isNotificationEnabled,
      isBiometricAuthEnabled:
          isBiometricAuthEnabled ?? this.isBiometricAuthEnabled,
      appVersion: appVersion ?? this.appVersion,
    );
  }
}
