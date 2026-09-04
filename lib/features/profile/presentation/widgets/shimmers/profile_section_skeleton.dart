import 'package:flutter/material.dart';
import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/presentation/widgets/shimmer_block.dart';

class ProfileSectionSkeleton extends StatelessWidget {
  final double titleWidth;
  final int itemCount;

  const ProfileSectionSkeleton({
    super.key,
    required this.titleWidth,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppDimensions.paddingS,
            bottom: AppDimensions.paddingS,
          ),
          child: ShimmerBlock(width: titleWidth, height: AppDimensions.size14),
        ),
        Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            border: Border.all(
              color: context.colorScheme.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(itemCount, (index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingM,
                      vertical: AppDimensions.paddingM,
                    ),
                    child: Row(
                      children: [
                        ShimmerBlock.circle(size: AppDimensions.iconM),
                        AppDimensions.gapM,
                        const Expanded(
                          child: ShimmerBlock(
                            width: AppDimensions.size160,
                            height: AppDimensions.size16,
                          ),
                        ),
                        ShimmerBlock.circle(size: AppDimensions.iconM),
                      ],
                    ),
                  ),
                  if (index < itemCount - 1)
                    Divider(
                      height: AppDimensions.borderWidthThin,
                      indent: AppDimensions.size56,
                      color: context.colorScheme.outlineVariant.withValues(
                        alpha: 0.3,
                      ),
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
