// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:dart_pusher_channels/dart_pusher_channels.dart';

// import '../../../../core/constants/api_endpoints.dart';
// import '../models/chat_message_model.dart';
// import '../../domain/entities/chat_message_type.dart';

// abstract class ChatWebSocketDataSource {
//   Stream<ChatMessageModel> listenToLiveMessages(
//     String userId,
//     String roomId,
//     String token,
//   );
//   void disconnect();
// }

// class ChatWebSocketDataSourceImpl implements ChatWebSocketDataSource {
//   PusherChannelsClient? _pusherClient;
//   StreamController<ChatMessageModel>? _controller;
//   StreamSubscription? _eventSubscription;
//   StreamSubscription? _connectionSubscription;

//   @override
//   Stream<ChatMessageModel> listenToLiveMessages(
//     String userId,
//     String roomId,
//     String token,
//   ) {
//     disconnect();
//     _controller = StreamController<ChatMessageModel>.broadcast();

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
//       connectionErrorHandler: (exception, trace, refresh) => refresh(),
//     );

//     _connectionSubscription = _pusherClient!.onConnectionEstablished.listen((
//       _,
//     ) {
//       // 1️⃣ Listen to the EXACT channel defined in your routes/channels.php
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

//       // 2️⃣ Bind to Laravel's default Notification Broadcast Event
//       final String eventName =
//           'Illuminate\\Notifications\\Events\\BroadcastNotificationCreated';

//       _eventSubscription = privateChannel.bind(eventName).listen((event) {
//         try {
//           final dynamic dataPayload = event.data;
//           final Map<String, dynamic> jsonMap = dataPayload is String
//               ? jsonDecode(dataPayload) as Map<String, dynamic>
//               : dataPayload as Map<String, dynamic>;

//           // 3️⃣ FILTER: Ensure it's a Chat Notification AND belongs to this specific Room
//           final String notificationType = jsonMap['type']?.toString() ?? '';
//           if (!notificationType.contains('ChatMessageNotification')) return;

//           final Map<String, dynamic> metadata =
//               jsonMap['metadata'] as Map<String, dynamic>? ?? {};
//           final String incomingRoomId = metadata['roomId']?.toString() ?? '';

//           if (incomingRoomId != roomId) {
//             return; // Ignore messages for other rooms
//           }

//           debugPrint('🔥 Live Chat Payload Validated for Room $roomId');

//           // 4️⃣ MAP IT: Construct the ChatMessageModel using the metadata we updated in Laravel
//           final model = ChatMessageModel(
//             messageId: metadata['messageId']?.toString() ?? '',
//             roomId: incomingRoomId,
//             isMe:
//                 false, // Incoming socket events are always from the other person
//             senderId: metadata['senderId']?.toString() ?? '',
//             type: ChatMessageType.fromString(
//               metadata['type']?.toString() ?? 'text',
//             ),
//             body:
//                 metadata['body']?.toString() ??
//                 jsonMap['message']?.toString() ??
//                 '',
//             metadata: metadata, // Pass the whole block as generic metadata
//             sentAt:
//                 metadata['sentAt']?.toString() ??
//                 DateTime.now().toIso8601String(),
//           );

//           _controller?.add(model);
//         } catch (e) {
//           debugPrint('⚠️ Chat WebSocket Parsing Error: $e');
//         }
//       });

//       privateChannel.subscribe();
//     });

//     // 🎯 FIX: Remove the Future.delayed and connect immediately!
//     _pusherClient?.connect();

//     return _controller!.stream;
//   }

//   @override
//   void disconnect() {
//     _connectionSubscription?.cancel();
//     _eventSubscription?.cancel();
//     _pusherClient?.disconnect();
//     _pusherClient = null;
//     _controller?.close();
//     _controller = null;
//   }
// }

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';

import '../../../../core/config/app_secrets.dart' show AppSecrets;
import '../../../../core/constants/api_endpoints.dart';
import '../models/chat_message_model.dart';
import '../../domain/entities/chat_message_type.dart';

abstract class ChatWebSocketDataSource {
  Stream<ChatMessageModel> listenToLiveMessages(
    String userId,
    String roomId,
    String token,
  );
  void disconnect();
}

class ChatWebSocketDataSourceImpl implements ChatWebSocketDataSource {
  PusherChannelsClient? _pusherClient;
  StreamController<ChatMessageModel>? _controller;
  StreamSubscription? _eventSubscription;
  StreamSubscription? _connectionSubscription;

  @override
  Stream<ChatMessageModel> listenToLiveMessages(
    String userId,
    String roomId,
    String token,
  ) {
    debugPrint(
      '🔌 4. DATA SOURCE HIT! Building Pusher client for Room $roomId...',
    );

    disconnect();
    _controller = StreamController<ChatMessageModel>.broadcast();

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
        // 🎯 FIX: No more silent failures! We will see exactly why it drops.
        debugPrint('⚠️ ❌ CHAT WS ERROR: $exception');
        refresh();
      },
    );

    _connectionSubscription = _pusherClient!.onConnectionEstablished.listen((
      _,
    ) {
      debugPrint(
        '🚀 5. CHAT WEBSOCKET CONNECTED! Securing private channel for User $userId...',
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

      final String eventName =
          'Illuminate\\Notifications\\Events\\BroadcastNotificationCreated';

      _eventSubscription = privateChannel.bind(eventName).listen((event) {
        debugPrint(
          '🔥 6. RAW EVENT RECEIVED ON CHAT WS: ${event.data}',
        ); // 🎯 Catch EVERYTHING

        try {
          final dynamic dataPayload = event.data;
          final Map<String, dynamic> jsonMap = dataPayload is String
              ? jsonDecode(dataPayload) as Map<String, dynamic>
              : dataPayload as Map<String, dynamic>;

          final String notificationType = jsonMap['type']?.toString() ?? '';
          if (!notificationType.contains('ChatMessageNotification')) {
            debugPrint(
              '⚠️ 7. Ignored: Not a ChatMessageNotification (Type: $notificationType)',
            );
            return;
          }

          final Map<String, dynamic> metadata =
              jsonMap['metadata'] as Map<String, dynamic>? ?? {};
          final String incomingRoomId = metadata['roomId']?.toString() ?? '';

          if (incomingRoomId != roomId) {
            debugPrint(
              '⚠️ 7. Ignored: Message belongs to a different room ($incomingRoomId)',
            );
            return;
          }

          debugPrint('✅ 8. PAYLOAD VALIDATED! Sending to UI...');

          final model = ChatMessageModel(
            messageId: metadata['messageId']?.toString() ?? '',
            roomId: incomingRoomId,
            isMe: false,
            senderId: metadata['senderId']?.toString() ?? '',
            type: ChatMessageType.fromString(
              metadata['type']?.toString() ?? 'text',
            ),
            body:
                metadata['body']?.toString() ??
                jsonMap['message']?.toString() ??
                '',
            metadata: metadata,
            sentAt:
                metadata['sentAt']?.toString() ??
                DateTime.now().toIso8601String(),
          );

          _controller?.add(model);
        } catch (e) {
          debugPrint('⚠️ ❌ Chat WebSocket Parsing Error: $e');
        }
      });

      privateChannel.subscribe();
    });

    _pusherClient?.connect();
    return _controller!.stream;
  }

  @override
  void disconnect() {
    _connectionSubscription?.cancel();
    _eventSubscription?.cancel();
    _pusherClient?.disconnect();
    _pusherClient = null;
    _controller?.close();
    _controller = null;
  }
}
