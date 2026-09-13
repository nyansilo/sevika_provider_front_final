import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🎯 Core & UI Imports
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/extensions/date_formatter_extension.dart';
import '../../../../core/global/presentation/widgets/app_circle_avatar.dart';
import '../../../../core/global/presentation/widgets/sevika_state_placeholder.dart';
import '../../../../core/routes/route_list.dart';
import '../../../../core/storage/auth_token_manager.dart';

// 📍 NEW: Import our abstracted Location Service
import '../../../../core/services/location_service.dart';

// 🧠 Auth & Job Cubits
import '../../../auth/presentation/cubits/auth/auth_cubit.dart';
import '../../../auth/presentation/cubits/auth/auth_state.dart';
import '../../../call/domain/enums/call_type.dart';
import '../../../call/presentation/args/active_call_screen_args.dart';

// 💬 Chat Feature
import '../cubits/chat_cubit.dart';
import '../cubits/chat_state.dart';
import '../widgets/chat_room/chat_bubble.dart';
import '../widgets/chat_room/chat_input_bar.dart';
import '../args/inbox_screen_args.dart'; // Ensure args contain Customer info now!

// 📞 Call Feature Cubit & States
import '../../../call/presentation/cubit/call_cubit.dart';
import '../../../call/presentation/cubit/call_state.dart';

class InboxScreen extends StatefulWidget {
  final InboxScreenArgs args;

  const InboxScreen({super.key, required this.args});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  // 📍 Track GPS fetching state to show the loading spinner
  bool _isFetchingLocation = false;

  // 📍 Instantiate our new clean architecture service
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().loadMessageStream(roomId: widget.args.roomId);
    _initializeLiveChat();
  }

  Future<void> _initializeLiveChat() async {
    debugPrint('🔌 1. Attempting to start Chat WebSocket...');

    final authState = context.read<AuthCubit>().state;

    if (authState is AuthAuthenticated) {
      final String currentUserId = authState.user.userId.toString();
      final token = await sl<AuthTokenManager>().getAccessToken();

      if (token != null && token.isNotEmpty && mounted) {
        context.read<ChatCubit>().initLiveChatListener(
          userId: currentUserId,
          roomId: widget.args.roomId,
          token: token,
        );
      }
    }
  }

  void _sendNewMessage(String text) {
    context.read<ChatCubit>().sendTextMessage(text: text);
  }

  /// 📍 Cleaned up Location Message Handler
  // 1. 🛰️ Delegate all the heavy lifting to our dedicated service.
  // 👨‍🔧 PROVIDER USE CASE: "I'm 5 minutes away, here is my live location."
  Future<void> _sendLocationMessage() async {
    setState(() => _isFetchingLocation = true);

    try {
      // 1. 🛰️ Delegate all the heavy lifting to our dedicated service
      final locationData = await _locationService
          .getCurrentLocationWithAddress();

      // 2. 🚀 DISPATCH TO BACKEND: Send via Cubit exactly like a text message
      if (mounted) {
        context.read<ChatCubit>().sendLocationMessage(
          latitude: locationData.latitude,
          longitude: locationData.longitude,
          label: locationData.addressLabel,
        );
      }
    } catch (e) {
      // ❌ HANDLE FAILURES: Show a beautiful error snackbar if GPS is off or denied
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: context.colorScheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      // 🛑 Turn off the loading spinner
      if (mounted) {
        setState(() => _isFetchingLocation = false);
      }
    }
  }

  // 👨‍🔧 Audio call rings the CUSTOMER's device
  void _makeAudioCall() {
    context.read<CallCubit>().initiateCall(
      receiverId: widget.args.customerId, // 🎯 Changed from providerId
      callType: CallType.audio,
    );
  }

  // 👨‍🔧 Video call rings the CUSTOMER's device
  void _makeVideoCall() {
    context.read<CallCubit>().initiateCall(
      receiverId: widget.args.customerId, // 🎯 Changed from providerId
      callType: CallType.video,
    );
  }

  // 👨‍🔧 Navigate to the Job Details screen instead of "Reviewing a Bid"
  void _viewJobDetails() {
    if (widget.args.bookingEntity != null) {
      Navigator.pushNamed(
        context,
        RouteList.bookingDetailPage,
        arguments: widget.args.bookingEntity,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocListener<CallCubit, CallState>(
        listener: (context, callState) {
          if (callState is CallInitiatedSuccess) {
            Navigator.pushNamed(
              context,
              RouteList.activeCallPage,
              arguments: ActiveCallScreenArgs(callData: callState.callData),
            );
          } else if (callState is CallFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  callState.error.message ?? 'Failed to initiate call',
                ),
                backgroundColor: context.colorScheme.error,
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: context.colorScheme.surface,
          appBar: AppBar(
            backgroundColor: context.colorScheme.surface,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              iconSize: AppDimensions.iconS,
              onPressed: () => Navigator.pop(context),
            ),
            titleSpacing: 0,
            title: Row(
              children: [
                AppCircleAvatar(
                  imageUrl: widget.args.avatarUrl,
                  radius: AppDimensions.avatarRadiusM,
                ),
                AppDimensions.gapS,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.args.customerName, // 👨‍🔧 Display Customer Name
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.args.jobTitle, // 👨‍🔧 Display requested service
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.outline,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              // 👨‍🔧 Action to view the full Booking/Job Details
              if (widget.args.bookingEntity != null)
                TextButton.icon(
                  onPressed: _viewJobDetails,
                  icon: Icon(
                    Icons.work_outline_rounded,
                    color: context.colorScheme.primary,
                  ),
                  label: Text(
                    'View Job',
                    style: TextStyle(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              BlocBuilder<CallCubit, CallState>(
                builder: (context, callState) {
                  if (callState is CallLoading) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingM,
                      ),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.phone_outlined),
                        iconSize: AppDimensions.iconL,
                        color: context.colorScheme.primary,
                        onPressed: _makeAudioCall,
                      ),
                      IconButton(
                        icon: const Icon(Icons.videocam_outlined),
                        iconSize: AppDimensions.iconL,
                        color: context.colorScheme.primary,
                        onPressed: _makeVideoCall,
                      ),
                    ],
                  );
                },
              ),
              AppDimensions.gapS,
            ],
          ),
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppDimensions.maxDashboardWidth,
                ),
                child: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    if (state is ChatStreamLoading || state is ChatInitial) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }

                    if (state is ChatStreamLoadFailure) {
                      return SevikaStatePlaceholder(
                        title: 'Stream Disconnected',
                        message:
                            state.error.message ?? 'Failed to load messages.',
                        icon: Icons.wifi_off_rounded,
                        iconColor: context.colorScheme.error,
                        iconBackgroundColor: context.colorScheme.errorContainer
                            .withValues(alpha: 0.3),
                        actionButtonText: 'Reconnect',
                        actionButtonIcon: Icons.refresh_rounded,
                        onActionPressed: () => context
                            .read<ChatCubit>()
                            .loadMessageStream(roomId: widget.args.roomId),
                      );
                    }

                    if (state is ChatStreamLoadSuccess) {
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              reverse: true,
                              padding: const EdgeInsets.all(
                                AppDimensions.paddingM,
                              ),
                              itemCount: state.messages.length,
                              separatorBuilder: (context, index) =>
                                  AppDimensions.gapM,
                              itemBuilder: (context, index) {
                                final msg = state.messages[index];
                                return ChatBubble(
                                  message: msg.body,
                                  timeString: msg.sentAt.toSimpleTime(),
                                  isMe: msg.isMe,
                                  isLocation: msg.isLocation,
                                  locationMetadata: msg.metadata,
                                );
                              },
                            ),
                          ),
                          ChatInputBar(
                            onSendMessage: _sendNewMessage,
                            onSendLocation: _sendLocationMessage,
                            isSending: state.isSending || _isFetchingLocation,
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
