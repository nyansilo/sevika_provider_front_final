// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/usecases/usecase.dart';
// import '../../domain/usecases/check_app_version_use_case.dart';
// import 'app_config_state.dart';

// class AppConfigCubit extends Cubit<AppConfigState> {
//   final CheckAppVersionUseCase checkAppVersionUseCase;

//   AppConfigCubit({required this.checkAppVersionUseCase})
//     : super(AppConfigInitial());

//   /// 🔄 Typically called inside your Splash Screen sequence
//   Future<void> checkAppVersion() async {
//     emit(AppConfigChecking());

//     final result = await checkAppVersionUseCase.call(const NoParams());

//     // 🎯 Guard clause to prevent emitting states if the widget is disposed
//     if (isClosed) return;

//     result.fold(
//       (error) {
//         // 🛡️ If the API fails (e.g., no internet), we let them into the app
//         // to view cached data rather than showing an update screen forever.
//         // If your app strictly requires internet, you can emit AppConfigFailure(error) instead.
//         debugPrint(
//           '⚠️ [Cubit] AppConfig API failed. Defaulting to UpToDate to let user in.',
//         );
//         emit(const AppConfigUpToDate(isSoftUpdateAvailable: false));
//       },
//       (updateStatus) {
//         // 1. 🛑 CHECK MAINTENANCE FIRST
//         if (updateStatus.isMaintenanceMode) {
//           debugPrint('🚧 [Cubit] TRAPPING USER: System is under maintenance!');
//           emit(
//             AppConfigUnderMaintenance(
//               estimatedCompletionTime: updateStatus.maintenanceEta,
//             ),
//           );
//           return; // Stop processing, user is locked out.
//         }

//         // 2. Check for HARD Force Update
//         if (updateStatus.isForceUpdateRequired) {
//           debugPrint('🛑 [Cubit] TRAPPING USER: Force Update is required!');
//           emit(AppConfigUpdateRequired(storeUrl: updateStatus.storeUrl));
//         }
//         // 3. Otherwise, check for SOFT Optional Update
//         else {
//           debugPrint(
//             '✅ [Cubit] Check complete. Soft Update Available: ${updateStatus.isSoftUpdateAvailable}',
//           );
//           emit(
//             AppConfigUpToDate(
//               isSoftUpdateAvailable: updateStatus.isSoftUpdateAvailable,
//               storeUrl: updateStatus.storeUrl,
//             ),
//           );
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/check_app_version_use_case.dart';
import 'app_config_state.dart';

class AppConfigCubit extends Cubit<AppConfigState> {
  final CheckAppVersionUseCase checkAppVersionUseCase;

  AppConfigCubit({required this.checkAppVersionUseCase})
    : super(AppConfigInitial());

  /// 🔄 Typically called inside your Splash Screen sequence
  Future<void> checkAppVersion() async {
    emit(AppConfigChecking());

    final result = await checkAppVersionUseCase.call(const NoParams());

    // 🎯 Guard clause to prevent emitting states if the widget is disposed
    if (isClosed) return;

    result.fold(
      (error) {
        // 🛡️ If the API fails (e.g., no internet), we let them into the app
        // to view cached data rather than showing an update screen forever.
        debugPrint(
          '⚠️ [Cubit] AppConfig API failed. Defaulting to UpToDate to let user in.',
        );
        emit(const AppConfigUpToDate(isSoftUpdateAvailable: false));
      },
      (updateStatus) {
        // 1. 🛑 CHECK MAINTENANCE FIRST
        if (updateStatus.isMaintenanceMode) {
          debugPrint('🚧 [Cubit] TRAPPING USER: System is under maintenance!');
          emit(
            AppConfigUnderMaintenance(
              estimatedCompletionTime: updateStatus.maintenanceEta,
              // 📞 Bind support channels so locked-out users can contact help
              supportPhone: updateStatus.supportPhone,
              supportWhatsapp: updateStatus.supportWhatsapp,
            ),
          );
          return; // Stop processing, user is locked out.
        }

        // 2. Check for HARD Force Update
        if (updateStatus.isForceUpdateRequired) {
          debugPrint('🛑 [Cubit] TRAPPING USER: Force Update is required!');
          emit(AppConfigUpdateRequired(storeUrl: updateStatus.storeUrl));
        }
        // 3. Otherwise, check for SOFT Optional Update
        else {
          debugPrint(
            '✅ [Cubit] Check complete. Soft Update Available: ${updateStatus.isSoftUpdateAvailable}',
          );
          emit(
            AppConfigUpToDate(
              isSoftUpdateAvailable: updateStatus.isSoftUpdateAvailable,
              storeUrl: updateStatus.storeUrl,
              // 📞 Bind support channels for normal in-app UI usage
              supportPhone: updateStatus.supportPhone,
              supportWhatsapp: updateStatus.supportWhatsapp,
            ),
          );
        }
      },
    );
  }
}
