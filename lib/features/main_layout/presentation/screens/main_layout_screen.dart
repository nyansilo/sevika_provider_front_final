// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../core/constants/app_dimensions.dart';
// import '../../../../core/di/service_locator.dart';
// import '../../../../core/extensions/build_context_extensions.dart';
// import '../../../../core/services/push_notification_service.dart';
// import '../../../../core/storage/auth_token_manager.dart';
// import '../../../../core/usecases/usecase.dart';
// import '../../../auth/presentation/cubits/auth/auth_cubit.dart';
// import '../../../auth/presentation/cubits/auth/auth_state.dart';
// import '../../../booking/presentation/cubits/booking_history/booking_history_cubit.dart';
// import '../../../booking/presentation/screens/bookings_dashboard_screen.dart';
// import '../../../chat/presentation/cubits/chat_cubit.dart';
// import '../../../chat/presentation/screens/chat_room_dashboard_screen.dart';
// import '../../../home/screens/home_dashboard_screen.dart';
// import '../../../notification/presentation/cubits/notification/notifications_cubit.dart';
// import '../../../profile/presentation/screens/profile_dashboard_screen.dart';
// import '../widgets/navigation_tab_item.dart';

// class MainLayoutScreen extends StatefulWidget {
//   // 🎯 INDUSTRY STANDARD FIX: A GlobalKey allows deep-linked screens (like Notifications)
//   // to safely command the Root Layout to switch tabs WITHOUT destroying the Bottom Nav Bar!
//   static final GlobalKey<_MainLayoutScreenState> layoutKey =
//       GlobalKey<_MainLayoutScreenState>();

//   MainLayoutScreen({Key? key}) : super(key: key ?? layoutKey);

//   @override
//   State<MainLayoutScreen> createState() => _MainLayoutScreenState();
// }

// class _MainLayoutScreenState extends State<MainLayoutScreen> {
//   int _currentTab = 0;
//   int _bookingInnerTab = 0; // 🎯 Tracks the inner tab of the Booking Dashboard
//   bool _isWebSocketInitialized = false;
//   late NotificationsCubit _notificationsCubit;

//   // 🎯 PUBLIC METHOD: Allows the Notification Screen to safely command a tab switch
//   void navigateToTab(int mainIndex, {int innerIndex = 0}) {
//     if (mounted) {
//       setState(() {
//         _currentTab = mainIndex;
//         if (mainIndex == 1) {
//           _bookingInnerTab = innerIndex;
//         }
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _notificationsCubit = context.read<NotificationsCubit>();

//     final authState = context.read<AuthCubit>().state;
//     if (authState is AuthAuthenticated) {
//       _initLiveNotifications(authState);

//       try {
//         sl<PushNotificationService>().initialize();
//       } catch (e) {
//         debugPrint('⚠️ Push notification initialization skipped: $e');
//       }
//     }
//   }

//   void _initLiveNotifications(AuthAuthenticated authState) async {
//     if (authState.user.userId.isEmpty) return;
//     if (_isWebSocketInitialized) return;
//     _isWebSocketInitialized = true;

//     final tokenManager = sl<AuthTokenManager>();
//     final String? token = await tokenManager.getAccessToken();

//     if (token != null && token.isNotEmpty && mounted) {
//       _notificationsCubit.initLiveNotificationListener(
//         userId: authState.user.userId.toString(),
//         token: token,
//       );
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<AuthCubit, AuthState>(
//           listenWhen: (previous, current) =>
//               current is AuthAuthenticated &&
//               current.user.userId.isNotEmpty &&
//               !_isWebSocketInitialized,
//           listener: (context, state) {
//             if (state is AuthAuthenticated) {
//               _initLiveNotifications(state);
//               try {
//                 sl<PushNotificationService>().initialize();
//               } catch (_) {}
//             }
//           },
//         ),
//         BlocListener<AuthCubit, AuthState>(
//           listenWhen: (previous, current) => current is AuthUnauthenticated,
//           listener: (context, state) {
//             try {
//               _notificationsCubit.disconnectLiveNotificationsUseCase.call(
//                 const NoParams(),
//               );
//               _isWebSocketInitialized = false;
//             } catch (e) {
//               debugPrint('⚠️ WebSocket disposal hook failed: $e');
//             }
//           },
//         ),
//       ],
//       child: Scaffold(
//         backgroundColor: context.colorScheme.surface,
//         body: BlocBuilder<AuthCubit, AuthState>(
//           builder: (context, authState) {
//             if (authState is! AuthAuthenticated) {
//               return const Center(child: CircularProgressIndicator.adaptive());
//             }

//             return Center(
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(
//                   maxWidth: AppDimensions.maxDashboardWidth,
//                 ),
//                 // 🎯 DYNAMIC BUILD: We build the screens directly here so they safely
//                 // receive their Cubits, and instantly react when _bookingInnerTab changes!
//                 child: IndexedStack(
//                   index: _currentTab,
//                   children: [
//                     HomeDashboardScreen(
//                       onSwitchTab: (index) => navigateToTab(index),
//                     ),

//                     // 🚀 Provides the missing History Cubit directly to the tab!
//                     BlocProvider<BookingHistoryCubit>(
//                       create: (_) => sl<BookingHistoryCubit>(),
//                       child: BookingDashboardScreen(
//                         // ValueKey forces a fresh rebuild if the notification tells us to switch inner tabs
//                         key: ValueKey('booking_tab_$_bookingInnerTab'),
//                         initialTabIndex: _bookingInnerTab,
//                       ),
//                     ),

//                     // 🚀 Provides the missing Chat Cubit directly to the tab!
//                     BlocProvider<ChatCubit>(
//                       create: (_) => sl<ChatCubit>(),
//                       child: const ChatRoomDashboardScreen(),
//                     ),

//                     const ProfileDashboardScreen(),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//         bottomNavigationBar: BottomAppBar(
//           shape: const CircularNotchedRectangle(),
//           clipBehavior: Clip.antiAlias,
//           padding: EdgeInsets.zero,
//           child: Container(
//             height: AppDimensions.bottomNavBarHeight,
//             decoration: BoxDecoration(
//               color: context.colorScheme.surfaceContainer,
//               border: Border(
//                 top: BorderSide(
//                   color: context.colorScheme.outlineVariant,
//                   width: AppDimensions.navBorderThin,
//                 ),
//               ),
//             ),
//             child: Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   NavigationTabItem(
//                     icon: Icons.dashboard_outlined,
//                     activeIcon: Icons.dashboard_rounded,
//                     label: 'Dashboard',
//                     isSelected: _currentTab == 0,
//                     onTap: () => navigateToTab(0),
//                   ),
//                   NavigationTabItem(
//                     icon: Icons.work_outline_rounded,
//                     activeIcon: Icons.work_rounded,
//                     label: 'My Jobs',
//                     isSelected: _currentTab == 1,
//                     onTap: () => navigateToTab(1),
//                   ),
//                   NavigationTabItem(
//                     icon: Icons.chat_bubble_outline_rounded,
//                     activeIcon: Icons.chat_bubble_rounded,
//                     label: 'Inbox',
//                     isSelected: _currentTab == 2,
//                     onTap: () => navigateToTab(2),
//                   ),
//                   NavigationTabItem(
//                     icon: Icons.person_outline_rounded,
//                     activeIcon: Icons.person_rounded,
//                     label: 'Profile',
//                     isSelected: _currentTab == 3,
//                     onTap: () => navigateToTab(3),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/services/push_notification_service.dart';
import '../../../../core/storage/auth_token_manager.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../auth/presentation/cubits/auth/auth_cubit.dart';
import '../../../auth/presentation/cubits/auth/auth_state.dart';
import '../../../booking/presentation/cubits/booking_history/booking_history_cubit.dart';
import '../../../booking/presentation/screens/bookings_dashboard_screen.dart';
import '../../../chat/presentation/cubits/chat_cubit.dart';
import '../../../chat/presentation/screens/chat_room_dashboard_screen.dart';
import '../../../home/screens/home_dashboard_screen.dart';

// 🛡️ ADDED: Import the KYC Cubit so we can inject it into the Home Dashboard
import '../../../kyc/presentation/cubits/provider_kyc_cubit.dart';

import '../../../notification/presentation/cubits/notification/notifications_cubit.dart';
import '../../../profile/presentation/screens/profile_dashboard_screen.dart';
import '../widgets/navigation_tab_item.dart';

class MainLayoutScreen extends StatefulWidget {
  // 🎯 INDUSTRY STANDARD FIX: A GlobalKey allows deep-linked screens (like Notifications)
  // to safely command the Root Layout to switch tabs WITHOUT destroying the Bottom Nav Bar!
  static final GlobalKey<_MainLayoutScreenState> layoutKey =
      GlobalKey<_MainLayoutScreenState>();

  MainLayoutScreen({Key? key}) : super(key: key ?? layoutKey);

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentTab = 0;
  int _bookingInnerTab = 0; // 🎯 Tracks the inner tab of the Booking Dashboard
  bool _isWebSocketInitialized = false;
  late NotificationsCubit _notificationsCubit;

  // 🎯 PUBLIC METHOD: Allows the Notification Screen to safely command a tab switch.
  // This is how we achieve seamless cross-tab deep linking.
  void navigateToTab(int mainIndex, {int innerIndex = 0}) {
    if (mounted) {
      setState(() {
        _currentTab = mainIndex;
        if (mainIndex == 1) {
          _bookingInnerTab = innerIndex;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _notificationsCubit = context.read<NotificationsCubit>();

    final authState = context.read<AuthCubit>().state;
    if (authState is AuthAuthenticated) {
      _initLiveNotifications(authState);

      try {
        sl<PushNotificationService>().initialize();
      } catch (e) {
        debugPrint('⚠️ Push notification initialization skipped: $e');
      }
    }
  }

  void _initLiveNotifications(AuthAuthenticated authState) async {
    if (authState.user.userId.isEmpty) return;
    if (_isWebSocketInitialized) return;
    _isWebSocketInitialized = true;

    final tokenManager = sl<AuthTokenManager>();
    final String? token = await tokenManager.getAccessToken();

    if (token != null && token.isNotEmpty && mounted) {
      _notificationsCubit.initLiveNotificationListener(
        userId: authState.user.userId.toString(),
        token: token,
      );
    }
  }

  @override
  void dispose() {
    // We do NOT disconnect websockets here so background messages
    // continue to flow even if this specific widget unmounts temporarily.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // 1️⃣ Re-initialize sockets if Auth State changes securely
        BlocListener<AuthCubit, AuthState>(
          listenWhen: (previous, current) =>
              current is AuthAuthenticated &&
              current.user.userId.isNotEmpty &&
              !_isWebSocketInitialized,
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              _initLiveNotifications(state);
              try {
                sl<PushNotificationService>().initialize();
              } catch (_) {}
            }
          },
        ),
        // 2️⃣ Kill sockets instantly on logout for maximum security
        BlocListener<AuthCubit, AuthState>(
          listenWhen: (previous, current) => current is AuthUnauthenticated,
          listener: (context, state) {
            try {
              _notificationsCubit.disconnectLiveNotificationsUseCase.call(
                const NoParams(),
              );
              _isWebSocketInitialized = false;
            } catch (e) {
              debugPrint('⚠️ WebSocket disposal hook failed: $e');
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            // Guard clause prevents child errors if token evicts suddenly
            if (authState is! AuthAuthenticated) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppDimensions.maxDashboardWidth,
                ),
                // 🎯 ARCHITECTURE NOTE: The IndexedStack preserves state for all tabs.
                // By injecting the Cubits *here* instead of globally, we keep memory
                // clean but allow the tabs to maintain their scrolled positions and data.
                child: IndexedStack(
                  index: _currentTab,
                  children: [
                    // 🚀 TAB 0: HOME DASHBOARD
                    // THE FIX: We inject ProviderKycCubit here so the Dashboard's "Decision Engine"
                    // can fetch the live API status and dynamically hide the Red Warning Banners!
                    BlocProvider<ProviderKycCubit>(
                      create: (_) => sl<ProviderKycCubit>(),
                      child: HomeDashboardScreen(
                        onSwitchTab: (index) => navigateToTab(index),
                      ),
                    ),

                    // 🚀 TAB 1: BOOKING HISTORY
                    // Provides the missing History Cubit directly to the tab!
                    BlocProvider<BookingHistoryCubit>(
                      create: (_) => sl<BookingHistoryCubit>(),
                      child: BookingDashboardScreen(
                        // ValueKey forces a fresh rebuild if the notification tells us to switch inner tabs
                        key: ValueKey('booking_tab_$_bookingInnerTab'),
                        initialTabIndex: _bookingInnerTab,
                      ),
                    ),

                    // 🚀 TAB 2: CHAT ROOM
                    // Provides the missing Chat Cubit directly to the tab!
                    BlocProvider<ChatCubit>(
                      create: (_) => sl<ChatCubit>(),
                      child: const ChatRoomDashboardScreen(),
                    ),

                    // 🚀 TAB 3: PROFILE
                    // Profile provides its own localized auxiliary cubits (like KYC and Reviews)
                    // inside its own file via MultiBlocProvider.
                    const ProfileDashboardScreen(),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          clipBehavior: Clip.antiAlias,
          padding: EdgeInsets.zero,
          child: Container(
            height: AppDimensions.bottomNavBarHeight,
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainer,
              border: Border(
                top: BorderSide(
                  color: context.colorScheme.outlineVariant,
                  width: AppDimensions.navBorderThin,
                ),
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavigationTabItem(
                    icon: Icons.dashboard_outlined,
                    activeIcon: Icons.dashboard_rounded,
                    label: 'Dashboard',
                    isSelected: _currentTab == 0,
                    onTap: () => navigateToTab(0),
                  ),
                  NavigationTabItem(
                    icon: Icons.work_outline_rounded,
                    activeIcon: Icons.work_rounded,
                    label: 'My Jobs',
                    isSelected: _currentTab == 1,
                    onTap: () => navigateToTab(1),
                  ),
                  NavigationTabItem(
                    icon: Icons.chat_bubble_outline_rounded,
                    activeIcon: Icons.chat_bubble_rounded,
                    label: 'Inbox',
                    isSelected: _currentTab == 2,
                    onTap: () => navigateToTab(2),
                  ),
                  NavigationTabItem(
                    icon: Icons.person_outline_rounded,
                    activeIcon: Icons.person_rounded,
                    label: 'Profile',
                    isSelected: _currentTab == 3,
                    onTap: () => navigateToTab(3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
