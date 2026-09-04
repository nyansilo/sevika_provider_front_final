// import 'package:equatable/equatable.dart';

// /// 🎯 INDUSTRY PRACTICE: We encapsulate the final decision into an Entity,
// /// keeping boolean logic out of the presentation layer.
// class AppUpdateStatusEntity extends Equatable {
//   final bool isForceUpdateRequired;
//   final bool isSoftUpdateAvailable;
//   final String storeUrl;

//   // 🚀 ADDED: Maintenance locks parsed from the Config
//   final bool isMaintenanceMode;
//   final String? maintenanceEta;

//   const AppUpdateStatusEntity({
//     required this.isForceUpdateRequired,
//     required this.isSoftUpdateAvailable,
//     required this.storeUrl,
//     this.isMaintenanceMode = false,
//     this.maintenanceEta,
//   });

//   @override
//   List<Object?> get props => [
//     isForceUpdateRequired,
//     isSoftUpdateAvailable,
//     storeUrl,
//     isMaintenanceMode,
//     maintenanceEta,
//   ];
// }

import 'package:equatable/equatable.dart';

/// 🎯 INDUSTRY PRACTICE: We encapsulate the final decision into an Entity,
/// keeping boolean logic out of the presentation layer.
class AppUpdateStatusEntity extends Equatable {
  final bool isForceUpdateRequired;
  final bool isSoftUpdateAvailable;
  final String storeUrl;

  // 🚀 ADDED: Maintenance locks parsed from the Config
  final bool isMaintenanceMode;
  final String? maintenanceEta;

  // 📞 ADDED: Support contact channels parsed from the remote config payload
  final String? supportPhone;
  final String? supportWhatsapp;

  const AppUpdateStatusEntity({
    required this.isForceUpdateRequired,
    required this.isSoftUpdateAvailable,
    required this.storeUrl,
    this.isMaintenanceMode = false,
    this.maintenanceEta,
    this.supportPhone,
    this.supportWhatsapp,
  });

  @override
  List<Object?> get props => [
    isForceUpdateRequired,
    isSoftUpdateAvailable,
    storeUrl,
    isMaintenanceMode,
    maintenanceEta,
    supportPhone,
    supportWhatsapp,
  ];
}
