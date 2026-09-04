// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../core/constants/app_dimensions.dart';
// import '../../../../core/di/service_locator.dart'; // 🎯 Required for sl() injection
// import '../../../../core/extensions/build_context_extensions.dart';
// import '../../../../core/presentation/widgets/sevika_state_placeholder.dart';
// import '../../../../core/routes/route_list.dart';

// import '../../domain/usecases/params/update_booking_status_params.dart';
// import '../cubits/booking_history/booking_history_cubit.dart';
// import '../cubits/booking_history/booking_history_state.dart';
// import '../../domain/entities/booking_entity.dart';
// import '../../domain/entities/booking_status.dart';

// import '../cubits/manage_job/manage_job_cubit.dart';
// import '../cubits/manage_job/manage_job_state.dart'; // 🎯 Added for BlocListener states
// import '../widgets/provider_job_card.dart';
// import '../widgets/shimmers/booking_job_card_skeleton.dart';

// class BookingDashboardScreen extends StatefulWidget {
//   final int initialTabIndex;

//   const BookingDashboardScreen({super.key, this.initialTabIndex = 0});

//   @override
//   State<BookingDashboardScreen> createState() => _BookingDashboardScreenState();
// }

// class _BookingDashboardScreenState extends State<BookingDashboardScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     // 👨‍🔧 3 Pipeline Stages: Requests (Leads), Active, Completed
//     _tabController = TabController(
//       length: 3,
//       vsync: this,
//       initialIndex: widget.initialTabIndex,
//     );

//     // Fetch initial data on load
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<BookingHistoryCubit>().loadInitialBookings();
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Future<void> _onRefresh() async {
//     await context.read<BookingHistoryCubit>().loadInitialBookings();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // 🎯 BEST PRACTICE: Provide the ManageJobCubit locally to ensure it is always in the context,
//     // and wrap the screen in a BlocListener to reactively update the dashboard when a job is accepted.
//     return BlocProvider<ManageJobCubit>(
//       create: (context) => sl<ManageJobCubit>(),
//       child: BlocListener<ManageJobCubit, ManageJobState>(
//         listener: (context, state) {
//           if (state is ManageJobFailure) {
//             context.showSnackBar(
//               state.error.message ?? 'Failed to accept job.',
//               type: SnackBarType.error,
//             );
//           } else if (state is ManageJobSuccess) {
//             context.showSnackBar(
//               'Job successfully accepted and moved to Active tab!',
//               type: SnackBarType.success,
//             );
//             // 🎯 1. Automatically jump the TabController to the "Active" tab index (1)
//             _tabController.animateTo(1);

//             // 🔄 Automatically refresh the history pipeline when a job is accepted!
//             context.read<BookingHistoryCubit>().loadInitialBookings();
//           }
//         },
//         child: Scaffold(
//           backgroundColor: context.colorScheme.surfaceContainerLowest,
//           appBar: AppBar(
//             title: const Text(
//               'Job Board',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             centerTitle: true,
//             backgroundColor: context.colorScheme.surface,
//             elevation: 0,
//             bottom: TabBar(
//               controller: _tabController,
//               indicatorSize: TabBarIndicatorSize.tab,
//               indicatorWeight: 3,
//               labelColor: context.colorScheme.primary,
//               unselectedLabelColor: context.colorScheme.onSurfaceVariant,
//               labelStyle: const TextStyle(fontWeight: FontWeight.bold),
//               tabs: const [
//                 Tab(text: 'Requests'),
//                 Tab(text: 'Active'),
//                 Tab(text: 'History'),
//               ],
//             ),
//           ),
//           body: BlocBuilder<BookingHistoryCubit, BookingHistoryState>(
//             builder: (context, state) {
//               // ⏳ LOADING STATE
//               if (state is BookingHistoryFirstPageLoading ||
//                   state is BookingHistoryInitial) {
//                 return ListView.builder(
//                   padding: const EdgeInsets.all(AppDimensions.paddingM),
//                   itemCount: 4,
//                   itemBuilder: (_, _) => const BookingJobCardSkeleton(),
//                 );
//               }

//               // ❌ ERROR STATE
//               if (state is BookingHistoryLoadFailure) {
//                 return Center(
//                   child: SevikaStatePlaceholder(
//                     title: 'Sync Failed',
//                     message:
//                         state.error.message ??
//                         'Failed to load your job pipeline.',
//                     icon: Icons.sync_problem_rounded,
//                     actionButtonText: 'Retry',
//                     onActionPressed: _onRefresh,
//                   ),
//                 );
//               }

//               // ✅ SUCCESS STATE
//               if (state is BookingHistoryLoadSuccess) {
//                 // 👨‍🔧 1. NEW REQUESTS (Pending or Awaiting Estimate)
//                 // Note: Quotes also sit here until the provider bids!

//                 // 🔍 DEBUG PRINT: Let's see what statuses Laravel is actually returning!
//                 for (var job in state.bookings) {
//                   debugPrint(
//                     '📋 Booking Ref: ${job.bookingReference} | Status: ${job.status} | Type: ${job.bookingType}',
//                   );
//                 }
//                 final pendingJobs = state.bookings
//                     .where(
//                       (b) =>
//                           b.status == BookingStatus.pending ||
//                           b.status == BookingStatus.awaitingEstimate,
//                     )
//                     .toList();

//                 // 👨‍🔧 2. ACTIVE JOBS (Confirmed, Accepted, En Route, etc)
//                 final activeJobs =
//                     state.bookings
//                         .where(
//                           (b) =>
//                               b.status == BookingStatus.accepted ||
//                               b.status == BookingStatus.confirmed || // 🎯 FIXED: Added 'confirmed' here!
//                               b.status == BookingStatus.enRoute ||
//                               b.status == BookingStatus.ongoing ||
//                               b.status == BookingStatus.quoteProvided ||
//                               b.status == BookingStatus.pendingPayment,
//                         )
//                         .toList();

//                 // 👨‍🔧 3. PAST JOBS (Completed or Cancelled)
//                 final pastJobs = state.bookings
//                     .where(
//                       (b) =>
//                           b.status == BookingStatus.completed ||
//                           b.status == BookingStatus.cancelled,
//                     )
//                     .toList();

//                 return TabBarView(
//                   controller: _tabController,
//                   children: [
//                     _buildJobListView(
//                       jobs: pendingJobs,
//                       emptyTitle: 'No New Requests',
//                       emptyMessage: 'You have no pending job requests at the moment. Stay online to receive leads!',
//                       emptyIcon: Icons.inbox_rounded,
//                     ),
//                     _buildJobListView(
//                       jobs: activeJobs,
//                       emptyTitle: 'No Active Jobs',
//                       emptyMessage: 'You don\'t have any ongoing jobs. Accept new requests to fill your pipeline.',
//                       emptyIcon: Icons.handyman_rounded,
//                     ),
//                     _buildJobListView(
//                       jobs: pastJobs,
//                       emptyTitle: 'No History Yet',
//                       emptyMessage:
//                           'Your completed and cancelled jobs will appear here.',
//                       emptyIcon: Icons.history_rounded,
//                     ),
//                   ],
//                 );
//               }

//               return const SizedBox.shrink();
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   // 🛠️ Helper to render the lists, show empty states, and handle pagination
//   Widget _buildJobListView({
//     required List<BookingEntity> jobs,
//     required String emptyTitle,
//     required String emptyMessage,
//     required IconData emptyIcon,
//   }) {
//     return RefreshIndicator.adaptive(
//       onRefresh: _onRefresh,
//       child: jobs.isEmpty
//           ? SingleChildScrollView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               child: SizedBox(
//                 height: context.screenHeight * 0.6,
//                 child: Center(
//                   child: SevikaStatePlaceholder(
//                     title: emptyTitle,
//                     message: emptyMessage,
//                     icon: emptyIcon,
//                   ),
//                 ),
//               ),
//             )
//           : NotificationListener<ScrollNotification>(
//               onNotification: (ScrollNotification scrollInfo) {
//                 if (scrollInfo.metrics.pixels >=
//                     scrollInfo.metrics.maxScrollExtent - 200) {
//                   context.read<BookingHistoryCubit>().loadNextPage();
//                 }
//                 return false;
//               },
//               child: ListView.builder(
//                 padding: const EdgeInsets.all(AppDimensions.paddingM),
//                 physics: const AlwaysScrollableScrollPhysics(
//                   parent: BouncingScrollPhysics(),
//                 ),
//                 itemCount: jobs.length + 1,
//                 itemBuilder: (context, index) {
//                   if (index == jobs.length) {
//                     final cubitState = context
//                         .watch<BookingHistoryCubit>()
//                         .state;
//                     if (cubitState is BookingHistoryLoadSuccess &&
//                         cubitState.isMoreLoading) {
//                       return const Padding(
//                         padding: EdgeInsets.all(AppDimensions.paddingL),
//                         child: Center(
//                           child: CircularProgressIndicator.adaptive(),
//                         ),
//                       );
//                     }
//                     return const SizedBox.shrink();
//                   }

//                   final booking = jobs[index];
//                   return Padding(
//                     padding: const EdgeInsets.only(
//                       bottom: AppDimensions.paddingM,
//                     ),
//                     child: ProviderJobCard(
//                       booking: booking,
//                       // 🎯 1. FIXED THE TAP BEHAVIOR
//                       onTap: () async {
//                         // Wait until the user presses 'Back' from the detail screen
//                         await Navigator.pushNamed(
//                           context,
//                           RouteList.bookingDetailPage,
//                           arguments: booking,
//                         );

//                         // 🔄 When they return, instantly refresh the dashboard pipeline!
//                         // This moves the completed job to the History tab.
//                         if (context.mounted) {
//                           context
//                               .read<BookingHistoryCubit>()
//                               .loadInitialBookings();
//                         }
//                       },
//                       // 🎯 2. FIXED THE ACCEPT BEHAVIOR
//                       onAccept: () async {
//                         if (booking.bookingType == 'custom_quote') {
//                           // Wait until they submit the quote and return
//                           await Navigator.pushNamed(
//                             context,
//                             RouteList.submitQuotePage,
//                             arguments: booking,
//                           );

//                           // 🔄 Refresh so the quote moves to 'Active'
//                           if (context.mounted) {
//                             context
//                                 .read<BookingHistoryCubit>()
//                                 .loadInitialBookings();
//                           }
//                         } else {
//                           // 🎯 REAL IMPLEMENTATION: Quick-Accept from the Dashboard!
//                           context.showSnackBar(
//                             'Accepting job ${booking.bookingReference}...',
//                             type: SnackBarType.info,
//                           );

//                           // Call the API via ManageJobCubit securely using the provided context
//                           context.read<ManageJobCubit>().updateJobStatus(
//                             UpdateBookingStatusParams(
//                               bookingReference: booking.bookingReference,
//                               status: 'accepted',
//                             ),
//                           );
//                         }
//                       },
//                       onDecline: () {
//                         context.showSnackBar(
//                           'Declined job ${booking.bookingReference}',
//                           type: SnackBarType.warning,
//                         );
//                         // TODO: Connect CancelBookingCubit here when ready
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/di/service_locator.dart'; // 🎯 Required for sl() injection
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/presentation/widgets/sevika_state_placeholder.dart';
import '../../../../core/routes/route_list.dart';

import '../../domain/usecases/params/update_booking_status_params.dart';
import '../cubits/booking_history/booking_history_cubit.dart';
import '../cubits/booking_history/booking_history_state.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/booking_status.dart';

import '../cubits/manage_job/manage_job_cubit.dart';
import '../cubits/manage_job/manage_job_state.dart'; // 🎯 Added for BlocListener states
import '../helpers/provider_booking_action_helper.dart';
import '../widgets/provider_job_card.dart';
import '../widgets/shimmers/booking_job_card_skeleton.dart';

class BookingDashboardScreen extends StatefulWidget {
  final int initialTabIndex;

  const BookingDashboardScreen({super.key, this.initialTabIndex = 0});

  @override
  State<BookingDashboardScreen> createState() => _BookingDashboardScreenState();
}

class _BookingDashboardScreenState extends State<BookingDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 👨‍🔧 3 Pipeline Stages: Requests (Leads), Active, Completed
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );

    // Fetch initial data on load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookingHistoryCubit>().loadInitialBookings();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await context.read<BookingHistoryCubit>().loadInitialBookings();
  }

  // 🛒 THE MARKETPLACE BANNER (OPTION 1: HIGHLY RECOMMENDED)
  Widget _buildMarketplaceBanner(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 🚀 Routes to your newly created Marketplace Screen
        Navigator.pushNamed(context, RouteList.exploreMarketplacePage);
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(
          AppDimensions.paddingM,
          AppDimensions.paddingM,
          AppDimensions.paddingM,
          0, // No bottom margin so it sits nicely above the lists
        ),
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.colorScheme.primary,
              context.colorScheme.primary.withValues(alpha: 0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.primary.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.work_outline_rounded,
              color: context.colorScheme.onPrimary,
              size: 32,
            ),
            AppDimensions.gapM,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find More Work',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Browse open requests and submit bids.',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onPrimary.withValues(
                        alpha: 0.9,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: context.colorScheme.onPrimary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 🎯 BEST PRACTICE: Provide the ManageJobCubit locally to ensure it is always in the context,
    // and wrap the screen in a BlocListener to reactively update the dashboard when a job is accepted.
    return BlocProvider<ManageJobCubit>(
      create: (context) => sl<ManageJobCubit>(),
      child: BlocListener<ManageJobCubit, ManageJobState>(
        listener: (context, state) {
          if (state is ManageJobFailure) {
            context.showSnackBar(
              state.error.message ?? 'Failed to accept job.',
              type: SnackBarType.error,
            );
          } else if (state is ManageJobSuccess) {
            context.showSnackBar(
              'Job successfully accepted and moved to Active tab!',
              type: SnackBarType.success,
            );
            // 🎯 1. Automatically jump the TabController to the "Active" tab index (1)
            _tabController.animateTo(1);

            // 🔄 Automatically refresh the history pipeline when a job is accepted!
            context.read<BookingHistoryCubit>().loadInitialBookings();
          }
        },
        child: Scaffold(
          backgroundColor: context.colorScheme.surfaceContainerLowest,
          appBar: AppBar(
            title: const Text(
              'Job Board',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: context.colorScheme.surface,
            elevation: 0,
            bottom: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              labelColor: context.colorScheme.primary,
              unselectedLabelColor: context.colorScheme.onSurfaceVariant,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: 'Requests'),
                Tab(text: 'Active'),
                Tab(text: 'History'),
              ],
            ),
          ),
          body: BlocBuilder<BookingHistoryCubit, BookingHistoryState>(
            builder: (context, state) {
              // ⏳ LOADING STATE
              if (state is BookingHistoryFirstPageLoading ||
                  state is BookingHistoryInitial) {
                return ListView.builder(
                  padding: const EdgeInsets.all(AppDimensions.paddingM),
                  itemCount: 4,
                  itemBuilder: (_, _) => const BookingJobCardSkeleton(),
                );
              }

              // ❌ ERROR STATE
              if (state is BookingHistoryLoadFailure) {
                return Center(
                  child: SevikaStatePlaceholder(
                    title: 'Sync Failed',
                    message:
                        state.error.message ??
                        'Failed to load your job pipeline.',
                    icon: Icons.sync_problem_rounded,
                    actionButtonText: 'Retry',
                    onActionPressed: _onRefresh,
                  ),
                );
              }

              // ✅ SUCCESS STATE
              if (state is BookingHistoryLoadSuccess) {
                // 👨‍🔧 1. NEW REQUESTS (Pending or Awaiting Estimate)
                final pendingJobs = state.bookings
                    .where(
                      (b) =>
                          b.status == BookingStatus.pending ||
                          b.status == BookingStatus.awaitingEstimate,
                    )
                    .toList();

                // 👨‍🔧 2. ACTIVE JOBS (Confirmed, Accepted, En Route, etc)
                final activeJobs = state.bookings
                    .where(
                      (b) =>
                          b.status == BookingStatus.accepted ||
                          b.status == BookingStatus.confirmed ||
                          b.status == BookingStatus.enRoute ||
                          b.status == BookingStatus.ongoing ||
                          b.status == BookingStatus.quoteProvided ||
                          b.status == BookingStatus.pendingPayment,
                    )
                    .toList();

                // 👨‍🔧 3. PAST JOBS (Completed or Cancelled)
                final pastJobs = state.bookings
                    .where(
                      (b) =>
                          b.status == BookingStatus.completed ||
                          b.status == BookingStatus.cancelled,
                    )
                    .toList();

                // 🎯 INJECT THE BANNER HERE USING A COLUMN
                return Column(
                  children: [
                    // The highly recommended Marketplace Banner!
                    _buildMarketplaceBanner(context),

                    // The Tab Views (Wrapped in Expanded so they fill the rest of the screen)
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildJobListView(
                            jobs: pendingJobs,
                            emptyTitle: 'No New Requests',
                            // 🎯 Updated message to point them to the banner
                            emptyMessage: 'You have no pending 1-on-1 requests right now. Tap the banner above to browse the open marketplace!',
                            emptyIcon: Icons.inbox_rounded,
                          ),
                          _buildJobListView(
                            jobs: activeJobs,
                            emptyTitle: 'No Active Jobs',
                            emptyMessage: 'You don\'t have any ongoing jobs. Accept new requests to fill your pipeline.',
                            emptyIcon: Icons.handyman_rounded,
                          ),
                          _buildJobListView(
                            jobs: pastJobs,
                            emptyTitle: 'No History Yet',
                            emptyMessage: 'Your completed and cancelled jobs will appear here.',
                            emptyIcon: Icons.history_rounded,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  // 🛠️ Helper to render the lists, show empty states, and handle pagination
  Widget _buildJobListView({
    required List<BookingEntity> jobs,
    required String emptyTitle,
    required String emptyMessage,
    required IconData emptyIcon,
  }) {
    return RefreshIndicator.adaptive(
      onRefresh: _onRefresh,
      child: jobs.isEmpty
          ? SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height:
                    context.screenHeight *
                    0.5, // Slightly adjusted for banner height
                child: Center(
                  child: SevikaStatePlaceholder(
                    title: emptyTitle,
                    message: emptyMessage,
                    icon: emptyIcon,
                  ),
                ),
              ),
            )
          : NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent - 200) {
                  context.read<BookingHistoryCubit>().loadNextPage();
                }
                return false;
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                itemCount: jobs.length + 1,
                itemBuilder: (context, index) {
                  if (index == jobs.length) {
                    final cubitState = context
                        .watch<BookingHistoryCubit>()
                        .state;
                    if (cubitState is BookingHistoryLoadSuccess &&
                        cubitState.isMoreLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(AppDimensions.paddingL),
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }

                  final booking = jobs[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppDimensions.paddingM,
                    ),
                    child: ProviderJobCard(
                      booking: booking,
                      // 🎯 1. FIXED THE TAP BEHAVIOR
                      onTap: () async {
                        // Wait until the user presses 'Back' from the detail screen
                        await Navigator.pushNamed(
                          context,
                          RouteList.bookingDetailPage,
                          arguments: booking,
                        );

                        // 🔄 When they return, instantly refresh the dashboard pipeline!
                        if (context.mounted) {
                          context
                              .read<BookingHistoryCubit>()
                              .loadInitialBookings();
                        }
                      },
                      // 🎯 FIXED THE ACCEPT BEHAVIOR
                      onAccept: () async {
                        // 1. 🚀 INTERCEPT MARKETPLACE BIDS
                        if (booking.isAwardedMarketplaceBid) {
                          context.showSnackBar(
                            'Starting travel to client...',
                            type: SnackBarType.info,
                          );

                          // Since the customer already accepted the bid, the next step is traveling!
                          context.read<ManageJobCubit>().updateJobStatus(
                            UpdateBookingStatusParams(
                              bookingReference: booking.bookingReference,
                              status: 'en_route',
                            ),
                          );
                        }
                        // 2. 📝 NORMAL CUSTOM QUOTES
                        else if (booking.bookingType == 'custom_quote' &&
                            booking.status == BookingStatus.awaitingEstimate) {
                          // Wait until they submit the quote and return
                          await Navigator.pushNamed(
                            context,
                            RouteList.submitQuotePage,
                            arguments: booking,
                          );

                          if (context.mounted) {
                            context
                                .read<BookingHistoryCubit>()
                                .loadInitialBookings();
                          }
                        }
                        // 3. ⚡ STANDARD QUICK ACCEPT
                        else {
                          context.showSnackBar(
                            'Accepting job ${booking.bookingReference}...',
                            type: SnackBarType.info,
                          );

                          context.read<ManageJobCubit>().updateJobStatus(
                            UpdateBookingStatusParams(
                              bookingReference: booking.bookingReference,
                              status:
                                  ProviderBookingActionHelper.getNextStatusAction(
                                    booking,
                                  ) ??
                                  'accepted',
                            ),
                          );
                        }
                      },
                      onDecline: () {
                        context.showSnackBar(
                          'Declined job ${booking.bookingReference}',
                          type: SnackBarType.warning,
                        );
                        // Connect CancelBookingCubit here when ready
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
