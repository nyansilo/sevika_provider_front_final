import 'package:flutter/material.dart';

import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/global/presentation/widgets/shimmer_block.dart';

class ProfilePromoCardSkeleton extends StatelessWidget {
  const ProfilePromoCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(
          color: context.colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBlock(
                  width: AppDimensions.size200,
                  height: AppDimensions.size20,
                ),
                SizedBox(height: AppDimensions.radiusXS),
                ShimmerBlock(
                  width: double.infinity,
                  height: AppDimensions.size12,
                ),
                SizedBox(height: AppDimensions.size4),
                ShimmerBlock(
                  width: AppDimensions.size140,
                  height: AppDimensions.size12,
                ),
              ],
            ),
          ),
          AppDimensions.gapM,
          ShimmerBlock(
            width: AppDimensions.size96,
            height: AppDimensions.size36,
          ),
        ],
      ),
    );
  }
}
