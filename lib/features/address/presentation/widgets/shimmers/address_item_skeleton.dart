import 'package:flutter/material.dart';

import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/presentation/widgets/shimmer_block.dart';
// Import your new utility widget

class AddressItemSkeleton extends StatelessWidget {
  const AddressItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: context.colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Leading Icon Shimmer Circle
          ShimmerBlock.circle(size: AppDimensions.iconL * 1.5),
          AppDimensions.gapM,

          // 2. Center Text Lines Block Layout
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Label Title Line
                    ShimmerBlock(
                      width: 80,
                      height: 16,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusS,
                      ),
                    ),
                    AppDimensions.gapS,

                    // Optional default address badge
                    ShimmerBlock(
                      width: 50,
                      height: 14,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusS,
                      ),
                    ),
                  ],
                ),
                AppDimensions.gapS,

                // Street Address Line
                ShimmerBlock(
                  width: double.infinity,
                  height: 14,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                ),
                AppDimensions.gapXS,

                // City / Region Line
                ShimmerBlock(
                  width: 120,
                  height: 14,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                ),
              ],
            ),
          ),
          AppDimensions.gapM,

          // 3. Trailing Action Control Menu Indicator
          const ShimmerBlock.circle(size: AppDimensions.iconM),
        ],
      ),
    );
  }
}
