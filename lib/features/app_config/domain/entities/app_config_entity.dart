import 'package:equatable/equatable.dart';

class AppConfigEntity extends Equatable {
  final String platform;
  final String minVersion;
  final String latestVersion;
  final String storeUrl;

  // 🚀 ADDED: System Control Fields
  final bool isMaintenance;
  final String? maintenanceEta;
  final String? maintenanceMessage;
  final String? forceUpdateMessage;
  final String? softUpdateMessage;
  final String? termsVersion;
  final String? supportPhone;
  final String? supportWhatsapp;
  final Map<String, dynamic> featureFlags;

  const AppConfigEntity({
    required this.platform,
    required this.minVersion,
    required this.latestVersion,
    required this.storeUrl,
    required this.isMaintenance,
    this.maintenanceEta,
    this.maintenanceMessage,
    this.forceUpdateMessage,
    this.softUpdateMessage,
    this.termsVersion,
    this.supportPhone,
    this.supportWhatsapp,
    required this.featureFlags,
  });

  @override
  List<Object?> get props => [
    platform,
    minVersion,
    latestVersion,
    storeUrl,
    isMaintenance,
    maintenanceEta,
    maintenanceMessage,
    forceUpdateMessage,
    softUpdateMessage,
    termsVersion,
    supportPhone,
    supportWhatsapp,
    featureFlags,
  ];
}
