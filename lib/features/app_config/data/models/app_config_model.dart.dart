import '../../domain/entities/app_config_entity.dart';

class AppConfigModel extends AppConfigEntity {
  const AppConfigModel({
    required super.platform,
    required super.minVersion,
    required super.latestVersion,
    required super.storeUrl,
    required super.isMaintenance,
    super.maintenanceEta,
    super.maintenanceMessage,
    super.forceUpdateMessage,
    super.softUpdateMessage,
    super.termsVersion,
    super.supportPhone,
    super.supportWhatsapp,
    required super.featureFlags,
  });

  factory AppConfigModel.fromJson(Map<String, dynamic> json) {
    // 🎯 BEST PRACTICE: Safely handle both snake_case (from Laravel)
    // and camelCase (if middle-ware formats it) to prevent null crashes.
    return AppConfigModel(
      platform: json['platform']?.toString() ?? '',
      minVersion:
          json['minVersion']?.toString() ??
          json['min_version']?.toString() ??
          '1.0.0',
      latestVersion:
          json['latestVersion']?.toString() ??
          json['latest_version']?.toString() ??
          '1.0.0',
      storeUrl:
          json['storeUrl']?.toString() ?? json['store_url']?.toString() ?? '',

      // 🛠️ MAINTENANCE & ALERTS
      isMaintenance: json['isMaintenance'] ?? json['is_maintenance'] ?? false,
      maintenanceEta:
          json['maintenanceEta']?.toString() ??
          json['maintenance_eta']?.toString(),
      maintenanceMessage:
          json['maintenanceMessage']?.toString() ??
          json['maintenance_message']?.toString(),
      forceUpdateMessage:
          json['forceUpdateMessage']?.toString() ??
          json['force_update_message']?.toString(),
      softUpdateMessage:
          json['softUpdateMessage']?.toString() ??
          json['soft_update_message']?.toString(),

      // ⚖️ LEGAL & SUPPORT
      termsVersion:
          json['termsVersion']?.toString() ?? json['terms_version']?.toString(),
      supportPhone:
          json['supportPhone']?.toString() ?? json['support_phone']?.toString(),
      supportWhatsapp:
          json['supportWhatsapp']?.toString() ??
          json['support_whatsapp']?.toString(),

      // 🧰 FEATURE FLAGS (Cast safely to Map)
      featureFlags:
          (json['featureFlags'] ?? json['feature_flags'] ?? {})
              as Map<String, dynamic>,
    );
  }

  /// Helper to map back to the pure entity for the Domain layer
  AppConfigEntity toEntity() {
    return AppConfigEntity(
      platform: platform,
      minVersion: minVersion,
      latestVersion: latestVersion,
      storeUrl: storeUrl,
      isMaintenance: isMaintenance,
      maintenanceEta: maintenanceEta,
      maintenanceMessage: maintenanceMessage,
      forceUpdateMessage: forceUpdateMessage,
      softUpdateMessage: softUpdateMessage,
      termsVersion: termsVersion,
      supportPhone: supportPhone,
      supportWhatsapp: supportWhatsapp,
      featureFlags: featureFlags,
    );
  }
}
