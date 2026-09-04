import 'package:flutter/material.dart';

import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/presentation/widgets/shimmer_block.dart';

class ProfileQuickActionsSkeleton extends StatelessWidget {
  const ProfileQuickActionsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              right: index < 2 ? AppDimensions.paddingS : 0.0,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.paddingM,
            ),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppDimensions.radiusL),
              border: Border.all(
                color: context.colorScheme.outlineVariant.withValues(
                  alpha: 0.3,
                ),
              ),
            ),
            child: const Column(
              children: [
                ShimmerBlock.circle(size: AppDimensions.iconM),
                AppDimensions.gapVS,
                ShimmerBlock(
                  width: AppDimensions.size64,
                  height: AppDimensions.size14,
                ),
                AppDimensions.gapVXS,
                ShimmerBlock(
                  width: AppDimensions.size40,
                  height: AppDimensions.size12,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
