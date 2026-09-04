import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import '../models/notification_item_model.dart';

abstract class NotificationWebSocketSourceOld {
  Stream<NotificationItemModel> listenToLiveNotifications(
    String userId,
    String token,
  );
  void disconnect();
}

class NotificationWebSocketSourceImpl
    implements NotificationWebSocketSourceOld {
  PusherChannelsClient? _pusherClient;
  StreamController<NotificationItemModel>? _controller;
  StreamSubscription? _eventSubscription;
  StreamSubscription? _connectionSubscription;

  @override
  Stream<NotificationItemModel> listenToLiveNotifications(
    String userId,
    String token,
  ) {
    // 🧹 Clean up any pre-existing subscription listeners safely
    _connectionSubscription?.cancel();
    _eventSubscription?.cancel();
    _controller?.close();

    _controller = StreamController<NotificationItemModel>.broadcast();

    // 🎯 Local Environment Network Architecture Configuration
    const String host =
        '127.0.0.1'; // Shared proxy loopback address for iOS Simulator
    const int reverbPort = 8080; // Laravel Reverb WebSockets Port
    const int apiPort = 8000; // Laravel HTTP Server Port
    const String key = 'i6az9ouywfabe6drpgoq';

    // 1️⃣ Configure core Reverb host connection options
    final hostOptions = PusherChannelsOptions.fromHost(
      scheme: 'ws',
      host: host,
      port: reverbPort,
      key: key,
      shouldSupplyMetadataQueries: true,
      metadata: const PusherChannelsOptionsMetadata.byDefault(),
    );

    _pusherClient = PusherChannelsClient.websocket(
      options: hostOptions,
      activityDurationOverride: const Duration(seconds: 30),
      connectionErrorHandler: (exception, trace, refresh) {
        debugPrint(
          '⚠️ WebSocket connection fault, attempting reconnect... $exception',
        );
        refresh();
      },
    );

    // 2️⃣ NATIVE STREAM: Triggers perfectly the moment connection handshakes succeed
    _connectionSubscription = _pusherClient!.onConnectionEstablished.listen((
      _,
    ) {
      debugPrint(
        '🚀 WebSocket Connection established! Securing private notification channel authorization...',
      );

      final String channelName = 'private-App.Models.User.$userId';
      final privateChannel = _pusherClient!.privateChannel(
        channelName,
        authorizationDelegate:
            EndpointAuthorizableChannelTokenAuthorizationDelegate.forPrivateChannel(
              authorizationEndpoint: Uri.parse(
                'http://$host:$apiPort/api/v1/broadcasting/auth',
                //'${ApiEndpoints.baseUrl}${ApiEndpoints.broadcastingAuth}',
              ),
              headers: {
                'Authorization': 'Bearer $token',
                'Accept': 'application/json',
                'Content-Type': 'application/json',
              },
            ),
      );

      // 3️⃣ 💡 FIXED: Bind exactly to the root event class sent by Laravel Notifications system!
      _eventSubscription = privateChannel
          .bind(
            'Illuminate\\Notifications\\Events\\BroadcastNotificationCreated',
          )
          .listen(
            (event) {
              try {
                final dynamic dataPayload = event.data;
                Map<String, dynamic> jsonMap;

                if (dataPayload is String) {
                  jsonMap = jsonDecode(dataPayload) as Map<String, dynamic>;
                } else {
                  jsonMap = dataPayload as Map<String, dynamic>;
                }

                debugPrint('🔥 Live Notification Payload Arrived: $jsonMap');

                // Push parsed type-safe model up into the application presentation layer
                final model = NotificationItemModel.fromJson(jsonMap);
                _controller?.add(model);
              } catch (e, stackTrace) {
                debugPrint(
                  '⚠️ Structural event streaming parsing failure: $e\n$stackTrace',
                );
              }
            },
            onError: (err) =>
                debugPrint('❌ Channel Event Subscription error: $err'),
          );

      // 4️⃣ Execute the protocol channel subscription command sequence
      privateChannel.subscribe();
    });

    // 💡 FIXED COLD START: Wrap the connect request in a brief microtask delay.
    // This stops the asynchronous handshake from firing before the root app context
    // finishes binding components into memory on dead boots.
    Future.delayed(const Duration(milliseconds: 500), () {
      _pusherClient?.connect();
    });

    return _controller!.stream;
  }

  @override
  void disconnect() {
    _connectionSubscription?.cancel();
    _eventSubscription?.cancel();
    _pusherClient?.disconnect();
    _controller?.close();
    _controller = null;
  }
}
