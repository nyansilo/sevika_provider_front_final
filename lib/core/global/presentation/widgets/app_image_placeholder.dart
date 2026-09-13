import 'package:flutter/material.dart';

import '../../../constants/app_dimensions.dart';
import '../../../extensions/build_context_extensions.dart';

class AppImagePlaceholder extends StatelessWidget {
  final IconData icon;
  final double? iconSize;

  const AppImagePlaceholder({
    super.key,
    this.icon = Icons.image_not_supported_rounded,
    this.iconSize = AppDimensions
        .iconM, // Make sure your AppDimensions has an icon size token
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: context.colorScheme.surfaceContainer,
      child: Center(
        child: Icon(
          icon,
          color: context.colorScheme.outlineVariant,
          size: iconSize,
        ),
      ),
    );
  }
}
