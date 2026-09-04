import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';

class ProfileQuickActions extends StatelessWidget {
  final int totalCompletedJobs;
  final String averageRating;
  final String totalEarnings;
  final VoidCallback? onJobsTap;
  final VoidCallback? onRatingTap;
  final VoidCallback? onEarningsTap;

  const ProfileQuickActions({
    super.key,
    required this.totalCompletedJobs,
    required this.averageRating,
    required this.totalEarnings,
    this.onJobsTap,
    this.onRatingTap,
    this.onEarningsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildActionItem(
          context: context,
          icon: Icons.task_alt_rounded,
          label: 'Completed',
          value: '$totalCompletedJobs Jobs',
          onTap: onJobsTap ?? () {},
        ),
        AppDimensions.gapS,
        _buildActionItem(
          context: context,
          icon: Icons.star_rounded,
          iconColor: Colors.amber.shade600,
          label: 'Rating',
          value: averageRating,
          onTap: onRatingTap ?? () {},
        ),
        AppDimensions.gapS,
        _buildActionItem(
          context: context,
          icon: Icons.account_balance_wallet_rounded,
          label: 'Earnings',
          value: totalEarnings,
          onTap: onEarningsTap ?? () {},
        ),
      ],
    );
  }

  Widget _buildActionItem({
    required BuildContext context,
    required IconData icon,
    Color? iconColor,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            border: Border.all(
              color: context.colorScheme.outlineVariant.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: iconColor ?? context.colorScheme.primary,
                size: AppDimensions.iconM,
              ),
              const SizedBox(height: 6),
              Text(
                value, // Value emphasized over label for metrics
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.outline,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
