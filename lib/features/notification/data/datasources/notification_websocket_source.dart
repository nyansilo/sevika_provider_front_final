// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:dart_pusher_channels/dart_pusher_channels.dart';
// import '../../../../core/constants/api_endpoints.dart';
// import '../models/notification_item_model.dart';

// abstract class NotificationWebSocketSource {
//   Stream<NotificationItemModel> listenToLiveNotifications(
//     String userId,
//     String token,
//   );
//   void disconnect();
// }

// class NotificationWebSocketSourceImpl implements NotificationWebSocketSource {
//   PusherChannelsClient? _pusherClient;
//   StreamController<NotificationItemModel>? _controller;
//   StreamSubscription? _eventSubscription;
//   StreamSubscription? _connectionSubscription;

//   @override
//   Stream<NotificationItemModel> listenToLiveNotifications(
//     String userId,
//     String token,
//   ) {
//     // 🧹 1. COMPLETE CLEANUP: Destroy any pre-existing client to prevent memory leaks
//     _connectionSubscription?.cancel();
//     _eventSubscription?.cancel();
//     _pusherClient
//         ?.disconnect(); // 🎯 FIXED: Sever the old socket before creating a new one
//     _controller?.close();

//     _controller = StreamController<NotificationItemModel>.broadcast();

//     // 🎯 2. DIRECT INTEGRATION MAPPING
//     final hostOptions = PusherChannelsOptions.custom(
//       uriResolver: (metadata) {
//         return Uri(
//           scheme: ApiEndpoints.wsScheme,
//           host: ApiEndpoints.wsHost,
//           port: ApiEndpoints.wsPort,
//           path: '/app/${ApiEndpoints.reverbKey}',
//           queryParameters: {
//             'client': 'dart',
//             'version': '1.2.2',
//             'protocol': '7',
//           },
//         );
//       },
//     );

//     _pusherClient = PusherChannelsClient.websocket(
//       options: hostOptions,
//       activityDurationOverride: const Duration(seconds: 30),
//       connectionErrorHandler: (exception, trace, refresh) {
//         debugPrint(
//           '⚠️ WebSocket connection fault, attempting reconnect... $exception',
//         );
//         refresh();
//       },
//     );

//     // 3️⃣ NATIVE STREAM: Triggers perfectly the moment connection handshakes succeed
//     _connectionSubscription = _pusherClient!.onConnectionEstablished.listen((
//       _,
//     ) {
//       debugPrint(
//         '🚀 WebSocket Connection established! Securing private notification channel authorization...',
//       );

//       final String channelName = 'private-App.Models.User.$userId';
//       final privateChannel = _pusherClient!.privateChannel(
//         channelName,
//         authorizationDelegate:
//             EndpointAuthorizableChannelTokenAuthorizationDelegate.forPrivateChannel(
//               authorizationEndpoint: Uri.parse(
//                 '${ApiEndpoints.baseUrl}${ApiEndpoints.broadcastingAuth}',
//               ),
//               headers: {
//                 'Authorization': 'Bearer $token',
//                 'Accept': 'application/json',
//                 'Content-Type': 'application/json',
//               },
//             ),
//       );

//       // 4️⃣ Bind exactly to the root event class sent by Laravel Notifications system
//       _eventSubscription = privateChannel
//           .bind(
//             'Illuminate\\Notifications\\Events\\BroadcastNotificationCreated',
//           )
//           .listen(
//             (event) {
//               try {
//                 final dynamic dataPayload = event.data;
//                 Map<String, dynamic> jsonMap;

//                 if (dataPayload is String) {
//                   jsonMap = jsonDecode(dataPayload) as Map<String, dynamic>;
//                 } else {
//                   jsonMap = dataPayload as Map<String, dynamic>;
//                 }

//                 debugPrint('🔥 Live Notification Payload Arrived: $jsonMap');

//                 final model = NotificationItemModel.fromJson(jsonMap);
//                 _controller?.add(model);
//               } catch (e, stackTrace) {
//                 debugPrint(
//                   '⚠️ Structural event streaming parsing failure: $e\n$stackTrace',
//                 );
//               }
//             },
//             onError: (err) =>
//                 debugPrint('❌ Channel Event Subscription error: $err'),
//           );

//       // Execute the protocol channel subscription command sequence
//       privateChannel.subscribe();
//     });

//     // 5️⃣ Wrapped in a brief delay for clean cold boots
//     Future.delayed(const Duration(milliseconds: 500), () {
//       // 🎯 FIXED: Race Condition Guard. Make sure disconnect() wasn't called during this 500ms window!
//       if (_controller != null && !_controller!.isClosed) {
//         _pusherClient?.connect();
//       } else {
//         debugPrint(
//           '🛑 WebSocket connection aborted: Client was disconnected during boot delay.',
//         );
//       }
//     });

//     return _controller!.stream;
//   }

//   @override
//   void disconnect() {
//     _connectionSubscription?.cancel();
//     _eventSubscription?.cancel();
//     _pusherClient?.disconnect();
//     _pusherClient = null; // Clean up reference
//     _controller?.close();
//     _controller = null;
//   }
// }

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:dart_pusher_channels/dart_pusher_channels.dart';
// import '../../../../core/constants/api_endpoints.dart';
// import '../models/notification_item_model.dart';

// abstract class NotificationWebSocketSource {
//   Stream<NotificationItemModel> listenToLiveNotifications(
//     String userId,
//     String token,
//   );
//   void disconnect();
// }

// class NotificationWebSocketSourceImpl implements NotificationWebSocketSource {
//   PusherChannelsClient? _pusherClient;
//   StreamController<NotificationItemModel>? _controller;
//   StreamSubscription? _eventSubscription;
//   StreamSubscription? _connectionSubscription;

//   @override
//   Stream<NotificationItemModel> listenToLiveNotifications(
//     String userId,
//     String token,
//   ) {
//     // 🧹 1. COMPLETE CLEANUP: Destroy any pre-existing client to prevent memory leaks
//     _connectionSubscription?.cancel();
//     _eventSubscription?.cancel();
//     _pusherClient?.disconnect();
//     _controller?.close();

//     _controller = StreamController<NotificationItemModel>.broadcast();

//     // 🎯 2. DIRECT INTEGRATION MAPPING
//     final hostOptions = PusherChannelsOptions.custom(
//       uriResolver: (metadata) {
//         return Uri(
//           scheme: ApiEndpoints.wsScheme,
//           host: ApiEndpoints.wsHost,
//           port: ApiEndpoints.wsPort,
//           path: '/app/${ApiEndpoints.reverbKey}',
//           queryParameters: {
//             'client': 'dart',
//             'version': '1.2.2',
//             'protocol': '7',
//           },
//         );
//       },
//     );

//     _pusherClient = PusherChannelsClient.websocket(
//       options: hostOptions,
//       activityDurationOverride: const Duration(seconds: 30),
//       connectionErrorHandler: (exception, trace, refresh) {
//         debugPrint(
//           '⚠️ WebSocket connection fault, attempting reconnect... $exception',
//         );
//         refresh();
//       },
//     );

//     // // 3️⃣ NATIVE STREAM: Triggers perfectly the moment connection handshakes succeed
//     // _connectionSubscription = _pusherClient!.onConnectionEstablished.listen((
//     //   _,
//     // ) {
//     //   debugPrint(
//     //     '🚀 WebSocket Connection established! Securing private notification channel authorization...',
//     //   );

//     //   final String channelName = 'private-App.Models.User.$userId';
//     //   final privateChannel = _pusherClient!.privateChannel(
//     //     channelName,
//     //     authorizationDelegate:
//     //         EndpointAuthorizableChannelTokenAuthorizationDelegate.forPrivateChannel(
//     //           authorizationEndpoint: Uri.parse(
//     //             '${ApiEndpoints.baseUrl}${ApiEndpoints.broadcastingAuth}',
//     //           ),
//     //           headers: {
//     //             'Authorization': 'Bearer $token',
//     //             'Accept': 'application/json',
//     //             'Content-Type': 'application/json',
//     //           },
//     //         ),
//     //   );

//     //   // 4️⃣ Bind exactly to the root event class sent by Laravel Notifications system
//     //   _eventSubscription = privateChannel
//     //       .bind(
//     //         'Illuminate\\Notifications\\Events\\BroadcastNotificationCreated',
//     //       )
//     //       .listen(
//     //         (event) {
//     //           try {
//     //             final dynamic dataPayload = event.data;
//     //             Map<String, dynamic> jsonMap;

//     //             if (dataPayload is String) {
//     //               jsonMap = jsonDecode(dataPayload) as Map<String, dynamic>;
//     //             } else {
//     //               jsonMap = dataPayload as Map<String, dynamic>;
//     //             }

//     //             debugPrint('🔥 Live Notification Payload Arrived: $jsonMap');

//     //             final model = NotificationItemModel.fromJson(jsonMap);
//     //             _controller?.add(model);
//     //           } catch (e, stackTrace) {
//     //             debugPrint(
//     //               '⚠️ Structural event streaming parsing failure: $e\n$stackTrace',
//     //             );
//     //           }
//     //         },
//     //         onError: (err) =>
//     //             debugPrint('❌ Channel Event Subscription error: $err'),
//     //       );

//     //   // Execute the protocol channel subscription command sequence
//     //   privateChannel.subscribe();
//     // });

//     // // 5️⃣ 🎯 FIX: Remove the Future.delayed block and just connect immediately.
//     // _pusherClient?.connect();

//     // return _controller!.stream;
//     //}

//     // 3️⃣ NATIVE STREAM: Triggers perfectly the moment connection handshakes succeed
//     _connectionSubscription = _pusherClient!.onConnectionEstablished.listen((
//       _,
//     ) {
//       debugPrint(
//         '🚀 WebSocket Connection established! Securing private notification channel...',
//       );

//       final String channelName = 'private-App.Models.User.$userId';
//       final privateChannel = _pusherClient!.privateChannel(
//         channelName,
//         authorizationDelegate:
//             EndpointAuthorizableChannelTokenAuthorizationDelegate.forPrivateChannel(
//               authorizationEndpoint: Uri.parse(
//                 '${ApiEndpoints.baseUrl}${ApiEndpoints.broadcastingAuth}',
//               ),
//               headers: {
//                 'Authorization': 'Bearer $token',
//                 'Accept': 'application/json',
//                 'Content-Type': 'application/json',
//               },
//             ),
//       );

//       // 🎯 FIX: You MUST call subscribe() first before binding to events in Pusher!
//       privateChannel.subscribe();

//       // 4️⃣ Bind exactly to the root event class sent by Laravel Notifications system
//       _eventSubscription = privateChannel
//           .bind(
//             'Illuminate\\Notifications\\Events\\BroadcastNotificationCreated',
//           )
//           .listen(
//             (event) {
//               try {
//                 final dynamic dataPayload = event.data;
//                 Map<String, dynamic> jsonMap;

//                 if (dataPayload is String) {
//                   jsonMap = jsonDecode(dataPayload) as Map<String, dynamic>;
//                 } else {
//                   jsonMap = dataPayload as Map<String, dynamic>;
//                 }

//                 debugPrint('🔥 Live Notification Payload Arrived: $jsonMap');

//                 final model = NotificationItemModel.fromJson(jsonMap);
//                 _controller?.add(model);
//               } catch (e, stackTrace) {
//                 debugPrint(
//                   '⚠️ Structural event streaming parsing failure: $e\n$stackTrace',
//                 );
//               }
//             },
//             onError: (err) =>
//                 debugPrint('❌ Channel Event Subscription error: $err'),
//           );
//     });

//     _pusherClient?.connect();

//     return _controller!.stream;
//   }

//   @override
//   void disconnect() {
//     _connectionSubscription?.cancel();
//     _eventSubscription?.cancel();
//     _pusherClient?.disconnect();
//     _pusherClient = null; // Clean up reference
//     _controller?.close();
//     _controller = null;
//   }
// }

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';

import '../../../../core/config/app_secrets.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../models/notification_item_model.dart';

abstract class NotificationWebSocketSource {
  Stream<NotificationItemModel> listenToLiveNotifications(
    String userId,
    String token,
  );
  void disconnect();
}

class NotificationWebSocketSourceImpl implements NotificationWebSocketSource {
  PusherChannelsClient? _pusherClient;
  StreamController<NotificationItemModel>? _controller;

  StreamSubscription? _connectionSubscription;
  StreamSubscription? _eventSubscription;

  @override
  Stream<NotificationItemModel> listenToLiveNotifications(
    String userId,
    String token,
  ) {
    debugPrint('🔌 [NOTIFICATIONS WS] listenToLiveNotifications called.');

    // Clean up any existing instances safely
    disconnect();

    _controller = StreamController<NotificationItemModel>.broadcast();

    final hostOptions = PusherChannelsOptions.custom(
      uriResolver: (metadata) {
        return Uri(
          scheme: ApiEndpoints.wsScheme,
          host: ApiEndpoints.wsHost,
          port: ApiEndpoints.wsPort,
          path: '/app/${AppSecrets.reverbKey}',
          queryParameters: {
            'client': 'dart',
            'version': '1.2.2',
            'protocol': '7',
          },
        );
      },
    );

    _pusherClient = PusherChannelsClient.websocket(
      options: hostOptions,
      activityDurationOverride: const Duration(seconds: 30),
      connectionErrorHandler: (exception, trace, refresh) {
        debugPrint(
          '⚠️ [NOTIFICATIONS WS] connection fault: $exception. Reconnecting...',
        );
        // 🎯 FIX: Add a small delay so it doesn't spam Reverb if the internet drops
        Future.delayed(const Duration(seconds: 2), () {
          refresh();
        });
      },
    );

    _connectionSubscription = _pusherClient!.onConnectionEstablished.listen((
      _,
    ) {
      debugPrint(
        '🚀 [NOTIFICATIONS WS] Connection established! Securing channel...',
      );

      final String channelName = 'private-App.Models.User.$userId';
      final privateChannel = _pusherClient!.privateChannel(
        channelName,
        authorizationDelegate:
            EndpointAuthorizableChannelTokenAuthorizationDelegate.forPrivateChannel(
              authorizationEndpoint: Uri.parse(
                '${ApiEndpoints.baseUrl}${ApiEndpoints.broadcastingAuth}',
              ),
              headers: {
                'Authorization': 'Bearer $token',
                'Accept': 'application/json',
                'Content-Type': 'application/json',
              },
            ),
      );

      // 🎯 FIX: You MUST call subscribe() first before binding to events in Pusher!
      privateChannel.subscribe();

      // 4️⃣ Bind exactly to the root event class sent by Laravel Notifications system
      _eventSubscription = privateChannel
          .bind(
            'Illuminate\\Notifications\\Events\\BroadcastNotificationCreated',
          )
          .listen((event) {
            try {
              debugPrint(
                '🔥 [NOTIFICATIONS WS] Match! Payload Arrived: ${event.data}',
              );
              final dynamic dataPayload = event.data;
              Map<String, dynamic> jsonMap = (dataPayload is String)
                  ? jsonDecode(dataPayload) as Map<String, dynamic>
                  : dataPayload as Map<String, dynamic>;

              final model = NotificationItemModel.fromJson(jsonMap);
              _controller?.add(model);
            } catch (e, stackTrace) {
              debugPrint(
                '⚠️ [NOTIFICATIONS WS] Parsing failure: $e\n$stackTrace',
              );
            }
          });
    });

    _pusherClient?.connect();
    return _controller!.stream;
  }

  @override
  void disconnect() {
    debugPrint('🛑 [NOTIFICATIONS WS] Disconnect called. Cleaning up...');

    _connectionSubscription?.cancel();
    _eventSubscription?.cancel();

    _pusherClient?.disconnect();
    _pusherClient = null;

    _controller?.close();
    _controller = null;
  }
}
