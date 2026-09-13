import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../domain/entities/provider_analytics_entity.dart';

class AnalyticsQualityMetrics extends StatelessWidget {
  final ProviderAnalyticsEntity analytics;

  const AnalyticsQualityMetrics({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quality Metrics',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        AppDimensions.gapM,
        _buildQualityMetricRow(
          context,
          title: 'Customer Rating',
          value: '${analytics.customerRating.toStringAsFixed(1)} / 5.0',
          progress: analytics.customerRating / 5.0,
          color: Colors.orange,
        ),
        AppDimensions.gapM,
        _buildQualityMetricRow(
          context,
          title: 'Response Rate',
          value: '${analytics.responseRate.toStringAsFixed(0)}%',
          progress: analytics.responseRate / 100.0,
          color: context.colorScheme.primary,
        ),
        AppDimensions.gapM,
        _buildQualityMetricRow(
          context,
          title: 'On-Time Arrival',
          value: '${analytics.onTimeArrival.toStringAsFixed(0)}%',
          progress: analytics.onTimeArrival / 100.0,
          color: Colors.teal,
        ),
      ],
    );
  }

  Widget _buildQualityMetricRow(
    BuildContext context, {
    required String title,
    required String value,
    required double progress,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: context.colorScheme.onSurface,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        AppDimensions.gapXS,
        ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: color.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}
