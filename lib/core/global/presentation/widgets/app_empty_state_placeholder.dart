import 'package:flutter/material.dart';

import '../../../constants/app_dimensions.dart';
import '../../../extensions/build_context_extensions.dart';

class AppEmptyStatePlaceholder extends StatelessWidget {
  final IconData icon;
  final String message;

  const AppEmptyStatePlaceholder({
    super.key,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingXXL),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppDimensions.iconL,
              color: context.colorScheme.outlineVariant,
            ),
            AppDimensions.gapM,
            Text(
              message,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
