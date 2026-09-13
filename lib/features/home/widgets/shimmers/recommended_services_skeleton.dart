import 'package:flutter/material.dart';

import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/global/presentation/widgets/shimmer_block.dart';

class RecommendedServicesSkeleton extends StatelessWidget {
  final int itemCount;

  const RecommendedServicesSkeleton({super.key, this.itemCount = 2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Container(
            height: AppDimensions.size120,
            margin: const EdgeInsets.only(bottom: AppDimensions.paddingM),
            decoration: BoxDecoration(
              // FIX 1: Alter parent backdrop background so child shimmers stand out cleanly
              color: context.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppDimensions.radiusL),
              border: Border.all(
                color: context.colorScheme.outlineVariant.withValues(
                  alpha: 0.3, // Subtle border wrapper lines
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radiusL),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. LEFT SIDE: Full-bleed Image Loading Area (30% width)
                  const Expanded(flex: 3, child: ShimmerBlock()),

                  // 2. RIGHT SIDE: Core Content Blocks (70% width)
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppDimensions.paddingM,
                        AppDimensions.paddingM,
                        AppDimensions.paddingM,
                        AppDimensions.paddingS,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // ROW 1: Category Pill & Duration
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ShimmerBlock(
                                width: AppDimensions.size65,
                                height: AppDimensions.size22,
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusS,
                                ),
                              ),
                              ShimmerBlock(
                                width: AppDimensions.size35,
                                height: AppDimensions.size14,
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusXS,
                                ),
                              ),
                            ],
                          ),

                          // ROW 2: Service Title Line
                          ShimmerBlock(
                            width: AppDimensions.size160,
                            height: AppDimensions.size20,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusXS,
                            ),
                          ),

                          // ROW 3: Price Field & Plus Action Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ShimmerBlock(
                                width: AppDimensions.size80,
                                height: AppDimensions.size18,
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusXS,
                                ),
                              ),
                              ShimmerBlock(
                                width: AppDimensions.size40,
                                height: AppDimensions.size40,
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusM,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
