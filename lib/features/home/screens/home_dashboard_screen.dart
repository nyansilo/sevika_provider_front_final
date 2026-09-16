// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../core/constants/app_dimensions.dart';
// import '../../../core/extensions/build_context_extensions.dart';
// import '../../../core/routes/route_list.dart';
// import '../../../core/di/service_locator.dart';
// import '../../../core/storage/auth_token_manager.dart';

// import '../../auth/presentation/cubits/auth/auth_cubit.dart';
// import '../../auth/presentation/cubits/auth/auth_state.dart';
// import '../../kyc/presentation/cubits/provider_kyc_cubit.dart';
// import '../../kyc/presentation/cubits/provider_kyc_state.dart';
// import '../../notification/presentation/cubits/notification/notifications_cubit.dart';
// import '../../notification/presentation/cubits/notification/notifications_state.dart';
// import '../../profile/presentation/cubits/profile/profile_cubit.dart';
// import '../../profile/presentation/cubits/profile/profile_state.dart';

// // 🛡️ IMPORT KYC RESOURCES
// // We import these to get the LIVE verification status from the server,
// // rather than relying on the cached Auth Token payload which might be stale.
// import '../../kyc/domain/enums/kyc_tier.dart';

// import '../widgets/home_header.dart';
// import '../widgets/home_section_header.dart';
// import '../widgets/status_toggle_banner.dart';
// import '../widgets/earnings_summary_card.dart';

// class HomeDashboardScreen extends StatefulWidget {
//   final ValueChanged<int>? onSwitchTab;

//   const HomeDashboardScreen({super.key, this.onSwitchTab});

//   @override
//   State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
// }

// class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
//   bool _isOnline = false; // 🎯 Default to offline so we can securely gate them

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) _hydrateProviderDashboard();
//     });
//   }

//   /// 🔄 Pre-warms the dashboard by silently fetching all critical data in the background.
//   Future<void> _hydrateProviderDashboard() async {
//     final authState = context.read<AuthCubit>().state;

//     if (authState is AuthAuthenticated) {
//       final token = await sl<AuthTokenManager>().getAccessToken();
//       if (token != null && mounted) {
//         // 1. Initialize WebSockets for live job requests
//         context.read<NotificationsCubit>().initLiveNotificationListener(
//           userId: authState.user.userId.toString(),
//           token: token,
//         );

//         // 2. Fetch Notifications & Profile
//         context.read<NotificationsCubit>().loadNotifications();
//         context.read<ProfileCubit>().loadProfile();

//         // 🚀 3. FETCH LIVE KYC STATUS
//         // This ensures if a backend admin approves them while they are logged in,
//         // the app instantly knows about it and drops the warning banners!
//         context.read<ProviderKycCubit>().fetchKycStatus();

//         // 🎯 Note: If a backend API returns the last known 'online' status later,
//         // set _isOnline here via setState.
//       }
//     }
//   }

//   /// 🛡️ DECISION ENGINE: Feature Gating for the "Go Online" action.
//   /// Prevents unverified providers from interacting with live customers.
//   void _handleOnlineToggle(bool requestedState) {
//     // If they want to go offline, ALWAYS allow it immediately for safety.
//     if (!requestedState) {
//       setState(() => _isOnline = false);
//       // Fire API call to backend to update status...
//       return;
//     }

//     // 🚀 THE GATEKEEPER: Read the LIVE KYC State, not the cached Auth state!
//     final kycState = context.read<ProviderKycCubit>().state;

//     // Check if they are officially 'unverified' by the backend
//     if (kycState is ProviderKycLoaded &&
//         kycState.kycData.kycTier == KycTier.unverified) {
//       context.showSnackBar(
//         'Action Required: You must complete Basic Identity Verification before going online to accept jobs.',
//         type: SnackBarType.warning,
//       );

//       // Guide them directly to the solution to reduce friction
//       Navigator.pushNamed(context, RouteList.kycDashboardPage);
//       return;
//     }

//     // Passed KYC! Allow them to go online.
//     setState(() => _isOnline = true);
//     // Fire API call to backend to register them in the live dispatch pool...
//   }

//   @override
//   Widget build(BuildContext context) {
//     final profileState = context.watch<ProfileCubit>().state;

//     // 🚀 THE FIX: Watch the Kyc Cubit to instantly react to server-side approvals!
//     final kycState = context.watch<ProviderKycCubit>().state;

//     String? profileImageUrl;
//     if (profileState is ProfileLoaded) {
//       profileImageUrl = profileState.profile.userBase.profileImage;
//     }

//     // -----------------------------------------------------------------------------
//     // 1. EVALUATE KYC TIERS FROM THE LIVE API RESPONSE
//     // -----------------------------------------------------------------------------
//     // We default to `false` for both to keep the UI clean while loading.
//     bool isUnverified = false;
//     bool canUpgradeToPro = false;

//     if (kycState is ProviderKycLoaded) {
//       // 🔴 They have not completed basic NIDA/Selfie verification
//       isUnverified = kycState.kycData.kycTier == KycTier.unverified;

//       // 🟣 They completed Tier 1, but haven't provided business documents
//       canUpgradeToPro = kycState.kycData.kycTier == KycTier.basic;

//       // If KycTier.professional, both remain false and no banners show!
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
//         // Future: Show top-down in-app toast for new notifications here
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
//                       // =========================================================
//                       // 1. HEADER BAR
//                       // =========================================================
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
//                             onNotificationTap: () async {
//                               final int? targetTab = await Navigator.pushNamed(
//                                 context,
//                                 RouteList.notificationPage,
//                               ) as int?;
//                               if (targetTab != null && mounted) {
//                                 widget.onSwitchTab?.call(targetTab);
//                               }
//                             },
//                             onFilterTap: () {},
//                           );
//                         },
//                       ),
//                       AppDimensions.gapM,

//                       // =========================================================
//                       // 2. TIER-AWARE CONDITIONAL KYC BANNERS
//                       // =========================================================

//                       // 🔴 STATE 1: CRITICAL ACTION REQUIRED (UNVERIFIED)
//                       if (isUnverified)
//                         Padding(
//                           padding: const EdgeInsets.only(
//                             left: AppDimensions.paddingM,
//                             right: AppDimensions.paddingM,
//                             bottom: AppDimensions.paddingM,
//                           ),
//                           child: InkWell(
//                             onTap: () => Navigator.pushNamed(
//                               context,
//                               RouteList.kycDashboardPage,
//                             ),
//                             borderRadius: BorderRadius.circular(
//                               AppDimensions.radiusM,
//                             ),
//                             child: Container(
//                               padding: const EdgeInsets.all(
//                                 AppDimensions.paddingM,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: context.colorScheme.errorContainer
//                                     .withValues(alpha: 0.7),
//                                 borderRadius: BorderRadius.circular(
//                                   AppDimensions.radiusM,
//                                 ),
//                                 border: Border.all(
//                                   color: context.colorScheme.error,
//                                 ),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.warning_amber_rounded,
//                                     color: context.colorScheme.error,
//                                   ),
//                                   AppDimensions.gapM,
//                                   Expanded(
//                                     child: Text(
//                                       'Identity Verification required. Tap here to start accepting jobs.',
//                                       style: context.textTheme.bodySmall
//                                           ?.copyWith(
//                                             color: context.colorScheme.error,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                     ),
//                                   ),
//                                   Icon(
//                                     Icons.arrow_forward_ios_rounded,
//                                     size: 16,
//                                     color: context.colorScheme.error,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )
//                       // 🟣 STATE 2: GROWTH OPPORTUNITY (BASIC ➔ PRO UPGRADE)
//                       else if (canUpgradeToPro)
//                         Padding(
//                           padding: const EdgeInsets.only(
//                             left: AppDimensions.paddingM,
//                             right: AppDimensions.paddingM,
//                             bottom: AppDimensions.paddingM,
//                           ),
//                           child: InkWell(
//                             onTap: () => Navigator.pushNamed(
//                               context,
//                               RouteList.kycDashboardPage,
//                             ),
//                             borderRadius: BorderRadius.circular(
//                               AppDimensions.radiusM,
//                             ),
//                             child: Container(
//                               padding: const EdgeInsets.all(
//                                 AppDimensions.paddingM,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: context.colorScheme.primaryContainer
//                                     .withValues(alpha: 0.4),
//                                 borderRadius: BorderRadius.circular(
//                                   AppDimensions.radiusM,
//                                 ),
//                                 border: Border.all(
//                                   color: context.colorScheme.primary.withValues(
//                                     alpha: 0.3,
//                                   ),
//                                 ),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.workspace_premium_rounded,
//                                     color: context.colorScheme.primary,
//                                   ),
//                                   AppDimensions.gapM,
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Upgrade to Professional',
//                                           style: context.textTheme.titleSmall
//                                               ?.copyWith(
//                                                 fontWeight: FontWeight.bold,
//                                                 color:
//                                                     context.colorScheme.primary,
//                                               ),
//                                         ),
//                                         AppDimensions.gapVS,
//                                         Text(
//                                           'Upload your business license to unlock high-value custom job bidding.',
//                                           style: context.textTheme.bodySmall
//                                               ?.copyWith(
//                                                 color: context
//                                                     .colorScheme
//                                                     .onSurfaceVariant,
//                                               ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Icon(
//                                     Icons.arrow_forward_ios_rounded,
//                                     size: 14,
//                                     color: context.colorScheme.primary,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),

//                       // 🟢 STATE 3: FULLY VERIFIED (PRO)
//                       // If neither block executes, the dashboard renders completely clean.

//                       // =========================================================
//                       // 3. INTERACTIVE STATUS TOGGLE
//                       // =========================================================
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: AppDimensions.paddingM,
//                         ),
//                         child: StatusToggleBanner(
//                           isOnline: _isOnline,
//                           onToggle: _handleOnlineToggle, // 🚀 Protected by Decision Engine
//                         ),
//                       ),

//                       AppDimensions.gapL,

//                       // =========================================================
//                       // 4. WEEKLY EARNINGS SUMMARY
//                       // =========================================================
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
//                               totalBalance: 'TZS 0',
//                               completedJobs: '0',
//                               rating: 'New',
//                               hoursOnline: '0h',
//                             ),
//                           ],
//                         ),
//                       ),

//                       AppDimensions.gapXL,

//                       // =========================================================
//                       // 5. LIVE JOB REQUESTS PIPELINE
//                       // =========================================================
//                       HomeSectionHeader(
//                         title: 'New Job Requests',
//                         onTapAll: () {},
//                       ),
//                       AppDimensions.gapM,

//                       _isOnline
//                           ? const Padding(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: AppDimensions.paddingM,
//                               ),
//                               child: Column(
//                                 children: [
//                                   // Live job requests from WebSockets will map here
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
import '../../../core/extensions/currency_formatter_extensions.dart';
import '../../../core/routes/route_list.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/storage/auth_token_manager.dart';

import '../../auth/presentation/cubits/auth/auth_cubit.dart';
import '../../auth/presentation/cubits/auth/auth_state.dart';
import '../../kyc/presentation/cubits/provider_kyc_cubit.dart';
import '../../kyc/presentation/cubits/provider_kyc_state.dart';
import '../../notification/presentation/cubits/notification/notifications_cubit.dart';
import '../../notification/presentation/cubits/notification/notifications_state.dart';
import '../../profile/presentation/cubits/profile/profile_cubit.dart';
import '../../profile/presentation/cubits/profile/profile_state.dart';

// 🛡️ IMPORT KYC RESOURCES
// We import these to get the LIVE verification status from the server,
// rather than relying on the cached Auth Token payload which might be stale.
import '../../kyc/domain/enums/kyc_tier.dart';

// 🚀 IMPORT STATUS & ANALYTICS CUBITS (The Holy Grail!)
import '../../profile/presentation/cubits/status/provider_status_cubit.dart';
import '../../profile/presentation/cubits/status/provider_status_state.dart';
import '../../analytics/presentation/cubits/analytics_cubit.dart';
import '../../analytics/presentation/cubits/analytics_state.dart';

import '../widgets/home_header.dart';
import '../widgets/home_section_header.dart';
import '../widgets/status_toggle_banner.dart';
import '../widgets/earnings_summary_card.dart';

class HomeDashboardScreen extends StatefulWidget {
  final ValueChanged<int>? onSwitchTab;

  const HomeDashboardScreen({super.key, this.onSwitchTab});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  bool _isOnline =
      false; // 🎯 Local state for immediate UI feedback (Optimistic UI)

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _hydrateProviderDashboard();
    });
  }

  /// 🔄 Pre-warms the dashboard by silently fetching all critical data in the background.
  Future<void> _hydrateProviderDashboard() async {
    final authState = context.read<AuthCubit>().state;

    if (authState is AuthAuthenticated) {
      // 🚀 1. HYDRATE STATUS TOGGLE
      // Read their last known state from the AuthToken payload
      final bool wasOnline = authState.user.isOnline;
      setState(() => _isOnline = wasOnline);
      context.read<ProviderStatusCubit>().setInitialStatus(wasOnline);

      final token = await sl<AuthTokenManager>().getAccessToken();
      if (token != null && mounted) {
        // 2. Initialize WebSockets for live job requests
        context.read<NotificationsCubit>().initLiveNotificationListener(
          userId: authState.user.userId.toString(),
          token: token,
        );

        // 3. Fetch Notifications & Profile
        context.read<NotificationsCubit>().loadNotifications();
        context.read<ProfileCubit>().loadProfile();

        // 🚀 4. FETCH LIVE KYC STATUS
        context.read<ProviderKycCubit>().fetchKycStatus();

        // 🚀 5. FETCH LIVE PERFORMANCE ANALYTICS
        // This single call hydrates Earnings, Completed Jobs, Rating, and Hours Online!
        context.read<AnalyticsCubit>().loadAnalytics();
      }
    }
  }

  /// 🛡️ DECISION ENGINE: Feature Gating for the "Go Online" action.
  /// Prevents unverified providers from interacting with live customers.
  Future<void> _handleOnlineToggle(bool requestedState) async {
    // 1. If they want to go offline, ALWAYS allow it immediately for safety.
    if (!requestedState) {
      setState(() => _isOnline = false); // Optimistic UI
      context.read<ProviderStatusCubit>().toggleStatus(
        isOnline: false,
      ); // Fire in background
      return;
    }

    // 2. 🚀 THE GATEKEEPER: Read the LIVE KYC State
    final kycState = context.read<ProviderKycCubit>().state;

    // Check if they are officially 'unverified' by the backend
    if (kycState is ProviderKycLoaded &&
        kycState.kycData.kycTier == KycTier.unverified) {
      context.showSnackBar(
        'Action Required: You must complete Basic Identity Verification before going online to accept jobs.',
        type: SnackBarType.warning,
      );

      // Guide them directly to the solution to reduce friction
      Navigator.pushNamed(context, RouteList.kycDashboardPage);
      return;
    }

    // 3. Passed KYC! Call the API to formally register them in the live dispatch pool.
    final success = await context.read<ProviderStatusCubit>().toggleStatus(
      isOnline: true,
    );

    // 🚀 THE FIX: Check if the screen is still open before touching the BuildContext!
    if (!mounted) return;

    if (success) {
      setState(() => _isOnline = true);
      context.showSnackBar(
        'You are now online and visible to clients.',
        type: SnackBarType.success,
      );
    } else {
      final errorMsg =
          context.read<ProviderStatusCubit>().state.error ??
          'Network error. Could not go online.';
      context.showSnackBar(errorMsg, type: SnackBarType.error);
      setState(() => _isOnline = false); // Revert UI if Laravel rejected it
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<ProfileCubit>().state;

    // 🚀 Watch the Kyc Cubit to instantly react to server-side approvals!
    final kycState = context.watch<ProviderKycCubit>().state;

    String? profileImageUrl;
    if (profileState is ProfileLoaded) {
      profileImageUrl = profileState.profile.userBase.profileImage;
    }

    // -----------------------------------------------------------------------------
    // 1. EVALUATE KYC TIERS FROM THE LIVE API RESPONSE
    // -----------------------------------------------------------------------------
    bool isUnverified = false;
    bool canUpgradeToPro = false;

    if (kycState is ProviderKycLoaded) {
      isUnverified = kycState.kycData.kycTier == KycTier.unverified;
      canUpgradeToPro = kycState.kycData.kycTier == KycTier.basic;
    }

    return BlocListener<NotificationsCubit, NotificationsState>(
      listenWhen: (previous, current) {
        if (previous is NotificationsLoadSuccess &&
            current is NotificationsLoadSuccess) {
          return current.unreadCount > previous.unreadCount;
        }
        return false;
      },
      listener: (context, state) {
        // Future: Show top-down in-app toast for new notifications here
      },
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
                      // =========================================================
                      // 1. HEADER BAR
                      // =========================================================
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

                      // =========================================================
                      // 2. TIER-AWARE CONDITIONAL KYC BANNERS
                      // =========================================================
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
                                      'Identity Verification required. Tap here to start accepting jobs.',
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
                        )
                      else if (canUpgradeToPro)
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
                                color: context.colorScheme.primaryContainer
                                    .withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusM,
                                ),
                                border: Border.all(
                                  color: context.colorScheme.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.workspace_premium_rounded,
                                    color: context.colorScheme.primary,
                                  ),
                                  AppDimensions.gapM,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Upgrade to Professional',
                                          style: context.textTheme.titleSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    context.colorScheme.primary,
                                              ),
                                        ),
                                        AppDimensions.gapVS,
                                        Text(
                                          'Upload your business license to unlock high-value custom job bidding.',
                                          style: context.textTheme.bodySmall
                                              ?.copyWith(
                                                color: context
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 14,
                                    color: context.colorScheme.primary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      // =========================================================
                      // 3. INTERACTIVE STATUS TOGGLE
                      // =========================================================
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingM,
                        ),
                        child:
                            BlocBuilder<
                              ProviderStatusCubit,
                              ProviderStatusState
                            >(
                              builder: (context, statusState) {
                                return StatusToggleBanner(
                                  isOnline: _isOnline,
                                  isLoading: statusState.isLoading, // Optional: Pass to widget if it supports spinners
                                  onToggle: _handleOnlineToggle,
                                );
                              },
                            ),
                      ),

                      AppDimensions.gapL,

                      // =========================================================
                      // 4. WEEKLY PERFORMANCE SUMMARY (Powered by AnalyticsCubit!)
                      // =========================================================
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingM,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HomeSectionHeader(
                              // 🚀 THE FIX: Clear labeling to distinguish from Wallet Balance
                              title: 'Gross Earnings (This Week)',

                              // 🚀 THE FIX: Navigate to Earnings Dashboard to match the context
                              onTapAll: () => Navigator.pushNamed(
                                context,
                                RouteList.earningsDashboardPage,
                              ),
                            ),
                            AppDimensions.gapS,

                            // 🚀 THE HOLY GRAIL: Everything cleanly pulled from ONE Cubit!
                            BlocBuilder<AnalyticsCubit, AnalyticsState>(
                              builder: (context, analyticsState) {
                                if (analyticsState is AnalyticsLoadSuccess) {
                                  return EarningsSummaryCard(
                                    totalBalance: analyticsState
                                        .analytics
                                        .totalEarnings
                                        .toTzs(),
                                    completedJobs:
                                        '${analyticsState.analytics.jobsCompleted}',
                                    rating:
                                        analyticsState
                                                .analytics
                                                .customerRating >
                                            0
                                        ? analyticsState
                                              .analytics
                                              .customerRating
                                              .toStringAsFixed(1)
                                        : 'New',

                                    // 🎯 FIXED: Converted the double to a formatted String using your extension!
                                    hoursOnline: analyticsState
                                        .analytics
                                        .hoursOnline
                                        .toHoursDisplay(),
                                  );
                                }

                                // Show placeholder/shimmer while loading
                                return const EarningsSummaryCard(
                                  totalBalance: 'TZS ...',
                                  completedJobs: '...',
                                  rating: '...',
                                  hoursOnline: '...',
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      AppDimensions.gapXL,

                      // =========================================================
                      // 5. LIVE JOB REQUESTS PIPELINE
                      // =========================================================
                      HomeSectionHeader(
                        title: 'New Job Requests',
                        // 🚀 NAVIGATE TO ALL JOB REQUESTS / SWITCH TAB
                        onTapAll: () {
                          // If Jobs is a tab (e.g., index 1), switch to it.
                          // Otherwise, push a named route: Navigator.pushNamed(context, RouteList.jobsPage)
                          if (widget.onSwitchTab != null) {
                            widget.onSwitchTab!(1);
                          }
                        },
                      ),
                      AppDimensions.gapM,

                      _isOnline
                          ? const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingM,
                              ),
                              child: Column(
                                children: [
                                  // Live job requests from WebSockets will map here
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
