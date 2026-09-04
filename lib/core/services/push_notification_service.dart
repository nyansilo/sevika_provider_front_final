import 'dart:convert';
import 'dart:io' show Platform;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../navigation/app_keys.dart';
import '../routes/route_list.dart';
import '../di/service_locator.dart';

import '../../features/notification/domain/usecases/update_fcm_token_use_case.dart';
import '../../features/notification/domain/usecases/params/update_fcm_token_params.dart';
import '../../features/emergency/presentation/cubits/accept_emergency_cubit.dart';
import '../../features/emergency/presentation/widgets/incoming_emergency_alert.dart';

class PushNotificationService {
  final UpdateFcmTokenUseCase updateFcmTokenUseCase;

  PushNotificationService({required this.updateFcmTokenUseCase});

  Future<void> initialize() async {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final String currentDeviceType = Platform.isIOS ? 'ios' : 'android';

      try {
        String? token = await messaging.getToken();
        if (token != null) {
          await updateFcmTokenUseCase.call(
            UpdateFcmTokenParams(token: token, deviceType: currentDeviceType),
          );
        }
      } catch (e) {
        debugPrint('⚠️ [FCM] Skipped token sync: APNs blocked.');
      }

      try {
        messaging.onTokenRefresh.listen((newToken) {
          updateFcmTokenUseCase.call(
            UpdateFcmTokenParams(
              token: newToken,
              deviceType: currentDeviceType,
            ),
          );
        });
      } catch (e) {}

      // 🚨 FOREGROUND INTERCEPTOR
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _handleForegroundMessage(message);
      });

      FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundTapRouting);

      FirebaseMessaging.instance.getInitialMessage().then((
        RemoteMessage? message,
      ) {
        if (message != null) {
          Future.delayed(const Duration(milliseconds: 500), () {
            _handleBackgroundTapRouting(message);
          });
        }
      });
    }
  }

  Future<void> deleteToken() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
    } catch (e) {}
  }

  void _handleForegroundMessage(RemoteMessage message) {
    final data = message.data;
    final context = AppKeys.navigatorKey.currentContext;

    if (context == null) return;

    // 🚨 EMERGENCY SOS: Show Global Dialog
    if (data['type'] == 'EmergencyBroadcastNotification' ||
        data['type'] == 'emergency_broadcast') {
      try {
        final Map<String, dynamic> metadata = jsonDecode(
          data['metadata'] ?? '{}',
        );
        final dispatchId = metadata['dispatchId'] ?? metadata['dispatch_id'];
        final addressText = metadata['addressText'] ?? metadata['address_text'];

        if (dispatchId != null) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => BlocProvider<AcceptEmergencyCubit>(
              create: (_) => sl<AcceptEmergencyCubit>(),
              child: IncomingEmergencyAlert(
                dispatchId: dispatchId.toString(),
                category: message.notification?.title ?? 'Emergency Request',
                addressText:
                    addressText?.toString() ?? 'Location provided via GPS',
              ),
            ),
          );
        }
      } catch (e) {
        debugPrint('⚠️ [FCM] Failed to parse SOS payload: $e');
      }
    }
  }

  void _handleBackgroundTapRouting(RemoteMessage message) {
    final navigator = AppKeys.navigatorKey.currentState;
    if (navigator == null) return;

    final data = message.data;
    final String type = data['type']?.toString().toLowerCase() ?? '';

    if (type.contains('booking') || type.contains('order')) {
      navigator.pushNamed(RouteList.bookingDashboardPage, arguments: 0);
    } else if (type.contains('wallet') || type.contains('payment')) {
      navigator.pushNamed(RouteList.walletDashboardPage);
    } else if (type.contains('job') || type.contains('bid')) {
      navigator.pushNamed(RouteList.exploreMarketplacePage);
    } else {
      navigator.pushNamed(RouteList.notificationPage);
    }
  }
}
