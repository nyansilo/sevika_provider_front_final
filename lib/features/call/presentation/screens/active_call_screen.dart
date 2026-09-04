// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';

// // 🎯 Import your design system, entities, and enums
// import '../../../../core/constants/app_dimensions.dart';
// import '../../../../core/extensions/build_context_extensions.dart';
// import '../../../../core/presentation/widgets/app_circle_avatar.dart';
// import '../../domain/entities/call_entity.dart';
// import '../../domain/enums/call_type.dart';

// /// 📱 Active Call Screen (Merged UI & Engine)
// ///
// /// Dynamically configures itself for Audio or Video calls based on [CallType].
// /// Uses Agora's UserAccount API to support String UUIDs from the Laravel backend,
// /// while wrapping everything in your beautiful custom design system.
// class ActiveCallScreen extends StatefulWidget {
//   final CallEntity callData;

//   const ActiveCallScreen({super.key, required this.callData});

//   @override
//   State<ActiveCallScreen> createState() => _ActiveCallScreenState();
// }

// class _ActiveCallScreenState extends State<ActiveCallScreen> {
//   // ⚙️ Engine State
//   late RtcEngine _engine;
//   bool _isJoined = false;
//   bool _isMuted = false;
//   bool _isSpeakerOn = false;

//   // 👥 Remote Users tracking (Using Laravel String UUIDs)
//   final Set<String> _remoteUsers = {};

//   // ⏱️ UI Call State
//   bool _isCallAnswered = false;
//   int _callDurationSeconds = 0;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     _initInternetCall();
//   }

//   /// Initializes hardware permissions, UI defaults, and authenticates with Agora.
//   Future<void> _initInternetCall() async {
//     // 1. 🛡️ Request permissions based on the CallType Enum
//     if (widget.callData.callType == CallType.video) {
//       await [Permission.microphone, Permission.camera].request();
//       _isSpeakerOn = true; // Video calls usually default to speaker
//     } else {
//       await [Permission.microphone].request();
//       _isSpeakerOn = false; // Audio calls default to earpiece
//     }

//     // 2. ⚙️ Initialize the Agora Engine
//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(
//       RtcEngineContext(
//         appId: widget.callData.appId,
//         channelProfile: ChannelProfileType.channelProfileCommunication,
//       ),
//     );

//     // 3. 🎥 Hardware Routing (Audio vs Video)
//     if (widget.callData.callType == CallType.video) {
//       await _engine.enableVideo();
//       await _engine.startPreview(); // Shows local camera feed immediately
//     } else {
//       await _engine.enableAudio();
//       await _engine.disableVideo(); // Explicitly turn off camera hardware
//     }

//     // Apply the initial speaker state to the hardware
//     await _engine.setEnableSpeakerphone(_isSpeakerOn);

//     // 4. 📡 Register Event Handlers
//     _engine.registerEventHandler(
//       RtcEngineEventHandler(
//         // Triggered when WE successfully join the channel
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           if (mounted) {
//             setState(() => _isJoined = true);
//           }
//         },

//         // 🎯 IMPORTANT: Triggered when the REMOTE user joins.
//         // We use onUserInfoUpdated because we map Laravel String UUIDs to Agora UserAccounts.
//         onUserInfoUpdated: (int internalUid, UserInfo info) {
//           if (mounted) {
//             setState(() {
//               if (info.userAccount != null) {
//                 _remoteUsers.add(info.userAccount!);

//                 // ⏱️ Start the timer only when the other person actually connects!
//                 if (!_isCallAnswered) {
//                   _isCallAnswered = true;
//                   _startTimer();
//                 }
//               }
//             });
//           }
//         },

//         // Triggered when the remote user hangs up or drops
//         onUserOffline:
//             (
//               RtcConnection connection,
//               int remoteUid,
//               UserOfflineReasonType reason,
//             ) {
//               _endCall();
//             },
//       ),
//     );

//     // 5. 🚀 Join Channel using String User Account (UUID)
//     await _engine.joinChannelWithUserAccount(
//       token: widget.callData.token,
//       channelId: widget.callData.channelName,
//       userAccount: widget.callData.uid, // 🎯 The String UUID from Laravel
//       options: ChannelMediaOptions(
//         clientRoleType: ClientRoleType.clientRoleBroadcaster,
//         publishCameraTrack: widget.callData.callType == CallType.video,
//         publishMicrophoneTrack: true,
//       ),
//     );
//   }

//   /// Starts the call duration timer.
//   void _startTimer() {
//     _timer?.cancel(); // Failsafe to prevent double timers
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (mounted) {
//         setState(() {
//           _callDurationSeconds++;
//         });
//       }
//     });
//   }

//   /// Formats the raw seconds into a clean MM:SS string.
//   String _formatDuration(int seconds) {
//     final int minutes = seconds ~/ 60;
//     final int remainingSeconds = seconds % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
//   }

//   /// Toggles the local microphone feed to the internet
//   void _toggleMute() {
//     setState(() => _isMuted = !_isMuted);
//     _engine.muteLocalAudioStream(_isMuted);
//   }

//   /// Switches audio output between Earpiece and Loud Speaker
//   void _toggleSpeaker() {
//     setState(() => _isSpeakerOn = !_isSpeakerOn);
//     _engine.setEnableSpeakerphone(_isSpeakerOn);
//   }

//   /// Safely terminates the internet connection, stops timers, and disposes hardware
//   Future<void> _endCall() async {
//     _timer?.cancel();
//     await _engine.leaveChannel();
//     await _engine.release();
//     if (mounted) Navigator.pop(context); // Go back to previous screen
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _engine.release(); // Failsafe cleanup
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // 🎯 Access your theme extensions cleanly
//     final colorScheme = context.colorScheme;
//     final textTheme = context.textTheme;

//     // Check if we should show video (Must be a video call AND the other person has joined)
//     final bool showVideo =
//         widget.callData.callType == CallType.video && _remoteUsers.isNotEmpty;

//     return Scaffold(
//       // 🎯 Dynamic Background: Black for video (to frame it well), Surface color for audio
//       backgroundColor: showVideo ? Colors.black : colorScheme.surface,

//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.keyboard_arrow_down_rounded),
//           iconSize: AppDimensions.iconXL,
//           color: showVideo ? Colors.white : colorScheme.onSurface,
//           onPressed: _endCall, // Dropping the screen ends the call
//         ),
//       ),
//       extendBodyBehindAppBar:
//           true, // Allows video to go full screen behind the app bar

//       body: Stack(
//         children: [
//           // -----------------------------------------
//           // 🎥 VIDEO RENDERING BACKGROUND (If Applicable)
//           // -----------------------------------------
//           if (showVideo) Positioned.fill(child: _buildVideoView()),

//           // Add a subtle gradient overlay if video is showing, so text remains readable
//           if (showVideo)
//             Positioned.fill(
//               child: DecoratedBox(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.black.withValues(alpha: 0.6),
//                       Colors.transparent,
//                       Colors.transparent,
//                       Colors.black.withValues(alpha: 0.8),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//           // -----------------------------------------
//           // 📞 FOREGROUND UI OVERLAY
//           // -----------------------------------------
//           SafeArea(
//             child: Column(
//               children: [
//                 // 1. TOP SECTION: Name & Timer
//                 AppDimensions.gapM,
//                 Text(
//                   widget.callData.receiverName,
//                   style: textTheme.headlineMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: showVideo ? Colors.white : colorScheme.onSurface,
//                   ),
//                   textAlign: TextAlign.center,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 AppDimensions.gapXS,
//                 Text(
//                   _isCallAnswered
//                       ? _formatDuration(_callDurationSeconds)
//                       : 'Calling...',
//                   style: textTheme.titleMedium?.copyWith(
//                     fontWeight: FontWeight.w500,
//                     color: showVideo
//                         ? Colors.white70
//                         : colorScheme.onSurfaceVariant,
//                   ),
//                 ),

//                 // 2. CENTER SECTION: Massive Avatar (Hidden if Video is actively playing)
//                 Expanded(
//                   child: Center(
//                     child: AnimatedOpacity(
//                       opacity: showVideo ? 0.0 : 1.0,
//                       duration: const Duration(milliseconds: 300),
//                       child: Container(
//                         padding: const EdgeInsets.all(AppDimensions.paddingM),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           // Soft outer glowing ring based on primary color
//                           color: colorScheme.primaryContainer.withValues(
//                             alpha: 0.3,
//                           ),
//                         ),
//                         child: AppCircleAvatar(
//                           imageUrl: widget.callData.avatarUrl ?? '',
//                           radius:
//                               80, // Massive avatar for the center of the screen
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 // 3. BOTTOM SECTION: Action Buttons
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     left: AppDimensions.paddingXL,
//                     right: AppDimensions.paddingXL,
//                     bottom: AppDimensions.paddingXXXL,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       // Mute Button
//                       _buildActionButton(
//                         context: context,
//                         icon: _isMuted
//                             ? Icons.mic_off_rounded
//                             : Icons.mic_none_rounded,
//                         label: 'Mute',
//                         isActive: _isMuted,
//                         showVideo: showVideo,
//                         onTap: _toggleMute,
//                       ),

//                       // END CALL BUTTON (Massive Red Button)
//                       GestureDetector(
//                         onTap: _endCall,
//                         child: Container(
//                           height: AppDimensions.size72,
//                           width: AppDimensions.size72,
//                           decoration: BoxDecoration(
//                             color: colorScheme.error,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: colorScheme.error.withValues(alpha: 0.3),
//                                 blurRadius: AppDimensions.radiusL,
//                                 spreadRadius: 2,
//                                 offset: const Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: Icon(
//                             Icons.call_end_rounded,
//                             color: colorScheme.onError,
//                             size: AppDimensions.size36,
//                           ),
//                         ),
//                       ),

//                       // Speaker Button
//                       _buildActionButton(
//                         context: context,
//                         icon: _isSpeakerOn
//                             ? Icons.volume_up_rounded
//                             : Icons.volume_down_rounded,
//                         label: 'Speaker',
//                         isActive: _isSpeakerOn,
//                         showVideo: showVideo,
//                         onTap: _toggleSpeaker,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Renders the Agora Video View
//   Widget _buildVideoView() {
//     return AgoraVideoView(
//       controller: VideoViewController.remote(
//         rtcEngine: _engine,
//         canvas: const VideoCanvas(
//           uid: 0,
//         ), // 0 defaults to the primary remote video stream
//         connection: RtcConnection(channelId: widget.callData.channelName),
//       ),
//     );
//   }

//   /// Floating action buttons adapted for Light/Dark themes and Video Overlay mode
//   Widget _buildActionButton({
//     required BuildContext context,
//     required IconData icon,
//     required String label,
//     required bool isActive,
//     required bool showVideo,
//     required VoidCallback onTap,
//   }) {
//     final colorScheme = context.colorScheme;

//     // Adjust colors based on whether it's floating over a video or on a standard surface
//     final Color inactiveBgColor = showVideo
//         ? Colors.white.withValues(alpha: 0.2)
//         : colorScheme.surfaceContainerHighest;
//     final Color inactiveIconColor = showVideo
//         ? Colors.white
//         : colorScheme.onSurface;

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         GestureDetector(
//           onTap: onTap,
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             height: AppDimensions.size56,
//             width: AppDimensions.size56,
//             decoration: BoxDecoration(
//               color: isActive ? colorScheme.primary : inactiveBgColor,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               icon,
//               color: isActive ? colorScheme.onPrimary : inactiveIconColor,
//               size: AppDimensions.iconXL,
//             ),
//           ),
//         ),
//         AppDimensions.gapS,
//         Text(
//           label,
//           style: TextStyle(
//             color: showVideo ? Colors.white : colorScheme.onSurfaceVariant,
//             fontSize: AppDimensions.fontSizeCaption,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';

// // 🎯 Import your design system, entities, and enums
// import '../../../../core/constants/app_dimensions.dart';
// import '../../../../core/extensions/build_context_extensions.dart';
// import '../../../../core/presentation/widgets/app_circle_avatar.dart';
// import '../../domain/enums/call_type.dart';

// // 📦 ADDED: Import the strongly-typed args class
// import '../args/active_call_screen_args.dart';

// /// 📱 Active Call Screen (Merged UI & Engine)
// ///
// /// Dynamically configures itself for Audio or Video calls based on [CallType].
// /// Uses Agora's UserAccount API to support String UUIDs from the Laravel backend,
// /// while wrapping everything in your beautiful custom design system.
// class ActiveCallScreen extends StatefulWidget {
//   // 🎯 CLEAN ARCHITECTURE UPGRADE:
//   // We now accept the strongly-typed arguments object to match our routing pattern.
//   final ActiveCallScreenArgs args;

//   const ActiveCallScreen({super.key, required this.args});

//   @override
//   State<ActiveCallScreen> createState() => _ActiveCallScreenState();
// }

// class _ActiveCallScreenState extends State<ActiveCallScreen> {
//   // ⚙️ Engine State
//   late RtcEngine _engine;
//   bool _isJoined = false;
//   bool _isMuted = false;
//   bool _isSpeakerOn = false;

//   // 👥 Remote Users tracking (Using Laravel String UUIDs)
//   final Set<String> _remoteUsers = {};

//   // ⏱️ UI Call State
//   bool _isCallAnswered = false;
//   int _callDurationSeconds = 0;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     _initInternetCall();
//   }

//   /// Initializes hardware permissions, UI defaults, and authenticates with Agora.
//   Future<void> _initInternetCall() async {
//     // 1. 🛡️ Request permissions based on the CallType Enum
//     if (widget.args.callData.callType == CallType.video) {
//       await [Permission.microphone, Permission.camera].request();
//       _isSpeakerOn = true; // Video calls usually default to speaker
//     } else {
//       await [Permission.microphone].request();
//       _isSpeakerOn = false; // Audio calls default to earpiece
//     }

//     // 2. ⚙️ Initialize the Agora Engine
//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(
//       RtcEngineContext(
//         appId: widget.args.callData.appId,
//         channelProfile: ChannelProfileType.channelProfileCommunication,
//       ),
//     );

//     // 3. 🎥 Hardware Routing (Audio vs Video)
//     if (widget.args.callData.callType == CallType.video) {
//       await _engine.enableVideo();
//       await _engine.startPreview(); // Shows local camera feed immediately
//     } else {
//       await _engine.enableAudio();
//       await _engine.disableVideo(); // Explicitly turn off camera hardware
//     }

//     // Apply the initial speaker state to the hardware
//     await _engine.setEnableSpeakerphone(_isSpeakerOn);

//     // 4. 📡 Register Event Handlers
//     _engine.registerEventHandler(
//       RtcEngineEventHandler(
//         // Triggered when WE successfully join the channel
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           if (mounted) {
//             setState(() => _isJoined = true);
//           }
//         },

//         // 🎯 IMPORTANT: Triggered when the REMOTE user joins.
//         // We use onUserInfoUpdated because we map Laravel String UUIDs to Agora UserAccounts.
//         onUserInfoUpdated: (int internalUid, UserInfo info) {
//           if (mounted) {
//             setState(() {
//               if (info.userAccount != null) {
//                 _remoteUsers.add(info.userAccount!);

//                 // ⏱️ Start the timer only when the other person actually connects!
//                 if (!_isCallAnswered) {
//                   _isCallAnswered = true;
//                   _startTimer();
//                 }
//               }
//             });
//           }
//         },

//         // Triggered when the remote user hangs up or drops
//         onUserOffline:
//             (
//               RtcConnection connection,
//               int remoteUid,
//               UserOfflineReasonType reason,
//             ) {
//               _endCall();
//             },
//       ),
//     );

//     // 5. 🚀 Join Channel using String User Account (UUID)
//     await _engine.joinChannelWithUserAccount(
//       token: widget.args.callData.token,
//       channelId: widget.args.callData.channelName,
//       userAccount: widget.args.callData.uid, // 🎯 The String UUID from Laravel
//       options: ChannelMediaOptions(
//         clientRoleType: ClientRoleType.clientRoleBroadcaster,
//         publishCameraTrack: widget.args.callData.callType == CallType.video,
//         publishMicrophoneTrack: true,
//       ),
//     );
//   }

//   /// Starts the call duration timer.
//   void _startTimer() {
//     _timer?.cancel(); // Failsafe to prevent double timers
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (mounted) {
//         setState(() {
//           _callDurationSeconds++;
//         });
//       }
//     });
//   }

//   /// Formats the raw seconds into a clean MM:SS string.
//   String _formatDuration(int seconds) {
//     final int minutes = seconds ~/ 60;
//     final int remainingSeconds = seconds % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
//   }

//   /// Toggles the local microphone feed to the internet
//   void _toggleMute() {
//     setState(() => _isMuted = !_isMuted);
//     _engine.muteLocalAudioStream(_isMuted);
//   }

//   /// Switches audio output between Earpiece and Loud Speaker
//   void _toggleSpeaker() {
//     setState(() => _isSpeakerOn = !_isSpeakerOn);
//     _engine.setEnableSpeakerphone(_isSpeakerOn);
//   }

//   /// Safely terminates the internet connection, stops timers, and disposes hardware
//   Future<void> _endCall() async {
//     _timer?.cancel();
//     await _engine.leaveChannel();
//     await _engine.release();
//     if (mounted) Navigator.pop(context); // Go back to previous screen
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _engine.release(); // Failsafe cleanup
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // 🎯 Access your theme extensions cleanly
//     final colorScheme = context.colorScheme;
//     final textTheme = context.textTheme;

//     // Check if we should show video (Must be a video call AND the other person has joined)
//     final bool showVideo =
//         widget.args.callData.callType == CallType.video &&
//         _remoteUsers.isNotEmpty;

//     return Scaffold(
//       // 🎯 Dynamic Background: Black for video (to frame it well), Surface color for audio
//       backgroundColor: showVideo ? Colors.black : colorScheme.surface,

//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.keyboard_arrow_down_rounded),
//           iconSize: AppDimensions.iconXL,
//           color: showVideo ? Colors.white : colorScheme.onSurface,
//           onPressed: _endCall, // Dropping the screen ends the call
//         ),
//       ),
//       extendBodyBehindAppBar:
//           true, // Allows video to go full screen behind the app bar

//       body: Stack(
//         children: [
//           // -----------------------------------------
//           // 🎥 VIDEO RENDERING BACKGROUND (If Applicable)
//           // -----------------------------------------
//           if (showVideo) Positioned.fill(child: _buildVideoView()),

//           // Add a subtle gradient overlay if video is showing, so text remains readable
//           if (showVideo)
//             Positioned.fill(
//               child: DecoratedBox(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.black.withValues(alpha: 0.6),
//                       Colors.transparent,
//                       Colors.transparent,
//                       Colors.black.withValues(alpha: 0.8),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//           // -----------------------------------------
//           // 📞 FOREGROUND UI OVERLAY
//           // -----------------------------------------
//           SafeArea(
//             child: Column(
//               children: [
//                 // 1. TOP SECTION: Name & Timer
//                 AppDimensions.gapM,
//                 Text(
//                   widget.args.callData.receiverName,
//                   style: textTheme.headlineMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: showVideo ? Colors.white : colorScheme.onSurface,
//                   ),
//                   textAlign: TextAlign.center,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 AppDimensions.gapXS,
//                 Text(
//                   _isCallAnswered
//                       ? _formatDuration(_callDurationSeconds)
//                       : 'Calling...',
//                   style: textTheme.titleMedium?.copyWith(
//                     fontWeight: FontWeight.w500,
//                     color: showVideo
//                         ? Colors.white70
//                         : colorScheme.onSurfaceVariant,
//                   ),
//                 ),

//                 // 2. CENTER SECTION: Massive Avatar (Hidden if Video is actively playing)
//                 Expanded(
//                   child: Center(
//                     child: AnimatedOpacity(
//                       opacity: showVideo ? 0.0 : 1.0,
//                       duration: const Duration(milliseconds: 300),
//                       child: Container(
//                         padding: const EdgeInsets.all(AppDimensions.paddingM),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           // Soft outer glowing ring based on primary color
//                           color: colorScheme.primaryContainer.withValues(
//                             alpha: 0.3,
//                           ),
//                         ),
//                         child: AppCircleAvatar(
//                           imageUrl: widget.args.callData.avatarUrl ?? '',
//                           radius:
//                               80, // Massive avatar for the center of the screen
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 // 3. BOTTOM SECTION: Action Buttons
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     left: AppDimensions.paddingXL,
//                     right: AppDimensions.paddingXL,
//                     bottom: AppDimensions.paddingXXXL,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       // Mute Button
//                       _buildActionButton(
//                         context: context,
//                         icon: _isMuted
//                             ? Icons.mic_off_rounded
//                             : Icons.mic_none_rounded,
//                         label: 'Mute',
//                         isActive: _isMuted,
//                         showVideo: showVideo,
//                         onTap: _toggleMute,
//                       ),

//                       // END CALL BUTTON (Massive Red Button)
//                       GestureDetector(
//                         onTap: _endCall,
//                         child: Container(
//                           height: AppDimensions.size72,
//                           width: AppDimensions.size72,
//                           decoration: BoxDecoration(
//                             color: colorScheme.error,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: colorScheme.error.withValues(alpha: 0.3),
//                                 blurRadius: AppDimensions.radiusL,
//                                 spreadRadius: 2,
//                                 offset: const Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: Icon(
//                             Icons.call_end_rounded,
//                             color: colorScheme.onError,
//                             size: AppDimensions.size36,
//                           ),
//                         ),
//                       ),

//                       // Speaker Button
//                       _buildActionButton(
//                         context: context,
//                         icon: _isSpeakerOn
//                             ? Icons.volume_up_rounded
//                             : Icons.volume_down_rounded,
//                         label: 'Speaker',
//                         isActive: _isSpeakerOn,
//                         showVideo: showVideo,
//                         onTap: _toggleSpeaker,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Renders the Agora Video View
//   Widget _buildVideoView() {
//     return AgoraVideoView(
//       controller: VideoViewController.remote(
//         rtcEngine: _engine,
//         canvas: const VideoCanvas(
//           uid: 0,
//         ), // 0 defaults to the primary remote video stream
//         connection: RtcConnection(channelId: widget.args.callData.channelName),
//       ),
//     );
//   }

//   /// Floating action buttons adapted for Light/Dark themes and Video Overlay mode
//   Widget _buildActionButton({
//     required BuildContext context,
//     required IconData icon,
//     required String label,
//     required bool isActive,
//     required bool showVideo,
//     required VoidCallback onTap,
//   }) {
//     final colorScheme = context.colorScheme;

//     // Adjust colors based on whether it's floating over a video or on a standard surface
//     final Color inactiveBgColor = showVideo
//         ? Colors.white.withValues(alpha: 0.2)
//         : colorScheme.surfaceContainerHighest;
//     final Color inactiveIconColor = showVideo
//         ? Colors.white
//         : colorScheme.onSurface;

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         GestureDetector(
//           onTap: onTap,
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             height: AppDimensions.size56,
//             width: AppDimensions.size56,
//             decoration: BoxDecoration(
//               color: isActive ? colorScheme.primary : inactiveBgColor,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               icon,
//               color: isActive ? colorScheme.onPrimary : inactiveIconColor,
//               size: AppDimensions.iconXL,
//             ),
//           ),
//         ),
//         AppDimensions.gapS,
//         Text(
//           label,
//           style: TextStyle(
//             color: showVideo ? Colors.white : colorScheme.onSurfaceVariant,
//             fontSize: AppDimensions.fontSizeCaption,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

// 🎯 Import your design system, entities, and enums
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/presentation/widgets/app_circle_avatar.dart';
import '../../domain/enums/call_type.dart';

// 📦 ADDED: Import the strongly-typed args class
import '../args/active_call_screen_args.dart';

/// 📱 Active Call Screen (Merged UI & Engine)
///
/// Dynamically configures itself for Audio or Video calls based on [CallType].
/// Uses Agora's UserAccount API to support String UUIDs from the Laravel backend,
/// while wrapping everything in your beautiful custom design system.
class ActiveCallScreen extends StatefulWidget {
  // 🎯 CLEAN ARCHITECTURE UPGRADE:
  // We now accept the strongly-typed arguments object to match our routing pattern.
  final ActiveCallScreenArgs args;

  const ActiveCallScreen({super.key, required this.args});

  @override
  State<ActiveCallScreen> createState() => _ActiveCallScreenState();
}

class _ActiveCallScreenState extends State<ActiveCallScreen> {
  // ⚙️ Engine State
  late RtcEngine _engine;
  bool _isJoined = false;
  bool _isMuted = false;
  bool _isSpeakerOn = false;

  // 👥 Remote Users tracking (Using Laravel String UUIDs)
  final Set<String> _remoteUsers = {};

  // ⏱️ UI Call State
  bool _isCallAnswered = false;
  int _callDurationSeconds = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initInternetCall();
  }

  /// Initializes hardware permissions, UI defaults, and authenticates with Agora.
  Future<void> _initInternetCall() async {
    // 1. 🛡️ Request permissions based on the CallType Enum
    if (widget.args.callData.callType == CallType.video) {
      await [Permission.microphone, Permission.camera].request();
      _isSpeakerOn = true; // Video calls usually default to speaker
    } else {
      await [Permission.microphone].request();
      _isSpeakerOn = false; // Audio calls default to earpiece
    }

    // 2. ⚙️ Initialize the Agora Engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(
      RtcEngineContext(
        appId: widget.args.callData.appId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );

    // 3. 🎥 Hardware Routing (Audio vs Video)
    if (widget.args.callData.callType == CallType.video) {
      await _engine.enableVideo();
      await _engine.startPreview(); // Shows local camera feed immediately
    } else {
      await _engine.enableAudio();
      await _engine.disableVideo(); // Explicitly turn off camera hardware
    }

    // 🎯 FIX APPLIED: Tell Agora what the default route should be BEFORE joining the channel
    await _engine.setDefaultAudioRouteToSpeakerphone(_isSpeakerOn);

    // 🛡️ DEFENSIVE FIX: Safely wrap the immediate toggle in a try-catch just in case
    // the SDK isn't ready yet. This prevents the ERR_NOT_READY (-3) crash!
    try {
      await _engine.setEnableSpeakerphone(_isSpeakerOn);
    } catch (e) {
      debugPrint('Agora Audio Route Not Ready Yet: $e');
      // It's safe to ignore this because we already set the default route above,
      // and the user can toggle the speaker button manually once connected!
    }

    // 4. 📡 Register Event Handlers
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        // Triggered when WE successfully join the channel
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          if (mounted) {
            setState(() => _isJoined = true);
          }
        },

        // 🎯 IMPORTANT: Triggered when the REMOTE user joins.
        // We use onUserInfoUpdated because we map Laravel String UUIDs to Agora UserAccounts.
        onUserInfoUpdated: (int internalUid, UserInfo info) {
          if (mounted) {
            setState(() {
              if (info.userAccount != null) {
                _remoteUsers.add(info.userAccount!);

                // ⏱️ Start the timer only when the other person actually connects!
                if (!_isCallAnswered) {
                  _isCallAnswered = true;
                  _startTimer();
                }
              }
            });
          }
        },

        // Triggered when the remote user hangs up or drops
        onUserOffline:
            (
              RtcConnection connection,
              int remoteUid,
              UserOfflineReasonType reason,
            ) {
              _endCall();
            },
      ),
    );

    // 5. 🚀 Join Channel using String User Account (UUID)
    await _engine.joinChannelWithUserAccount(
      token: widget.args.callData.token,
      channelId: widget.args.callData.channelName,
      userAccount: widget.args.callData.uid, // 🎯 The String UUID from Laravel
      options: ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        publishCameraTrack: widget.args.callData.callType == CallType.video,
        publishMicrophoneTrack: true,
      ),
    );
  }

  /// Starts the call duration timer.
  void _startTimer() {
    _timer?.cancel(); // Failsafe to prevent double timers
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _callDurationSeconds++;
        });
      }
    });
  }

  /// Formats the raw seconds into a clean MM:SS string.
  String _formatDuration(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  /// Toggles the local microphone feed to the internet
  void _toggleMute() {
    setState(() => _isMuted = !_isMuted);
    _engine.muteLocalAudioStream(_isMuted);
  }

  /// Switches audio output between Earpiece and Loud Speaker
  void _toggleSpeaker() async {
    setState(() => _isSpeakerOn = !_isSpeakerOn);

    // 🛡️ DEFENSIVE FIX: Prevent manual button taps from crashing the app
    // if the internet drops or the audio engine isn't ready.
    try {
      await _engine.setEnableSpeakerphone(_isSpeakerOn);
    } catch (e) {
      debugPrint('Failed to route speaker hardware: $e');
    }
  }

  /// Safely terminates the internet connection, stops timers, and disposes hardware
  Future<void> _endCall() async {
    _timer?.cancel();
    await _engine.leaveChannel();
    await _engine.release();
    if (mounted) Navigator.pop(context); // Go back to previous screen
  }

  @override
  void dispose() {
    _timer?.cancel();
    _engine.release(); // Failsafe cleanup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 🎯 Access your theme extensions cleanly
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    // Check if we should show video (Must be a video call AND the other person has joined)
    final bool showVideo =
        widget.args.callData.callType == CallType.video &&
        _remoteUsers.isNotEmpty;

    return Scaffold(
      // 🎯 Dynamic Background: Black for video (to frame it well), Surface color for audio
      backgroundColor: showVideo ? Colors.black : colorScheme.surface,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          iconSize: AppDimensions.iconXL,
          color: showVideo ? Colors.white : colorScheme.onSurface,
          onPressed: _endCall, // Dropping the screen ends the call
        ),
      ),
      extendBodyBehindAppBar:
          true, // Allows video to go full screen behind the app bar

      body: Stack(
        children: [
          // -----------------------------------------
          // 🎥 VIDEO RENDERING BACKGROUND (If Applicable)
          // -----------------------------------------
          if (showVideo) Positioned.fill(child: _buildVideoView()),

          // Add a subtle gradient overlay if video is showing, so text remains readable
          if (showVideo)
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.6),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.8),
                    ],
                  ),
                ),
              ),
            ),

          // -----------------------------------------
          // 📞 FOREGROUND UI OVERLAY
          // -----------------------------------------
          SafeArea(
            child: Column(
              children: [
                // 1. TOP SECTION: Name & Timer
                AppDimensions.gapM,
                Text(
                  widget.args.callData.receiverName,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: showVideo ? Colors.white : colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                AppDimensions.gapXS,
                Text(
                  _isCallAnswered
                      ? _formatDuration(_callDurationSeconds)
                      : 'Calling...',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: showVideo
                        ? Colors.white70
                        : colorScheme.onSurfaceVariant,
                  ),
                ),

                // 2. CENTER SECTION: Massive Avatar (Hidden if Video is actively playing)
                Expanded(
                  child: Center(
                    child: AnimatedOpacity(
                      opacity: showVideo ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        padding: const EdgeInsets.all(AppDimensions.paddingM),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // Soft outer glowing ring based on primary color
                          color: colorScheme.primaryContainer.withValues(
                            alpha: 0.3,
                          ),
                        ),
                        child: AppCircleAvatar(
                          imageUrl: widget.args.callData.avatarUrl ?? '',
                          radius:
                              80, // Massive avatar for the center of the screen
                        ),
                      ),
                    ),
                  ),
                ),

                // 3. BOTTOM SECTION: Action Buttons
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppDimensions.paddingXL,
                    right: AppDimensions.paddingXL,
                    bottom: AppDimensions.paddingXXXL,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Mute Button
                      _buildActionButton(
                        context: context,
                        icon: _isMuted
                            ? Icons.mic_off_rounded
                            : Icons.mic_none_rounded,
                        label: 'Mute',
                        isActive: _isMuted,
                        showVideo: showVideo,
                        onTap: _toggleMute,
                      ),

                      // END CALL BUTTON (Massive Red Button)
                      GestureDetector(
                        onTap: _endCall,
                        child: Container(
                          height: AppDimensions.size72,
                          width: AppDimensions.size72,
                          decoration: BoxDecoration(
                            color: colorScheme.error,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.error.withValues(alpha: 0.3),
                                blurRadius: AppDimensions.radiusL,
                                spreadRadius: 2,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.call_end_rounded,
                            color: colorScheme.onError,
                            size: AppDimensions.size36,
                          ),
                        ),
                      ),

                      // Speaker Button
                      _buildActionButton(
                        context: context,
                        icon: _isSpeakerOn
                            ? Icons.volume_up_rounded
                            : Icons.volume_down_rounded,
                        label: 'Speaker',
                        isActive: _isSpeakerOn,
                        showVideo: showVideo,
                        onTap: _toggleSpeaker,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Renders the Agora Video View
  Widget _buildVideoView() {
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: _engine,
        canvas: const VideoCanvas(
          uid: 0,
        ), // 0 defaults to the primary remote video stream
        connection: RtcConnection(channelId: widget.args.callData.channelName),
      ),
    );
  }

  /// Floating action buttons adapted for Light/Dark themes and Video Overlay mode
  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isActive,
    required bool showVideo,
    required VoidCallback onTap,
  }) {
    final colorScheme = context.colorScheme;

    // Adjust colors based on whether it's floating over a video or on a standard surface
    final Color inactiveBgColor = showVideo
        ? Colors.white.withValues(alpha: 0.2)
        : colorScheme.surfaceContainerHighest;
    final Color inactiveIconColor = showVideo
        ? Colors.white
        : colorScheme.onSurface;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: AppDimensions.size56,
            width: AppDimensions.size56,
            decoration: BoxDecoration(
              color: isActive ? colorScheme.primary : inactiveBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? colorScheme.onPrimary : inactiveIconColor,
              size: AppDimensions.iconXL,
            ),
          ),
        ),
        AppDimensions.gapS,
        Text(
          label,
          style: TextStyle(
            color: showVideo ? Colors.white : colorScheme.onSurfaceVariant,
            fontSize: AppDimensions.fontSizeCaption,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
