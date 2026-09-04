import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';

class ProfilePromoCard extends StatelessWidget {
  const ProfilePromoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colorScheme.secondary,
            context.colorScheme.secondaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Grow Your Business',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.onSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppDimensions.radiusXS),
                Text(
                  'Share your custom profile link to get direct bookings from social media.',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSecondary.withValues(
                      alpha: 0.85,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppDimensions.gapM,
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colorScheme.onSecondary,
              foregroundColor: context.colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingM,
              ),
            ),
            onPressed: () {
              // Trigger Native Share Dialog
              context.showSnackBar(
                'Generating your custom link...',
                type: SnackBarType.info,
              );
            },
            icon: const Icon(Icons.share_rounded, size: 18),
            label: const Text('Share'),
          ),
        ],
      ),
    );
  }
}
