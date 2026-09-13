import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';

import '../../../../core/extensions/currency_formatter_extensions.dart';
import '../../domain/entities/provider_analytics_entity.dart';

class AnalyticsStatsGrid extends StatelessWidget {
  final ProviderAnalyticsEntity analytics;

  const AnalyticsStatsGrid({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: AppDimensions.paddingM,
      mainAxisSpacing: AppDimensions.paddingM,
      shrinkWrap: true,
      childAspectRatio: 1.2,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildStatCard(
          context,
          title: 'Total Earnings',
          // 🚀 CLEAN ARCHITECTURE: Uses your robust CurrencyExtension for compact UI math!
          value: analytics.totalEarnings.toCompactTzs(symbol: 'TZS'),
          icon: Icons.account_balance_wallet_outlined,
          color: Colors.green,
          trend: analytics.trends.earnings,
          isPositive: !analytics.trends.earnings.startsWith('-'),
        ),
        _buildStatCard(
          context,
          title: 'Jobs Completed',
          value: analytics.jobsCompleted.toString(),
          icon: Icons.task_alt,
          color: context.colorScheme.primary,
          trend: analytics.trends.jobs,
          isPositive: !analytics.trends.jobs.startsWith('-'),
        ),
        _buildStatCard(
          context,
          title: 'Profile Views',
          value: analytics.profileViews.toString(),
          icon: Icons.visibility_outlined,
          color: Colors.blue,
          trend: analytics.trends.views,
          isPositive: !analytics.trends.views.startsWith('-'),
        ),
        _buildStatCard(
          context,
          title: 'Cancellation Rate',
          value: '${analytics.cancellationRate}%',
          icon: Icons.cancel_outlined,
          color: context.colorScheme.error,
          trend: analytics.trends.cancellationRate,
          // Lower cancellation rate is better (positive)
          isPositive:
              analytics.trends.cancellationRate.startsWith('-') ||
              analytics.trends.cancellationRate == '0%',
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required String trend,
    required bool isPositive,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: (isPositive ? Colors.green : context.colorScheme.error)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                ),
                child: Text(
                  trend,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isPositive
                        ? Colors.green
                        : context.colorScheme.error,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
