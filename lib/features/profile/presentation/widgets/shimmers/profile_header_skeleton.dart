import 'package:flutter/material.dart';
import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/presentation/widgets/shimmer_block.dart';

class ProfileHeaderSkeleton extends StatelessWidget {
  const ProfileHeaderSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        border: Border.all(
          color: context.colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          ShimmerBlock.circle(size: AppDimensions.avatarL),
          AppDimensions.gapM,
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBlock(
                  width: AppDimensions.size140,
                  height: AppDimensions.size20,
                ),
                SizedBox(height: AppDimensions.radiusXS),
                ShimmerBlock(
                  width: AppDimensions.size96,
                  height: AppDimensions.size14,
                ),
                SizedBox(height: AppDimensions.radiusS),
                ShimmerBlock(
                  width: AppDimensions.size80,
                  height: AppDimensions.size20,
                ),
              ],
            ),
          ),
          ShimmerBlock.circle(size: AppDimensions.iconL),
        ],
      ),
    );
  }
}
