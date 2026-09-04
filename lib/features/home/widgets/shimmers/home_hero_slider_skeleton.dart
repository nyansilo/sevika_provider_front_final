import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/presentation/widgets/shimmer_block.dart';

class HomeHeroSliderSkeleton extends StatefulWidget {
  final int itemCount;

  const HomeHeroSliderSkeleton({
    super.key,
    this.itemCount =
        2, // Matches the length of your default structural banner collection
  });

  @override
  State<HomeHeroSliderSkeleton> createState() => _HomeHeroSliderSkeletonState();
}

class _HomeHeroSliderSkeletonState extends State<HomeHeroSliderSkeleton> {
  late final PageController _pageController;
  final int _currentIndex =
      0; // Fixed zero baseline configuration during layout streaming states

  @override
  void initState() {
    super.initState();
    // MATCHES ORIGINAL PROFILE: Retains the explicit 90% view ratio so partial neighboring blocks bleed into the viewport edges
    _pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Structural Banner Carousel Layout Wrapper
        SizedBox(
          height: AppDimensions.heroCarouselHeight,
          child: PageView.builder(
            controller: _pageController,
            physics:
                const NeverScrollableScrollPhysics(), // Disables active sliding interactions while compiling states
            itemCount: widget.itemCount,
            itemBuilder: (context, index) {
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppDimensions.heroBannerWidthMobileMax,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingS,
                    ),
                    decoration: BoxDecoration(
                      // Uses low contrast backdrop container tokens to make inner text row elements pop cleanly
                      color: context.colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusXL,
                      ),
                      border: Border.all(
                        color: context.colorScheme.outlineVariant.withValues(
                          alpha: 0.3,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.paddingL),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 1. Banner Tag Pill Shimmer Placement
                          ShimmerBlock(
                            width: AppDimensions.size70,
                            height: AppDimensions
                                .size22, // Combines structural font bounding boxes + padding
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusS,
                            ),
                          ),
                          AppDimensions.gapS,

                          // 2. Core Banner Title Text Row Shimmer
                          ShimmerBlock(
                            width: AppDimensions.size180,
                            height: AppDimensions
                                .size22, // Corresponds to context.textTheme.titleLarge font metrics
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusXS,
                            ),
                          ),
                          AppDimensions.gapXS,

                          // 3. Sub-text Description Row 1 Shimmer
                          ShimmerBlock(
                            width: double.infinity,
                            height: AppDimensions
                                .size14, // Corresponds to context.textTheme.bodyMedium metrics
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusXS,
                            ),
                          ),
                          AppDimensions.gapXXS,

                          // 4. Sub-text Description Row 2 Shimmer (Simulates multi-line maxLines: 2 formatting bounds)
                          ShimmerBlock(
                            width: AppDimensions.size140,
                            height: AppDimensions.size14,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusXS,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // 2. Tokenized Spatial Clearance Gap
        AppDimensions.gapM,

        // 3. Externalized Layout Dot Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.itemCount,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingXS,
              ),
              height: AppDimensions.paddingS,
              // Preserves dynamic indicator width matching properties for the first element
              width: _currentIndex == index
                  ? AppDimensions.paddingXL
                  : AppDimensions.paddingS,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? context.colorScheme.primary
                    : context.colorScheme.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
