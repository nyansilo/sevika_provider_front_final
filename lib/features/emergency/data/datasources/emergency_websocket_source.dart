import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/config/app_secrets.dart';
import '../../domain/usecases/params/live_emergency_params.dart';
import '../models/emergency_claim_model.dart';

abstract class EmergencyWebSocketSource {
  Stream<EmergencyClaimModel> listenToEmergencyDispatch(
    LiveEmergencyParams params,
  );
  void disconnect();
}

class EmergencyWebSocketSourceImpl implements EmergencyWebSocketSource {
  PusherChannelsClient? _pusherClient;
  StreamController<EmergencyClaimModel>? _controller;
  StreamSubscription? _connectionSubscription;
  StreamSubscription? _eventSubscription;

  @override
  Stream<EmergencyClaimModel> listenToEmergencyDispatch(
    LiveEmergencyParams params,
  ) {
    debugPrint(
      '🔌 [EMERGENCY WS] Connecting to dispatch: ${params.dispatchId}',
    );
    disconnect();

    _controller = StreamController<EmergencyClaimModel>.broadcast();

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
        debugPrint('⚠️ [EMERGENCY WS] connection fault: $exception.');
        Future.delayed(const Duration(seconds: 2), refresh);
      },
    );

    _connectionSubscription = _pusherClient!.onConnectionEstablished.listen((
      _,
    ) {
      debugPrint('🚀 [EMERGENCY WS] Connected. Securing private channel...');

      final String channelName =
          'private-emergency.dispatch.${params.dispatchId}';
      final privateChannel = _pusherClient!.privateChannel(
        channelName,
        authorizationDelegate:
            EndpointAuthorizableChannelTokenAuthorizationDelegate.forPrivateChannel(
              authorizationEndpoint: Uri.parse(
                '${ApiEndpoints.baseUrl}${ApiEndpoints.broadcastingAuth}',
              ),
              headers: {
                'Authorization': 'Bearer ${params.token}',
                'Accept': 'application/json',
              },
            ),
      );

      privateChannel.subscribe();

      // 🎯 Listen for Laravel's EmergencyClaimedByOther Event
      _eventSubscription = privateChannel.bind('emergency.claimed').listen((
        event,
      ) {
        try {
          final dynamic dataPayload = event.data;
          final Map<String, dynamic> jsonMap = (dataPayload is String)
              ? jsonDecode(dataPayload) as Map<String, dynamic>
              : dataPayload as Map<String, dynamic>;

          _controller?.add(EmergencyClaimModel.fromJson(jsonMap));
        } catch (e, stackTrace) {
          debugPrint('⚠️ [EMERGENCY WS] Parse fail: $e\n$stackTrace');
        }
      });
    });

    _pusherClient?.connect();
    return _controller!.stream;
  }

  @override
  void disconnect() {
    debugPrint('🛑 [EMERGENCY WS] Disconnecting...');
    _connectionSubscription?.cancel();
    _eventSubscription?.cancel();
    _pusherClient?.disconnect();
    _pusherClient = null;
    _controller?.close();
    _controller = null;
  }
}
