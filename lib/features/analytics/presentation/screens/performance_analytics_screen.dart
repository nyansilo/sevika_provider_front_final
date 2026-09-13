// import 'package:flutter/material.dart';

// import '../../../../core/constants/app_dimensions.dart';
// import '../../../../core/extensions/build_context_extensions.dart';

// class PerformanceAnalyticsScreen extends StatelessWidget {
//   const PerformanceAnalyticsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.colorScheme.surface,
//       appBar: AppBar(
//         title: const Text('Performance Analytics'),
//         centerTitle: true,
//         backgroundColor: context.colorScheme.surface,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(AppDimensions.paddingM),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 📅 DATE FILTER
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Overview',
//                   style: context.textTheme.titleMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 DropdownButton<String>(
//                   value: 'This Month',
//                   underline: const SizedBox(),
//                   icon: Icon(
//                     Icons.keyboard_arrow_down,
//                     color: context.colorScheme.primary,
//                   ),
//                   style: TextStyle(
//                     color: context.colorScheme.primary,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   items: ['This Week', 'This Month', 'This Year', 'All Time']
//                       .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                       .toList(),
//                   onChanged: (val) {
//                     // TODO: Trigger Cubit to fetch data for specific timeframe
//                   },
//                 ),
//               ],
//             ),
//             AppDimensions.gapM,

//             // 📊 STATS GRID
//             GridView.count(
//               crossAxisCount: 2,
//               crossAxisSpacing: AppDimensions.paddingM,
//               mainAxisSpacing: AppDimensions.paddingM,
//               shrinkWrap: true,
//               childAspectRatio: 1.2,
//               physics: const NeverScrollableScrollPhysics(),
//               children: [
//                 _buildStatCard(
//                   context,
//                   title: 'Total Earnings',
//                   value: 'TZS 850K',
//                   icon: Icons.account_balance_wallet_outlined,
//                   color: Colors.green,
//                   trend: '+12%',
//                   isPositive: true,
//                 ),
//                 _buildStatCard(
//                   context,
//                   title: 'Jobs Completed',
//                   value: '42',
//                   icon: Icons.task_alt,
//                   color: context.colorScheme.primary,
//                   trend: '+5',
//                   isPositive: true,
//                 ),
//                 _buildStatCard(
//                   context,
//                   title: 'Profile Views',
//                   value: '128',
//                   icon: Icons.visibility_outlined,
//                   color: Colors.blue,
//                   trend: '+24%',
//                   isPositive: true,
//                 ),
//                 _buildStatCard(
//                   context,
//                   title: 'Cancellation Rate',
//                   value: '4.5%',
//                   icon: Icons.cancel_outlined,
//                   color: context.colorScheme.error,
//                   trend: '-1.2%', // Decrease in cancellation is good
//                   isPositive: true,
//                 ),
//               ],
//             ),
//             AppDimensions.gapXXL,

//             // ⭐ QUALITY METRICS
//             Text(
//               'Quality Metrics',
//               style: context.textTheme.titleMedium?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             AppDimensions.gapM,

//             _buildQualityMetricRow(
//               context,
//               title: 'Customer Rating',
//               value: '4.8 / 5.0',
//               progress: 0.96,
//               color: Colors.orange,
//             ),
//             AppDimensions.gapM,

//             _buildQualityMetricRow(
//               context,
//               title: 'Response Rate',
//               value: '95%',
//               progress: 0.95,
//               color: context.colorScheme.primary,
//             ),
//             AppDimensions.gapM,

//             _buildQualityMetricRow(
//               context,
//               title: 'On-Time Arrival',
//               value: '88%',
//               progress: 0.88,
//               color: Colors.teal,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Helper method to build the square metric cards
//   Widget _buildStatCard(
//     BuildContext context, {
//     required String title,
//     required String value,
//     required IconData icon,
//     required Color color,
//     required String trend,
//     required bool isPositive,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(AppDimensions.paddingM),
//       decoration: BoxDecoration(
//         color: context.colorScheme.surfaceContainerLowest,
//         borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//         border: Border.all(
//           color: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: context.colorScheme.shadow.withValues(alpha: 0.02),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Icon(icon, color: color, size: 24),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                 decoration: BoxDecoration(
//                   color: (isPositive ? Colors.green : context.colorScheme.error)
//                       .withValues(alpha: 0.1),
//                   borderRadius: BorderRadius.circular(AppDimensions.radiusS),
//                 ),
//                 child: Text(
//                   trend,
//                   style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.bold,
//                     color: isPositive
//                         ? Colors.green
//                         : context.colorScheme.error,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 value,
//                 style: context.textTheme.headlineSmall?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: context.colorScheme.onSurface,
//                 ),
//               ),
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: context.colorScheme.onSurfaceVariant,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper method to build progress bar metrics
//   Widget _buildQualityMetricRow(
//     BuildContext context, {
//     required String title,
//     required String value,
//     required double progress,
//     required Color color,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: context.colorScheme.onSurface,
//               ),
//             ),
//             Text(
//               value,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: context.colorScheme.onSurface,
//               ),
//             ),
//           ],
//         ),
//         AppDimensions.gapXS,
//         ClipRRect(
//           borderRadius: BorderRadius.circular(AppDimensions.radiusS),
//           child: LinearProgressIndicator(
//             value: progress,
//             backgroundColor: color.withValues(alpha: 0.1),
//             valueColor: AlwaysStoppedAnimation<Color>(color),
//             minHeight: 8,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
// 🚀 ADDED: Import your custom global state widgets
import '../../../../core/global/presentation/widgets/sevika_state_placeholder.dart';

import '../../args/analytics_args.dart';
import '../cubits/analytics_cubit.dart';
import '../cubits/analytics_state.dart';
import '../widgets/analytics_header_filter.dart';
import '../widgets/analytics_quality_metrics.dart';
import '../widgets/analytics_stats_grid.dart';

class PerformanceAnalyticsScreen extends StatefulWidget {
  final AnalyticsArgs? args;

  const PerformanceAnalyticsScreen({super.key, this.args});

  @override
  State<PerformanceAnalyticsScreen> createState() =>
      _PerformanceAnalyticsScreenState();
}

class _PerformanceAnalyticsScreenState
    extends State<PerformanceAnalyticsScreen> {
  late String _selectedTimeframe;

  @override
  void initState() {
    super.initState();
    _selectedTimeframe = widget.args?.initialTimeframe ?? 'thisMonth';

    // Automatically fetch metrics when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AnalyticsCubit>().loadAnalytics(
        timeframe: _selectedTimeframe,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Performance Analytics'),
        centerTitle: true,
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
      ),
      body: BlocBuilder<AnalyticsCubit, AnalyticsState>(
        builder: (context, state) {
          if (state is AnalyticsLoading || state is AnalyticsInitial) {
            // Using standard adaptive indicator for non-blocking initial load
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state is AnalyticsLoadFailure) {
            // 🚀 CLEAN ARCHITECTURE: Replaced manual layout with your SevikaStatePlaceholder
            return Center(
              child: SevikaStatePlaceholder(
                title: 'Failed to Load Analytics',
                message:
                    state.error.message ??
                    'An unexpected error occurred. Please try again.',
                icon: Icons.analytics_outlined,
                iconColor: context.colorScheme.error,
                iconBackgroundColor: context.colorScheme.errorContainer
                    .withValues(alpha: 0.3),
                actionButtonText: 'Retry',
                actionButtonIcon: Icons.refresh_rounded,
                onActionPressed: () {
                  context.read<AnalyticsCubit>().loadAnalytics(
                    timeframe: _selectedTimeframe,
                  );
                },
              ),
            );
          }

          if (state is AnalyticsLoadSuccess) {
            final analytics = state.analytics;

            return RefreshIndicator(
              onRefresh: () async {
                await context.read<AnalyticsCubit>().loadAnalytics(
                  timeframe: _selectedTimeframe,
                );
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 📅 TIME FRAME FILTER HEADER
                    AnalyticsHeaderFilter(
                      selectedTimeframe: _selectedTimeframe,
                      onTimeframeChanged: (val) {
                        if (val != null && val != _selectedTimeframe) {
                          setState(() => _selectedTimeframe = val);
                          context.read<AnalyticsCubit>().loadAnalytics(
                            timeframe: val,
                          );
                        }
                      },
                    ),
                    AppDimensions.gapM,

                    // 📊 STATS GRID CARDS (Now powered by your CurrencyExtensions)
                    AnalyticsStatsGrid(analytics: analytics),
                    AppDimensions.gapXXL,

                    // ⭐ QUALITY METRICS PROGRESS BARS
                    AnalyticsQualityMetrics(analytics: analytics),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
