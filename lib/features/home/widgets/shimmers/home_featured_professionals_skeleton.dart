import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constants/app_dimensions.dart';

class HomeFeaturedProfessionalsSkeleton extends StatelessWidget {
  const HomeFeaturedProfessionalsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor = theme.colorScheme.surfaceContainerHigh;
    final highlightColor = theme.colorScheme.surfaceContainerLow;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingS),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.paddingS,
            ),
            child: Row(
              children: [
                // Fixed dimensional asset placeholder
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                ),
                AppDimensions.gapM,

                // FIXED: Wrapped the text line stack in an Expanded layout block
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Secure fractional line calculation within defined boundaries
                      FractionallySizedBox(
                        widthFactor: 0.7,
                        child: Container(
                          height: 16,
                          decoration: BoxDecoration(
                            color: baseColor,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusXS,
                            ),
                          ),
                        ),
                      ),
                      AppDimensions.gapS,
                      FractionallySizedBox(
                        widthFactor: 0.4,
                        child: Container(
                          height: 12,
                          decoration: BoxDecoration(
                            color: baseColor,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusXS,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
