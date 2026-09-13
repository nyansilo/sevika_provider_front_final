// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../core/constants/app_dimensions.dart';
// import '../../../core/extensions/build_context_extensions.dart';
// import '../../../core/routes/route_list.dart';
// import '../../../core/di/service_locator.dart';
// import '../../../core/storage/auth_token_manager.dart';
// import '../../auth/presentation/cubits/auth/auth_cubit.dart';
// import '../../auth/presentation/cubits/auth/auth_state.dart';
// import '../../notification/presentation/cubits/notification/notifications_cubit.dart';
// import '../../notification/presentation/cubits/notification/notifications_state.dart';
// import '../../profile/presentation/cubits/profile/profile_cubit.dart';
// import '../../profile/presentation/cubits/profile/profile_state.dart';

// import '../widgets/home_header.dart';
// import '../widgets/home_section_header.dart';

// // 🎯 NEW WIDGET IMPORTS
// import '../widgets/status_toggle_banner.dart';
// import '../widgets/earnings_summary_card.dart';
// import '../widgets/job_request_card.dart';

// class HomeDashboardScreen extends StatefulWidget {
//   // 🎯 INDUSTRY STANDARD: A callback to pass navigation events up to the Root layout
//   final ValueChanged<int>? onSwitchTab;

//   const HomeDashboardScreen({super.key, this.onSwitchTab});

//   @override
//   State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
// }

// class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
//   // 👨‍🔧 Provider availability state toggler (To be moved to a Cubit later)
//   bool _isOnline = true;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) _hydrateProviderDashboard();
//     });
//   }

//   Future<void> _hydrateProviderDashboard() async {
//     final authState = context.read<AuthCubit>().state;

//     if (authState is AuthAuthenticated) {
//       final token = await sl<AuthTokenManager>().getAccessToken();
//       if (token != null && mounted) {
//         context.read<NotificationsCubit>().initLiveNotificationListener(
//           userId: authState.user.userId.toString(),
//           token: token,
//         );
//         context.read<NotificationsCubit>().loadNotifications();
//         context.read<ProfileCubit>().loadProfile();
//         // 👨‍🔧 Load pending leads and earnings here...
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final l10n = context.l10n;
//     final profileState = context.watch<ProfileCubit>().state;

//     String? profileImageUrl;
//     if (profileState is ProfileLoaded) {
//       profileImageUrl = profileState.profile.userBase.profileImage;
//     }

//     return BlocListener<NotificationsCubit, NotificationsState>(
//       listenWhen: (previous, current) {
//         if (previous is NotificationsLoadSuccess &&
//             current is NotificationsLoadSuccess) {
//           return current.unreadCount > previous.unreadCount;
//         }
//         return false;
//       },
//       listener: (context, state) {
//         // Notification SnackBar Logic...
//       },
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: context.colorScheme.surface,
//         body: SafeArea(
//           child: Center(
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(
//                 maxWidth: AppDimensions.maxDashboardWidth,
//               ),
//               child: RefreshIndicator(
//                 onRefresh: _hydrateProviderDashboard,
//                 child: SingleChildScrollView(
//                   physics: const AlwaysScrollableScrollPhysics(),
//                   padding: const EdgeInsets.symmetric(
//                     vertical: AppDimensions.paddingM,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // 1. Header Bar
//                       BlocBuilder<NotificationsCubit, NotificationsState>(
//                         builder: (context, state) {
//                           int activeBadges = 0;
//                           if (state is NotificationsLoadSuccess) {
//                             activeBadges = state.unreadCount;
//                           }

//                           return HomeHeader(
//                             imageUrl: profileImageUrl ?? '',
//                             locationLabel: _isOnline
//                                 ? 'Online & Ready'
//                                 : 'Offline',
//                             notificationCount: activeBadges,
//                             onProfileTap: () => Navigator.pushNamed(
//                               context,
//                               RouteList.profilePage,
//                             ),
//                             onSearchTap: () {},
//                             onLocationTap: () {},
//                             // 🎯 INDUSTRY STANDARD FIX: Await the return value from the Notification screen!
//                             onNotificationTap: () async {
//                               final int? targetTab = await Navigator.pushNamed(
//                                 context,
//                                 RouteList.notificationPage,
//                               ) as int?;

//                               // If the notification screen returned a tab index (like 1 for Active Jobs),
//                               // we immediately trigger the callback to switch the bottom nav!
//                               if (targetTab != null && mounted) {
//                                 widget.onSwitchTab?.call(targetTab);
//                               }
//                             },
//                             onFilterTap: () {},
//                           );
//                         },
//                       ),
//                       AppDimensions.gapM,

//                       // 2. Interactive Status Toggle Banner
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: AppDimensions.paddingM,
//                         ),
//                         child: StatusToggleBanner(
//                           isOnline: _isOnline,
//                           onToggle: (val) => setState(() => _isOnline = val),
//                         ),
//                       ),

//                       AppDimensions.gapL,

//                       // 3. Earnings Summary Card
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: AppDimensions.paddingM,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             HomeSectionHeader(
//                               title: 'This Week\'s Earnings',
//                               onTapAll: () {},
//                             ),
//                             AppDimensions.gapS,
//                             const EarningsSummaryCard(
//                               totalBalance: 'TZS 345,000',
//                               completedJobs: '14',
//                               rating: '4.8 ⭐',
//                               hoursOnline: '28h',
//                             ),
//                           ],
//                         ),
//                       ),

//                       AppDimensions.gapXL,

//                       // 4. New Job Requests
//                       HomeSectionHeader(
//                         title: 'New Job Requests',
//                         onTapAll: () {},
//                       ),
//                       AppDimensions.gapM,
//                       _isOnline
//                           ? Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: AppDimensions.paddingM,
//                               ),
//                               child: Column(
//                                 children: [
//                                   JobRequestCard(
//                                     serviceTitle: 'Deep House Cleaning',
//                                     clientName: 'Sarah M.',
//                                     location: 'Mikocheni B, Dar es Salaam',
//                                     amount: 'TZS 45,000',
//                                     timeAgo: '2 mins ago',
//                                     onAccept: () {},
//                                     onDecline: () {},
//                                   ),
//                                   const SizedBox(
//                                     height: AppDimensions.paddingS,
//                                   ),
//                                   JobRequestCard(
//                                     serviceTitle: 'AC Maintenance',
//                                     clientName: 'Dr. Juma K.',
//                                     location: 'Masaki, Dar es Salaam',
//                                     amount: 'TZS 80,000',
//                                     timeAgo: '10 mins ago',
//                                     onAccept: () {},
//                                     onDecline: () {},
//                                   ),
//                                 ],
//                               ),
//                             )
//                           : Padding(
//                               padding: const EdgeInsets.all(
//                                 AppDimensions.paddingXL,
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   'You are offline. Go online to receive live requests.',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: context.colorScheme.onSurfaceVariant,
//                                   ),
//                                 ),
//                               ),
//                             ),

//                       AppDimensions.gapXXXL,
//                     ],
//                   ),
//                 ),
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

import '../../../core/constants/app_dimensions.dart';
import '../../../core/extensions/build_context_extensions.dart';
import '../../../core/routes/route_list.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/storage/auth_token_manager.dart';
import '../../auth/presentation/cubits/auth/auth_cubit.dart';
import '../../auth/presentation/cubits/auth/auth_state.dart';
import '../../notification/presentation/cubits/notification/notifications_cubit.dart';
import '../../notification/presentation/cubits/notification/notifications_state.dart';
import '../../profile/presentation/cubits/profile/profile_cubit.dart';
import '../../profile/presentation/cubits/profile/profile_state.dart';

import '../widgets/home_header.dart';
import '../widgets/home_section_header.dart';
import '../widgets/status_toggle_banner.dart';
import '../widgets/earnings_summary_card.dart';
import '../widgets/job_request_card.dart';

class HomeDashboardScreen extends StatefulWidget {
  final ValueChanged<int>? onSwitchTab;

  const HomeDashboardScreen({super.key, this.onSwitchTab});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  bool _isOnline = false; // 🎯 Default to offline so we can gate them safely

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _hydrateProviderDashboard();
    });
  }

  Future<void> _hydrateProviderDashboard() async {
    final authState = context.read<AuthCubit>().state;

    if (authState is AuthAuthenticated) {
      final token = await sl<AuthTokenManager>().getAccessToken();
      if (token != null && mounted) {
        context.read<NotificationsCubit>().initLiveNotificationListener(
          userId: authState.user.userId.toString(),
          token: token,
        );
        context.read<NotificationsCubit>().loadNotifications();
        context.read<ProfileCubit>().loadProfile();

        // 🎯 Note: If a backend API returns online status later, set _isOnline here.
      }
    }
  }

  /// 🛡️ DECISION ENGINE: Feature Gating for "Go Online"
  void _handleOnlineToggle(bool requestedState) {
    final authState = context.read<AuthCubit>().state;

    // Safety check - shouldn't happen unless state is corrupted
    if (authState is! AuthAuthenticated) return;

    // If they want to go offline, always allow it.
    if (!requestedState) {
      setState(() => _isOnline = false);
      // Fire API call to backend to update status...
      return;
    }

    // 🚀 THE GATEKEEPER: Prevent Unverified providers from going online
    if (!authState.user.canAcceptInstantJobs) {
      context.showSnackBar(
        'Action Required: You must complete Basic Identity Verification before going online to accept jobs.',
        type: SnackBarType.warning,
      );

      // Guide them directly to the solution
      Navigator.pushNamed(context, RouteList.kycDashboardPage);
      return;
    }

    // Passed KYC! Allow them online.
    setState(() => _isOnline = true);
    // Fire API call to backend to update status...
  }

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<ProfileCubit>().state;
    final authState = context.watch<AuthCubit>().state;

    String? profileImageUrl;
    if (profileState is ProfileLoaded) {
      profileImageUrl = profileState.profile.userBase.profileImage;
    }

    // 🛡️ DYNAMIC BANNER: Show a persistent warning if unverified
    final bool isUnverified =
        authState is AuthAuthenticated && !authState.user.canAcceptInstantJobs;

    return BlocListener<NotificationsCubit, NotificationsState>(
      listenWhen: (previous, current) {
        if (previous is NotificationsLoadSuccess &&
            current is NotificationsLoadSuccess) {
          return current.unreadCount > previous.unreadCount;
        }
        return false;
      },
      listener: (context, state) {},
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: context.colorScheme.surface,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppDimensions.maxDashboardWidth,
              ),
              child: RefreshIndicator(
                onRefresh: _hydrateProviderDashboard,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.paddingM,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Header Bar
                      BlocBuilder<NotificationsCubit, NotificationsState>(
                        builder: (context, state) {
                          int activeBadges = 0;
                          if (state is NotificationsLoadSuccess) {
                            activeBadges = state.unreadCount;
                          }

                          return HomeHeader(
                            imageUrl: profileImageUrl ?? '',
                            locationLabel: _isOnline
                                ? 'Online & Ready'
                                : 'Offline',
                            notificationCount: activeBadges,
                            onProfileTap: () => Navigator.pushNamed(
                              context,
                              RouteList.profilePage,
                            ),
                            onSearchTap: () {},
                            onLocationTap: () {},
                            onNotificationTap: () async {
                              final int? targetTab = await Navigator.pushNamed(
                                context,
                                RouteList.notificationPage,
                              ) as int?;
                              if (targetTab != null && mounted) {
                                widget.onSwitchTab?.call(targetTab);
                              }
                            },
                            onFilterTap: () {},
                          );
                        },
                      ),
                      AppDimensions.gapM,

                      // ⚠️ PERSISTENT KYC WARNING BANNER
                      if (isUnverified)
                        Padding(
                          padding: const EdgeInsets.only(
                            left: AppDimensions.paddingM,
                            right: AppDimensions.paddingM,
                            bottom: AppDimensions.paddingM,
                          ),
                          child: InkWell(
                            onTap: () => Navigator.pushNamed(
                              context,
                              RouteList.kycDashboardPage,
                            ),
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusM,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(
                                AppDimensions.paddingM,
                              ),
                              decoration: BoxDecoration(
                                color: context.colorScheme.errorContainer
                                    .withValues(alpha: 0.7),
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusM,
                                ),
                                border: Border.all(
                                  color: context.colorScheme.error,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.warning_amber_rounded,
                                    color: context.colorScheme.error,
                                  ),
                                  AppDimensions.gapM,
                                  Expanded(
                                    child: Text(
                                      'Identity Verification required. Tap here to complete your profile.',
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(
                                            color: context.colorScheme.error,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 16,
                                    color: context.colorScheme.error,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      // 2. Interactive Status Toggle Banner (Gated!)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingM,
                        ),
                        child: StatusToggleBanner(
                          isOnline: _isOnline,
                          onToggle: _handleOnlineToggle, // 🚀 Uses the new Decision Engine method
                        ),
                      ),

                      AppDimensions.gapL,

                      // 3. Earnings Summary Card
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingM,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HomeSectionHeader(
                              title: 'This Week\'s Earnings',
                              onTapAll: () {},
                            ),
                            AppDimensions.gapS,
                            const EarningsSummaryCard(
                              totalBalance: 'TZS 0',
                              completedJobs: '0',
                              rating: 'New',
                              hoursOnline: '0h',
                            ),
                          ],
                        ),
                      ),

                      AppDimensions.gapXL,

                      // 4. New Job Requests
                      HomeSectionHeader(
                        title: 'New Job Requests',
                        onTapAll: () {},
                      ),
                      AppDimensions.gapM,
                      _isOnline
                          ? const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingM,
                              ),
                              child: Column(
                                children: [
                                  // Live jobs would appear here via WebSocket
                                ],
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(
                                AppDimensions.paddingXL,
                              ),
                              child: Center(
                                child: Text(
                                  'You are offline. Go online to receive live requests.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: context.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),

                      AppDimensions.gapXXXL,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
