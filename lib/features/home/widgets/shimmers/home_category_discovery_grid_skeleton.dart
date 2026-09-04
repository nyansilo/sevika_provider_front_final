import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/presentation/widgets/shimmer_block.dart';

class HomeCategoryDiscoveryGridSkeleton extends StatelessWidget {
  final int itemCount;

  const HomeCategoryDiscoveryGridSkeleton({
    super.key,
    this.itemCount =
        8, // Default matches the standard 8 category item slots (2 layout rows)
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets
          .zero, // Erases parent framework list viewport padding offsets
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: AppDimensions.paddingS,
        // RECTIFIED: Reduced row-to-row distance by changing mainAxisSpacing from paddingM to paddingS
        mainAxisSpacing: AppDimensions.paddingXXS,
        childAspectRatio:
            0.85, // Symmetrical structural match to prevent view jump shifts
      ),
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Icon Backing Box Container Shimmer
            const ShimmerBlock(
              width: AppDimensions
                  .size56, // Combines icon constraint size + internal padding bounds
              height: AppDimensions.size56,
              borderRadius: BorderRadius.all(
                Radius.circular(AppDimensions.radiusL),
              ),
            ),

            // PRESERVED UNCHANGED: Keeps the exact same distance between the icon and category name
            AppDimensions.gapXS,

            // 2. Category Label Text Line Shimmer
            ShimmerBlock(
              width: AppDimensions.size50,
              height: AppDimensions
                  .size12, // Corresponds directly to context.textTheme.bodySmall font height metrics
              borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
            ),
          ],
        );
      },
    );
  }
}
