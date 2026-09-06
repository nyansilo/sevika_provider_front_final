// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../core/constants/app_dimensions.dart';
// import '../../../../core/extensions/build_context_extensions.dart';
// import '../../../../core/extensions/currency_formatter_extensions.dart';
// import '../../../../core/l10n/arb/app_localizations.dart';
// import '../../../../core/routes/route_list.dart';

// // 🎯 ADDED: Booking Cubit Imports to pull analytics data globally!
// import '../../../booking/domain/entities/booking_status.dart';
// import '../../../booking/presentation/cubits/booking_history/booking_history_cubit.dart';
// import '../../../booking/presentation/cubits/booking_history/booking_history_state.dart';

// import '../../../wallet/presentation/cubits/wallet_cubit.dart'; // 🎯 Wallet Cubit Import
// import '../../../wallet/presentation/cubits/wallet_state.dart'; // 🎯 Wallet State Import

// import '../cubits/profile/profile_cubit.dart';
// import '../cubits/profile/profile_state.dart';
// import '../widgets/profile_header.dart';
// import '../widgets/profile_menu_item.dart';
// import '../widgets/profile_promo_card.dart';
// import '../widgets/profile_quick_actions.dart';
// import '../widgets/profile_section_wrapper.dart';
// import '../widgets/shimmers/profile_header_skeleton.dart';
// import '../widgets/shimmers/profile_promo_card_skeleton.dart';
// import '../widgets/shimmers/profile_quick_actions_skeleton.dart';
// import '../widgets/shimmers/profile_section_skeleton.dart';

// class ProfileDashboardScreen extends StatefulWidget {
//   const ProfileDashboardScreen({super.key});

//   @override
//   State<ProfileDashboardScreen> createState() => _ProfileDashboardScreenState();
// }

// class _ProfileDashboardScreenState extends State<ProfileDashboardScreen> {
//   bool _isCurrentlyVisible = false;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final isCurrent = ModalRoute.of(context)?.isCurrent ?? false;

//     if (isCurrent && !_isCurrentlyVisible) {
//       _isCurrentlyVisible = true;
//       _triggerSilentDataRefresh();
//     } else if (!isCurrent) {
//       _isCurrentlyVisible = false;
//     }
//   }

//   void _triggerSilentDataRefresh() {
//     if (!mounted) return;
//     context.read<ProfileCubit>().loadProfile();
//     context.read<WalletCubit>().fetchWallet();
//     context.read<BookingHistoryCubit>().loadInitialBookings();
//   }

//   Future<void> _handleManualPullToRefresh() async {
//     if (!mounted) return;
//     await Future.wait([
//       context.read<ProfileCubit>().loadProfile(),
//       context.read<WalletCubit>().fetchWallet(),
//       context.read<BookingHistoryCubit>().loadInitialBookings(),
//     ]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final l10n = context.l10n;

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: context.colorScheme.surface,
//       appBar: AppBar(
//         title: const Text(
//           'My Business Profile',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: context.colorScheme.surface,
//         elevation: 0,
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.settings_outlined,
//               color: context.colorScheme.onSurface,
//             ),
//             onPressed: () =>
//                 Navigator.pushNamed(context, RouteList.settingPage),
//           ),
//         ],
//       ),
//       body: BlocListener<ProfileCubit, ProfileState>(
//         listenWhen: (previous, current) => current is ProfileFailure,
//         listener: (context, state) {
//           if (state is ProfileFailure) {
//             context.showSnackBar(
//               state.error.message ?? l10n.unexpectedError,
//               type: SnackBarType.error,
//             );
//           }
//         },
//         child: SafeArea(
//           child: Center(
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(
//                 maxWidth: AppDimensions.maxDashboardWidth,
//               ),
//               child: BlocBuilder<ProfileCubit, ProfileState>(
//                 builder: (context, profileState) {
//                   return RefreshIndicator.adaptive(
//                     onRefresh: _handleManualPullToRefresh,
//                     child: SingleChildScrollView(
//                       padding: const EdgeInsets.all(AppDimensions.paddingM),
//                       physics: const AlwaysScrollableScrollPhysics(
//                         parent: BouncingScrollPhysics(),
//                       ),
//                       child: AnimatedSwitcher(
//                         duration: const Duration(milliseconds: 300),
//                         switchInCurve: Curves.easeInOut,
//                         switchOutCurve: Curves.easeInOut,
//                         child: _getLayoutForProfileState(
//                           context,
//                           profileState,
//                           l10n,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _getLayoutForProfileState(
//     BuildContext context,
//     ProfileState state,
//     AppLocalizations l10n,
//   ) {
//     if (state is ProfileLoaded) {
//       return _buildContentLayout(context, state, l10n);
//     }

//     if (state is ProfileLoading || state is ProfileInitial) {
//       return _buildSkeletonLayout();
//     }

//     if (state is ProfileFailure) {
//       return Center(
//         key: const ValueKey('profile_failure_fallback_view'),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             vertical: AppDimensions.paddingXL,
//           ),
//           child: Column(
//             children: [
//               Text(
//                 l10n.failedToRestoreSession,
//                 style: context.textTheme.bodyMedium,
//               ),
//               const SizedBox(height: AppDimensions.paddingM),
//               ElevatedButton.icon(
//                 onPressed: () => context.read<ProfileCubit>().loadProfile(),
//                 icon: const Icon(Icons.refresh_rounded),
//                 label: Text(l10n.retrySyncProfile),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return const SizedBox.shrink();
//   }

//   Widget _buildSkeletonLayout() {
//     return const Column(
//       key: ValueKey('skeleton_layout_view'),
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ProfileHeaderSkeleton(),
//         AppDimensions.gapM,
//         ProfileQuickActionsSkeleton(),
//         AppDimensions.gapL,
//         ProfileSectionSkeleton(titleWidth: AppDimensions.size80, itemCount: 3),
//         AppDimensions.gapL,
//         ProfileSectionSkeleton(titleWidth: AppDimensions.size110, itemCount: 4),
//         AppDimensions.gapL,
//         ProfilePromoCardSkeleton(),
//         AppDimensions.gapL,
//         ProfileSectionSkeleton(titleWidth: AppDimensions.size56, itemCount: 3),
//         AppDimensions.gapXXL,
//       ],
//     );
//   }

//   Widget _buildContentLayout(
//     BuildContext context,
//     ProfileLoaded profileState,
//     AppLocalizations l10n,
//   ) {
//     final user = profileState.profile.userBase;

//     final String displayedImage = user.profileImage.isNotEmpty
//         ? user.profileImage
//         : 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150';

//     return Column(
//       key: const ValueKey('content_layout_view'),
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ProfileHeader(
//           name: user.name,
//           phone: user.phoneNumber,
//           imageUrl: displayedImage,
//           providerBadge: 'Verified Partner',
//           onTap: () {
//             Navigator.pushNamed(
//               context,
//               RouteList.editProfilePage,
//               arguments: context.read<ProfileCubit>(),
//             );
//           },
//         ),
//         AppDimensions.gapM,

//         // 👨‍🔧 PROVIDER METRICS (Holy Trinity of Gig Work)
//         BlocBuilder<WalletCubit, WalletState>(
//           builder: (context, walletState) {
//             String displayEarnings = '---';
//             if (walletState is WalletLoaded) {
//               displayEarnings = walletState.wallet.availableBalance
//                   .toCompactTzs(symbol: 'TSh');
//             }

//             int completedJobsCount = 0;
//             final bookingState = context.watch<BookingHistoryCubit>().state;

//             if (bookingState is BookingHistoryLoadSuccess) {
//               // 1. Try mapping from Laravel backend summary first
//               completedJobsCount = bookingState.summary?.completedCount ?? 0;

//               // 🛡️ 2. BULLETPROOF FALLBACK: If Laravel didn't send completedCount, count locally!
//               if (completedJobsCount == 0 && bookingState.bookings.isNotEmpty) {
//                 completedJobsCount = bookingState.bookings
//                     .where((job) => job.status == BookingStatus.completed)
//                     .length;
//               }
//             }

//             return ProfileQuickActions(
//               totalCompletedJobs: completedJobsCount, // 🎯 Bulletproof metric
//               averageRating: '4.9',
//               totalEarnings: displayEarnings,
//               onJobsTap: () =>
//                   Navigator.pushNamed(context, RouteList.bookingHistoryPage),
//               onRatingTap: () => Navigator.pushNamed(
//                 context,
//                 RouteList.providerFeedbackPage,
//               ), // 🚀 UPDATED
//               onEarningsTap: () =>
//                   Navigator.pushNamed(context, RouteList.walletDashboardPage),
//             );
//           },
//         ),

//         AppDimensions.gapL,
//         ProfileSectionWrapper(
//           title: 'Business Management',
//           children: [
//             ProfileMenuItem(
//               icon: Icons.design_services_rounded,
//               title: 'My Service Portfolio',
//               onTap: () =>
//                   Navigator.pushNamed(context, RouteList.servicePortfolioPage),
//             ),
//             ProfileMenuItem(
//               icon: Icons.star_border_rounded,
//               title: 'Client Reviews & Reputation',
//               onTap: () => Navigator.pushNamed(
//                 context,
//                 RouteList.providerFeedbackPage,
//               ), // 🚀 UPDATED
//             ),
//             ProfileMenuItem(
//               icon: Icons.insights_rounded,
//               title: 'Performance Analytics',
//               onTap: () {}, // Navigate to analytics dashboard
//             ),
//           ],
//         ),
//         AppDimensions.gapL,

//         // 🎯 THE WALLET & REWARDS INTEGRATION
//         ProfileSectionWrapper(
//           title: 'Wallet & Financials',
//           children: [
//             ProfileMenuItem(
//               icon: Icons.account_balance_wallet_rounded,
//               title: 'My Wallet & Balance',
//               onTap: () =>
//                   Navigator.pushNamed(context, RouteList.walletDashboardPage),
//             ),
//             ProfileMenuItem(
//               icon: Icons.card_giftcard_rounded,
//               title: 'Rewards, Bonuses & Perks',
//               onTap: () =>
//                   Navigator.pushNamed(context, RouteList.rewardsDashboardPage),
//             ),
//             ProfileMenuItem(
//               icon: Icons.account_balance_rounded,
//               title: 'Payout Bank Accounts',
//               onTap: () {},
//             ),
//             ProfileMenuItem(
//               icon: Icons.receipt_long_rounded,
//               title: 'Earnings & Invoices',
//               onTap: () =>
//                   Navigator.pushNamed(context, RouteList.earningsDashboardPage),
//             ),
//           ],
//         ),
//         AppDimensions.gapL,

//         const ProfilePromoCard(),

//         AppDimensions.gapL,
//         ProfileSectionWrapper(
//           title: l10n.support,
//           children: [
//             ProfileMenuItem(
//               icon: Icons.help_outline_rounded,
//               title: 'Partner Help Center',
//               onTap: () =>
//                   Navigator.pushNamed(context, RouteList.helpCenterPage),
//             ),
//             ProfileMenuItem(
//               icon: Icons.shield_rounded,
//               title: 'Provider Insurance & Safety',
//               onTap: () =>
//                   Navigator.pushNamed(context, RouteList.safetyInsurancePage),
//             ),
//             ProfileMenuItem(
//               icon: Icons.info_outline_rounded,
//               title: l10n.legalTerms,
//               onTap: () =>
//                   Navigator.pushNamed(context, RouteList.legalTermsPage),
//             ),
//           ],
//         ),
//         AppDimensions.gapXXL,
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/di/service_locator.dart'; // 🎯 DI Import for sl
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/extensions/currency_formatter_extensions.dart';
import '../../../../core/l10n/arb/app_localizations.dart';
import '../../../../core/routes/route_list.dart';

// 🎯 Booking Cubit Imports to pull analytics data globally!
import '../../../booking/domain/entities/booking_status.dart';
import '../../../booking/presentation/cubits/booking_history/booking_history_cubit.dart';
import '../../../booking/presentation/cubits/booking_history/booking_history_state.dart';

import '../../../wallet/presentation/cubits/wallet_cubit.dart';
import '../../../wallet/presentation/cubits/wallet_state.dart';

// 🎯 ADDED: Reviews Cubit to fetch dynamic average rating!
import '../../../review/presentation/cubits/provider_reviews_cubit.dart';
import '../../../review/presentation/cubits/provider_reviews_state.dart';

import '../cubits/profile/profile_cubit.dart';
import '../cubits/profile/profile_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/profile_promo_card.dart';
import '../widgets/profile_quick_actions.dart';
import '../widgets/profile_section_wrapper.dart';
import '../widgets/shimmers/profile_header_skeleton.dart';
import '../widgets/shimmers/profile_promo_card_skeleton.dart';
import '../widgets/shimmers/profile_quick_actions_skeleton.dart';
import '../widgets/shimmers/profile_section_skeleton.dart';

class ProfileDashboardScreen extends StatefulWidget {
  const ProfileDashboardScreen({super.key});

  @override
  State<ProfileDashboardScreen> createState() => _ProfileDashboardScreenState();
}

class _ProfileDashboardScreenState extends State<ProfileDashboardScreen> {
  bool _isCurrentlyVisible = false;

  // 🚀 Local instance of ProviderReviewsCubit just for the Dashboard
  late final ProviderReviewsCubit _providerReviewsCubit;

  @override
  void initState() {
    super.initState();
    // Retrieve a fresh instance from the Dependency Injector
    _providerReviewsCubit = sl<ProviderReviewsCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isCurrent = ModalRoute.of(context)?.isCurrent ?? false;

    if (isCurrent && !_isCurrentlyVisible) {
      _isCurrentlyVisible = true;
      _triggerSilentDataRefresh();
    } else if (!isCurrent) {
      _isCurrentlyVisible = false;
    }
  }

  @override
  void dispose() {
    // Clean up the local cubit to prevent memory leaks
    _providerReviewsCubit.close();
    super.dispose();
  }

  void _triggerSilentDataRefresh() {
    if (!mounted) return;
    context.read<ProfileCubit>().loadProfile();
    context.read<WalletCubit>().fetchWallet();
    context.read<BookingHistoryCubit>().loadInitialBookings();
    _providerReviewsCubit.loadReviews(); // 🎯 Fetch reviews for dynamic rating
  }

  Future<void> _handleManualPullToRefresh() async {
    if (!mounted) return;
    await Future.wait([
      context.read<ProfileCubit>().loadProfile(),
      context.read<WalletCubit>().fetchWallet(),
      context.read<BookingHistoryCubit>().loadInitialBookings(),
      _providerReviewsCubit.loadReviews(), // 🎯 Refresh rating on pull
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // 🚀 Wrapped the Scaffold in a BlocProvider so the widget tree has access to it
    return BlocProvider.value(
      value: _providerReviewsCubit,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: context.colorScheme.surface,
        appBar: AppBar(
          title: const Text(
            'My Business Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: context.colorScheme.surface,
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings_outlined,
                color: context.colorScheme.onSurface,
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, RouteList.settingPage),
            ),
          ],
        ),
        body: BlocListener<ProfileCubit, ProfileState>(
          listenWhen: (previous, current) => current is ProfileFailure,
          listener: (context, state) {
            if (state is ProfileFailure) {
              context.showSnackBar(
                state.error.message ?? l10n.unexpectedError,
                type: SnackBarType.error,
              );
            }
          },
          child: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppDimensions.maxDashboardWidth,
                ),
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, profileState) {
                    return RefreshIndicator.adaptive(
                      onRefresh: _handleManualPullToRefresh,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(AppDimensions.paddingM),
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          switchInCurve: Curves.easeInOut,
                          switchOutCurve: Curves.easeInOut,
                          child: _getLayoutForProfileState(
                            context,
                            profileState,
                            l10n,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getLayoutForProfileState(
    BuildContext context,
    ProfileState state,
    AppLocalizations l10n,
  ) {
    if (state is ProfileLoaded) {
      return _buildContentLayout(context, state, l10n);
    }

    if (state is ProfileLoading || state is ProfileInitial) {
      return _buildSkeletonLayout();
    }

    if (state is ProfileFailure) {
      return Center(
        key: const ValueKey('profile_failure_fallback_view'),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.paddingXL,
          ),
          child: Column(
            children: [
              Text(
                l10n.failedToRestoreSession,
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: AppDimensions.paddingM),
              ElevatedButton.icon(
                onPressed: () => context.read<ProfileCubit>().loadProfile(),
                icon: const Icon(Icons.refresh_rounded),
                label: Text(l10n.retrySyncProfile),
              ),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildSkeletonLayout() {
    return const Column(
      key: ValueKey('skeleton_layout_view'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileHeaderSkeleton(),
        AppDimensions.gapM,
        ProfileQuickActionsSkeleton(),
        AppDimensions.gapL,
        ProfileSectionSkeleton(titleWidth: AppDimensions.size80, itemCount: 3),
        AppDimensions.gapL,
        ProfileSectionSkeleton(titleWidth: AppDimensions.size110, itemCount: 4),
        AppDimensions.gapL,
        ProfilePromoCardSkeleton(),
        AppDimensions.gapL,
        ProfileSectionSkeleton(titleWidth: AppDimensions.size56, itemCount: 3),
        AppDimensions.gapXXL,
      ],
    );
  }

  Widget _buildContentLayout(
    BuildContext context,
    ProfileLoaded profileState,
    AppLocalizations l10n,
  ) {
    final user = profileState.profile.userBase;

    final String displayedImage = user.profileImage.isNotEmpty
        ? user.profileImage
        : 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150';

    return Column(
      key: const ValueKey('content_layout_view'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileHeader(
          name: user.name,
          phone: user.phoneNumber,
          imageUrl: displayedImage,
          providerBadge: 'Verified Partner',
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteList.editProfilePage,
              arguments: context.read<ProfileCubit>(),
            );
          },
        ),
        AppDimensions.gapM,

        // 👨‍🔧 PROVIDER METRICS (Holy Trinity of Gig Work)
        BlocBuilder<WalletCubit, WalletState>(
          builder: (context, walletState) {
            // 🚀 INJECTED: Read the Provider Reviews State dynamically
            return BlocBuilder<ProviderReviewsCubit, ProviderReviewsState>(
              builder: (context, reviewsState) {
                // 1. EARNINGS
                String displayEarnings = '---';
                if (walletState is WalletLoaded) {
                  displayEarnings = walletState.wallet.availableBalance
                      .toCompactTzs(symbol: 'TSh');
                }

                // 2. COMPLETED JOBS
                int completedJobsCount = 0;
                final bookingState = context.watch<BookingHistoryCubit>().state;

                if (bookingState is BookingHistoryLoadSuccess) {
                  completedJobsCount =
                      bookingState.summary?.completedCount ?? 0;
                  if (completedJobsCount == 0 &&
                      bookingState.bookings.isNotEmpty) {
                    completedJobsCount = bookingState.bookings
                        .where((job) => job.status == BookingStatus.completed)
                        .length;
                  }
                }

                // 3. 🎯 DYNAMIC RATING
                String dynamicRating = 'New';
                if (reviewsState is ProviderReviewsLoadSuccess) {
                  dynamicRating = reviewsState.metrics.averageRating > 0
                      ? reviewsState.metrics.averageRating.toStringAsFixed(1)
                      : 'New';
                }

                return ProfileQuickActions(
                  totalCompletedJobs: completedJobsCount,
                  averageRating: dynamicRating, // 🎯 Fed dynamic data here!
                  totalEarnings: displayEarnings,
                  onJobsTap: () => Navigator.pushNamed(
                    context,
                    RouteList.bookingHistoryPage,
                  ),
                  onRatingTap: () => Navigator.pushNamed(
                    context,
                    RouteList.providerFeedbackPage,
                  ),
                  onEarningsTap: () => Navigator.pushNamed(
                    context,
                    RouteList.walletDashboardPage,
                  ),
                );
              },
            );
          },
        ),

        AppDimensions.gapL,
        ProfileSectionWrapper(
          title: 'Business Management',
          children: [
            ProfileMenuItem(
              icon: Icons.design_services_rounded,
              title: 'My Service Portfolio',
              onTap: () =>
                  Navigator.pushNamed(context, RouteList.servicePortfolioPage),
            ),
            ProfileMenuItem(
              icon: Icons.star_border_rounded,
              title: 'Client Reviews & Reputation',
              onTap: () =>
                  Navigator.pushNamed(context, RouteList.providerFeedbackPage),
            ),
            ProfileMenuItem(
              icon: Icons.insights_rounded,
              title: 'Performance Analytics',
              onTap: () {}, // Navigate to analytics dashboard
            ),
          ],
        ),
        AppDimensions.gapL,

        ProfileSectionWrapper(
          title: 'Wallet & Financials',
          children: [
            ProfileMenuItem(
              icon: Icons.account_balance_wallet_rounded,
              title: 'My Wallet & Balance',
              onTap: () =>
                  Navigator.pushNamed(context, RouteList.walletDashboardPage),
            ),
            ProfileMenuItem(
              icon: Icons.card_giftcard_rounded,
              title: 'Rewards, Bonuses & Perks',
              onTap: () =>
                  Navigator.pushNamed(context, RouteList.rewardsDashboardPage),
            ),
            ProfileMenuItem(
              icon: Icons.account_balance_rounded,
              title: 'Payout Bank Accounts',
              onTap: () {},
            ),
            ProfileMenuItem(
              icon: Icons.receipt_long_rounded,
              title: 'Earnings & Invoices',
              onTap: () =>
                  Navigator.pushNamed(context, RouteList.earningsDashboardPage),
            ),
          ],
        ),
        AppDimensions.gapL,

        const ProfilePromoCard(),

        AppDimensions.gapL,
        ProfileSectionWrapper(
          title: l10n.support,
          children: [
            ProfileMenuItem(
              icon: Icons.help_outline_rounded,
              title: 'Partner Help Center',
              onTap: () =>
                  Navigator.pushNamed(context, RouteList.helpCenterPage),
            ),
            ProfileMenuItem(
              icon: Icons.shield_rounded,
              title: 'Provider Insurance & Safety',
              onTap: () =>
                  Navigator.pushNamed(context, RouteList.safetyInsurancePage),
            ),
            ProfileMenuItem(
              icon: Icons.info_outline_rounded,
              title: l10n.legalTerms,
              onTap: () =>
                  Navigator.pushNamed(context, RouteList.legalTermsPage),
            ),
          ],
        ),
        AppDimensions.gapXXL,
      ],
    );
  }
}
