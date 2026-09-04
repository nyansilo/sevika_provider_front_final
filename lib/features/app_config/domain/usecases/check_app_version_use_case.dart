// import 'package:dartz/dartz.dart';
// import 'package:flutter/foundation.dart'; // 📦 Added for debugPrint
// import 'package:pub_semver/pub_semver.dart'; // Pure Dart package, safe for Domain layer
// import '../../../../core/errors/app_error.dart';
// import '../../../../core/usecases/usecase.dart';
// import '../entities/app_update_status_entity.dart';
// import '../repositories/app_config_repository.dart';
// import '../repositories/local_app_info_repository.dart';

// class CheckAppVersionUseCase
//     implements UseCase<AppUpdateStatusEntity, NoParams> {
//   final AppConfigRepository remoteRepository;
//   final LocalAppInfoRepository localRepository;

//   CheckAppVersionUseCase({
//     required this.remoteRepository,
//     required this.localRepository,
//   });

//   /// 🛠️ Helper to fix invalid Apple/Android version formats (e.g. "1.0" -> "1.0.0")
//   /// pub_semver strictly requires Major.Minor.Patch format to work properly.
//   String _sanitizeVersion(String version) {
//     if (version.isEmpty) return "1.0.0";

//     // Strip out build numbers (e.g., +1) just for the mathematical comparison
//     final cleanVersion = version.split('+')[0];
//     final parts = cleanVersion.split('.');

//     // Append missing ".0" to ensure it meets Semantic Versioning standards
//     if (parts.length == 1) return "${parts[0]}.0.0";
//     if (parts.length == 2) return "${parts[0]}.${parts[1]}.0";

//     return cleanVersion;
//   }

//   @override
//   Future<Either<AppError, AppUpdateStatusEntity>> call(NoParams params) async {
//     // 1. Fetch backend configuration requirements
//     final remoteResult = await remoteRepository.getAppConfig();

//     return remoteResult.fold(
//       (error) {
//         debugPrint(
//           '🚨 [AppVersion] Failed to fetch backend config: ${error.message}',
//         );
//         return Left(error); // Pass API errors down the chain
//       },
//       (remoteConfig) async {
//         try {
//           // 2. Fetch local version cleanly via abstraction
//           final String currentAppVersionString = await localRepository
//               .getCurrentAppVersion();

//           // 🎯 Apply the sanitizer to prevent format exceptions on iOS/Android
//           final String safeLocal = _sanitizeVersion(currentAppVersionString);
//           final String safeMin = _sanitizeVersion(remoteConfig.minVersion);

//           // 🚀 ADDED: Sanitize the latest_version for soft updates
//           final String safeLatest = _sanitizeVersion(
//             remoteConfig.latestVersion,
//           );

//           debugPrint(
//             '📱 [AppVersion] Raw Local: $currentAppVersionString | Sanitized: $safeLocal',
//           );
//           debugPrint(
//             '🌐 [AppVersion] Raw Remote Min: ${remoteConfig.minVersion} | Sanitized: $safeMin',
//           );
//           debugPrint(
//             '🌐 [AppVersion] Raw Remote Latest: ${remoteConfig.latestVersion} | Sanitized: $safeLatest',
//           );

//           // 3. Parse strings into SemVer objects safely using the sanitized strings
//           final currentVersion = Version.parse(safeLocal);
//           final minVersion = Version.parse(safeMin);
//           final latestVersion = Version.parse(safeLatest);

//           // 4. Compare:
//           // HARD UPDATE: Is the required minimum greater than what we currently have installed?
//           final bool isForceUpdateRequired = minVersion > currentVersion;

//           // SOFT UPDATE: Is a newer version available, but not strictly forced?
//           final bool isSoftUpdateAvailable =
//               !isForceUpdateRequired && (latestVersion > currentVersion);

//           debugPrint(
//             '⚖️ [AppVersion] Force Update Required? $isForceUpdateRequired',
//           );
//           debugPrint(
//             '⚖️ [AppVersion] Soft Update Available? $isSoftUpdateAvailable',
//           );

//           return Right(
//             AppUpdateStatusEntity(
//               isForceUpdateRequired: isForceUpdateRequired,
//               isSoftUpdateAvailable: isSoftUpdateAvailable,
//               storeUrl: remoteConfig.storeUrl,

//               // 🚀 Pass the new maintenance flags up to the Cubit
//               isMaintenanceMode: remoteConfig.isMaintenance,
//               maintenanceEta: remoteConfig.maintenanceEta,
//             ),
//           );
//         } catch (e) {
//           debugPrint('🚨 [AppVersion] SemVer Parsing Crash: $e');

//           // 🛡️ Guard against malformed version strings (e.g. "v1.2" instead of "1.2.0")
//           // If parsing fails, we default to NOT requiring an update so we don't lock out valid users
//           // 🛡️ Safe fallback: If parsing fails (e.g., malformed string),
//           // allow the user to proceed rather than hard-locking the app.
//           return Right(
//             AppUpdateStatusEntity(
//               isForceUpdateRequired: false,
//               isSoftUpdateAvailable: false,
//               storeUrl: remoteConfig.storeUrl,
//             ),
//           );
//         }
//       },
//     );
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart'; // 📦 Added for debugPrint
import 'package:pub_semver/pub_semver.dart'; // Pure Dart package, safe for Domain layer
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/app_update_status_entity.dart';
import '../repositories/app_config_repository.dart';
import '../repositories/local_app_info_repository.dart';

class CheckAppVersionUseCase
    implements UseCase<AppUpdateStatusEntity, NoParams> {
  final AppConfigRepository remoteRepository;
  final LocalAppInfoRepository localRepository;

  CheckAppVersionUseCase({
    required this.remoteRepository,
    required this.localRepository,
  });

  /// 🛠️ Helper to fix invalid Apple/Android version formats (e.g. "1.0" -> "1.0.0")
  /// pub_semver strictly requires Major.Minor.Patch format to work properly.
  String _sanitizeVersion(String version) {
    if (version.isEmpty) return "1.0.0";

    // Strip out build numbers (e.g., +1) just for the mathematical comparison
    final cleanVersion = version.split('+')[0];
    final parts = cleanVersion.split('.');

    // Append missing ".0" to ensure it meets Semantic Versioning standards
    if (parts.length == 1) return "${parts[0]}.0.0";
    if (parts.length == 2) return "${parts[0]}.${parts[1]}.0";

    return cleanVersion;
  }

  @override
  Future<Either<AppError, AppUpdateStatusEntity>> call(NoParams params) async {
    // 1. Fetch backend configuration requirements
    final remoteResult = await remoteRepository.getAppConfig();

    return remoteResult.fold(
      (error) {
        debugPrint(
          '🚨 [AppVersion] Failed to fetch backend config: ${error.message}',
        );
        return Left(error); // Pass API errors down the chain
      },
      (remoteConfig) async {
        try {
          // 2. Fetch local version cleanly via abstraction
          final String currentAppVersionString = await localRepository
              .getCurrentAppVersion();

          // 🎯 Apply the sanitizer to prevent format exceptions on iOS/Android
          final String safeLocal = _sanitizeVersion(currentAppVersionString);
          final String safeMin = _sanitizeVersion(remoteConfig.minVersion);

          // 🚀 ADDED: Sanitize the latest_version for soft updates
          final String safeLatest = _sanitizeVersion(
            remoteConfig.latestVersion,
          );

          debugPrint(
            '📱 [AppVersion] Raw Local: $currentAppVersionString | Sanitized: $safeLocal',
          );
          debugPrint(
            '🌐 [AppVersion] Raw Remote Min: ${remoteConfig.minVersion} | Sanitized: $safeMin',
          );
          debugPrint(
            '🌐 [AppVersion] Raw Remote Latest: ${remoteConfig.latestVersion} | Sanitized: $safeLatest',
          );

          // 3. Parse strings into SemVer objects safely using the sanitized strings
          final currentVersion = Version.parse(safeLocal);
          final minVersion = Version.parse(safeMin);
          final latestVersion = Version.parse(safeLatest);

          // 4. Compare:
          // HARD UPDATE: Is the required minimum greater than what we currently have installed?
          final bool isForceUpdateRequired = minVersion > currentVersion;

          // SOFT UPDATE: Is a newer version available, but not strictly forced?
          final bool isSoftUpdateAvailable =
              !isForceUpdateRequired && (latestVersion > currentVersion);

          debugPrint(
            '⚖️ [AppVersion] Force Update Required? $isForceUpdateRequired',
          );
          debugPrint(
            '⚖️ [AppVersion] Soft Update Available? $isSoftUpdateAvailable',
          );

          return Right(
            AppUpdateStatusEntity(
              isForceUpdateRequired: isForceUpdateRequired,
              isSoftUpdateAvailable: isSoftUpdateAvailable,
              storeUrl: remoteConfig.storeUrl,

              // 🚀 Pass the new maintenance flags up to the Cubit
              isMaintenanceMode: remoteConfig.isMaintenance,
              maintenanceEta: remoteConfig.maintenanceEta,

              // 📞 Pass support channels up to the Cubit presentation states
              supportPhone: remoteConfig.supportPhone,
              supportWhatsapp: remoteConfig.supportWhatsapp,
            ),
          );
        } catch (e) {
          debugPrint('🚨 [AppVersion] SemVer Parsing Crash: $e');

          // 🛡️ Safe fallback: If parsing fails (e.g., malformed string),
          // allow the user to proceed rather than hard-locking the app.
          return Right(
            AppUpdateStatusEntity(
              isForceUpdateRequired: false,
              isSoftUpdateAvailable: false,
              storeUrl: remoteConfig.storeUrl,
              supportPhone: remoteConfig.supportPhone,
              supportWhatsapp: remoteConfig.supportWhatsapp,
            ),
          );
        }
      },
    );
  }
}
