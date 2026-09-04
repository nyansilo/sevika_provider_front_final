import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart';

// 🎯 Import the strictly typed model
import '../../features/call/data/models/incoming_call_payload_model.dart';

/// 🚨 CRITICAL BACKGROUND HANDLER
///
/// This must be a top-level function (outside of any class) so it can be
/// registered as a background entry point. When the app is swiped away
/// or totally killed by the OS, this function runs in a completely isolated
/// Dart memory space (Isolate) to wake the phone up.
@pragma('vm:entry-point')
Future<void> handleBackgroundCall(RemoteMessage message) async {
  // 1. Defensively parse the payload using our Model.
  // This guarantees we don't crash from missing keys when the OS wakes us up.
  final payload = IncomingCallPayloadModel.fromJson(message.data);

  // 2. Verify this is actually an incoming call trigger,
  // just in case Firebase sent a normal chat message notification here.
  if (payload.type == 'incomingCall') {
    // 3. Configure the Native Ringing Screen using strict types
    final CallKitParams callKitParams = CallKitParams(
      id: payload
          .channelName, // The unique MD5 Hash room used to tie the answer event to Agora
      nameCaller: payload
          .callerName, // What shows in massive text on the ringing screen
      appName: 'Sevika', // Your app name that appears in native call logs
      avatar: payload.avatarUrl,
      handle: 'Incoming ${payload.isVideo ? 'Video' : 'Audio'} Call',
      type: payload.isVideo ? 1 : 0, // 0 = Audio, 1 = Video
      duration:
          30000, // Rings for 30 seconds before timing out and becoming a "Missed Call"
      // 🔔 MISSED CALL CONFIGURATION
      missedCallNotification: const NotificationParams(
        showNotification:
            true, // Drops a native notification when the call times out
        isShowCallback:
            false, // Set false because we use custom Agora routing to call back
        subtitle: 'Missed call',
      ),

      // 🎯 THE PAYLOAD BRIDGE
      // We pass the validated JSON back into CallKit here.
      // When the user taps "Accept", CallKit will hand this EXACT extra map back
      // to our foreground Flutter code so we can boot up the Agora ActiveCallScreen!
      extra: payload.toJson(),

      // 🤖 ANDROID SPECIFIC UI
      android: const AndroidParams(
        isCustomNotification:
            true, // Forces Android to draw a full-screen ringing UI
        isShowLogo: false,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0955fa', // Brand color for the Android background
        actionColor: '#4CAF50',

        // 🎯 FIX APPLIED: These were moved here in the V2 package update!
        // Android needs these defined explicitly, whereas iOS ignores them
        // and uses the phone's native language for the buttons.
        textAccept: 'Accept',
        textDecline: 'Decline',
      ),

      // 🍎 IOS SPECIFIC UI (Native CallKit)
      ios: const IOSParams(
        iconName: 'AppIcon', // Must match the icon asset defined in XCode
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 1,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: true, // Allows the dialpad during a call
        supportsHolding: true,
        supportsGrouping: false,
        ringtonePath: 'system_ringtone_default',
      ),
    );

    // 4. Wake up the phone and display the native ringing UI!
    try {
      // This command bridges to Java/Kotlin/Swift and forces the OS to ring loudly.
      await FlutterCallkitIncoming.showCallkitIncoming(callKitParams);
    } catch (e) {
      debugPrint('Failed to trigger CallKit: $e');
    }
  }
}
