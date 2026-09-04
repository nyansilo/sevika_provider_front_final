// import 'package:flutter/material.dart';
// import '../../../../../core/widgets/shimmer_block.dart';
// import '../../../../../core/constants/app_dimensions.dart';

// class PopularServicesSkeleton extends StatelessWidget {
//   const PopularServicesSkeleton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
//       child: GridView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: AppDimensions.paddingM,
//           mainAxisSpacing: AppDimensions.paddingM,
//           childAspectRatio: 0.82,
//         ),
//         itemCount: 4,
//         itemBuilder: (context, index) {
//           return Container(
//             decoration: const BoxDecoration(),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: ShimmerBlock(
//                     width: double.infinity,
//                     borderRadius: BorderRadius.circular(AppDimensions.radiusL),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(AppDimensions.paddingM),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Align(
//                         alignment: Alignment.centerLeft,
//                         child: FractionallySizedBox(
//                           widthFactor: 0.6,
//                           child: ShimmerBlock(
//                             height: 16,
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(AppDimensions.radiusS),
//                             ),
//                           ),
//                         ),
//                       ),
//                       AppDimensions.gapS,
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: FractionallySizedBox(
//                                     widthFactor: 0.5,
//                                     child: ShimmerBlock(
//                                       height: 10,
//                                       borderRadius: BorderRadius.all(
//                                         Radius.circular(AppDimensions.radiusXS),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 4),
//                                 Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: FractionallySizedBox(
//                                     widthFactor: 0.4,
//                                     child: ShimmerBlock(
//                                       height: 14,
//                                       borderRadius: BorderRadius.all(
//                                         Radius.circular(AppDimensions.radiusXS),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           ShimmerBlock.circle(size: AppDimensions.iconL),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/presentation/widgets/shimmer_block.dart';

class PopularServicesSkeleton extends StatelessWidget {
  final int itemCount;

  const PopularServicesSkeleton({
    super.key,
    this.itemCount =
        4, // Matches the default length of your popularServices collection
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      child: GridView.builder(
        shrinkWrap: true,
        padding:
            EdgeInsets.zero, // Clears default material grid viewport offsets
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppDimensions.paddingM,
          mainAxisSpacing: AppDimensions.paddingM,
          childAspectRatio:
              0.76, // Symmetrical structural match to prevent layout shifts
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: context
                  .colorScheme
                  .surfaceContainerLow, // Provides clean background contrast
              borderRadius: BorderRadius.circular(AppDimensions.radiusL),
              border: Border.all(
                color: context.colorScheme.outlineVariant.withValues(
                  alpha: 0.3,
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radiusL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. TOP BLOCK: Hero Image Loading Area (Fills the remaining flex space)
                  const Expanded(child: ShimmerBlock(width: double.infinity)),

                  // 2. BOTTOM BLOCK: Content Meta Fields Area
                  Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingS),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Service Title Line 1 Placeholder
                        ShimmerBlock(
                          width: AppDimensions.size120,
                          height: AppDimensions.size14,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusXS,
                          ),
                        ),
                        AppDimensions.gapXXS,

                        // Service Title Line 2 Placeholder (Simulates maxLines: 2 layout footprint)
                        ShimmerBlock(
                          width: AppDimensions.size80,
                          height: AppDimensions.size14,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusXS,
                          ),
                        ),
                        AppDimensions.gapXS,

                        // Duration Meta Text Line Placeholder
                        ShimmerBlock(
                          width: AppDimensions.size50,
                          height: AppDimensions.size10,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusXS,
                          ),
                        ),
                        AppDimensions.gapS,

                        // Price and Interactive Action Row Footprint
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Base Price Placeholder
                            ShimmerBlock(
                              width: AppDimensions.size60,
                              height: AppDimensions.size14,
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusXS,
                              ),
                            ),

                            // AppPriceActionButton Action Trigger Placeholder
                            ShimmerBlock(
                              width: AppDimensions.size45,
                              height: AppDimensions
                                  .size26, // Height footprint of the action pill
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusM,
                              ),
                            ),
                          ],
                        ),
                      ],
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
