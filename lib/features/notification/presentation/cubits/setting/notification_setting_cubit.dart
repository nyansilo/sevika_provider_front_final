// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';

// import '../../../../../core/storage/local_storage_service.dart';
// import '../../../domain/usecases/params/toggle_notification_params.dart';
// import '../../../domain/usecases/toggle_notification_preference_use_case.dart';
// import 'notification_settings_state.dart'; // 🎯 IMPORT NEW STATE

// class NotificationSettingsCubit extends Cubit<NotificationSettingsState> {
//   final LocalStorageService localStorage;
//   final ToggleNotificationPreferenceUseCase toggleUseCase;

//   static const String _prefKey = 'notifications_enabled_cache';

//   NotificationSettingsCubit({
//     required this.localStorage,
//     required this.toggleUseCase,
//   }) : super(const NotificationSettingsState(isEnabled: true)) {
//     _loadInitialState();
//   }

//   void _loadInitialState() {
//     // 1. ⚡ LOAD FROM CACHE: Instant UI rendering on app start
//     final isEnabled = localStorage.getBool(_prefKey) ?? true;
//     emit(state.copyWith(isEnabled: isEnabled, clearMessages: true));
//   }

//   Future<void> toggleNotifications(bool enable) async {
//     // 1. ⚡ OPTIMISTIC UI UPDATE: Instantly flip the switch on the UI so it feels lightning fast!
//     emit(state.copyWith(isEnabled: enable, clearMessages: true));
//     await localStorage.setBool(_prefKey, enable);

//     // 2. 📱 HARDWARE & FIREBASE SYNC
//     try {
//       if (enable) {
//         // Request OS permissions and awaken Firebase
//         await FirebaseMessaging.instance.requestPermission();
//       } else {
//         // Physically delete the token from the device hardware
//         await FirebaseMessaging.instance.deleteToken();
//       }
//     } catch (e) {
//       debugPrint('Firebase Token Hardware Sync Error: $e');
//     }

//     // 3. ☁️ BACKEND SYNC (LARAVEL API)
//     final params = ToggleNotificationParams(isEnabled: enable);
//     final result = await toggleUseCase.call(params);

//     result.fold(
//       (error) {
//         // ❌ ROLLBACK: API failed! Revert the toggle back to its original state and show error.
//         final rollbackState = !enable;
//         localStorage.setBool(_prefKey, rollbackState);
//         emit(
//           state.copyWith(
//             isEnabled: rollbackState,
//             errorMessage: error.message ?? 'Failed to update preferences.',
//             clearMessages: false,
//           ),
//         );
//       },
//       (successData) {
//         // ✅ SUCCESS: Keep the toggle where it is and extract the API's success message!
//         // Assuming your backend returns a message in the success payload.
//         emit(
//           state.copyWith(
//             isEnabled: enable,
//             successMessage: 'Notification preferences updated successfully.',
//             clearMessages: false,
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/storage/local_storage_service.dart';
import '../../../../../core/services/push_notification_service.dart'; // 🎯 IMPORT THE SERVICE
import '../../../domain/usecases/params/toggle_notification_params.dart';
import '../../../domain/usecases/toggle_notification_preference_use_case.dart';
import 'notification_settings_state.dart'; // 🎯 IMPORT NEW STATE

class NotificationSettingsCubit extends Cubit<NotificationSettingsState> {
  final LocalStorageService localStorage;
  final ToggleNotificationPreferenceUseCase toggleUseCase;
  final PushNotificationService pushNotificationService; // 🎯 INJECTED SERVICE

  static const String _prefKey = 'notifications_enabled_cache';

  NotificationSettingsCubit({
    required this.localStorage,
    required this.toggleUseCase,
    required this.pushNotificationService, // 🎯 REQUIRE IT HERE
  }) : super(const NotificationSettingsState(isEnabled: true)) {
    _loadInitialState();
  }

  void _loadInitialState() {
    // 1. ⚡ LOAD FROM CACHE: Instant UI rendering on app start
    final isEnabled = localStorage.getBool(_prefKey) ?? true;
    emit(state.copyWith(isEnabled: isEnabled, clearMessages: true));
  }

  Future<void> toggleNotifications(bool enable) async {
    // 1. ⚡ OPTIMISTIC UI UPDATE: Instantly flip the switch on the UI so it feels lightning fast!
    emit(state.copyWith(isEnabled: enable, clearMessages: true));
    await localStorage.setBool(_prefKey, enable);

    // 2. 📱 HARDWARE & FIREBASE SYNC (Delegated to Service)
    if (enable) {
      // 🚀 Re-run initialization! This safely requests OS permission, grabs the
      // new token, and automatically sends it to Laravel via the UpdateFcmTokenUseCase!
      await pushNotificationService.initialize();
    } else {
      // 🚀 Delegate token deletion to the service
      await pushNotificationService.deleteToken();
    }

    // 3. ☁️ BACKEND SYNC (LARAVEL API - To update user table preference)
    final params = ToggleNotificationParams(isEnabled: enable);
    final result = await toggleUseCase.call(params);

    result.fold(
      (error) {
        // ❌ ROLLBACK: API failed! Revert the toggle back to its original state and show error.
        final rollbackState = !enable;
        localStorage.setBool(_prefKey, rollbackState);
        emit(
          state.copyWith(
            isEnabled: rollbackState,
            errorMessage: error.message ?? 'Failed to update preferences.',
            clearMessages: false,
          ),
        );
      },
      (successData) {
        // ✅ SUCCESS: Keep the toggle where it is and extract the API's success message!
        emit(
          state.copyWith(
            isEnabled: enable,
            successMessage: 'Notification preferences updated successfully.',
            clearMessages: false,
          ),
        );
      },
    );
  }
}
