// }

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/extensions/build_context_extensions.dart';

class ShimmerBlock extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final ShapeBorder shape;

  const ShimmerBlock({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.shape = const RoundedRectangleBorder(),
  });

  // Factory constructor for quick circle skeletons (like profile images or icons)
  const ShimmerBlock.circle({super.key, required double size})
    : width = size,
      height = size,
      borderRadius = null,
      shape = const CircleBorder();

  @override
  Widget build(BuildContext context) {
    // Base colors adapted dynamically to light/dark modes using context layer shortcuts
    final baseColor = context.colorScheme.surfaceContainerHigh;
    final highlightColor = context.colorScheme.surfaceContainerLow;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      period: const Duration(milliseconds: 1500), // Smooth sweep speed
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: borderRadius,
          shape: shape is CircleBorder ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }
}
