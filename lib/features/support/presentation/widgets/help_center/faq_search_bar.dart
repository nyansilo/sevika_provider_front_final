// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_dimensions.dart';

// class FaqSearchBar extends StatelessWidget {
//   const FaqSearchBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return TextFormField(
//       style: theme.textTheme.bodyMedium,
//       decoration: InputDecoration(
//         hintText: 'Search queries, topics, keywords...',
//         hintStyle: theme.textTheme.bodyMedium?.copyWith(
//           color: theme.colorScheme.outline,
//         ),
//         prefixIcon: Icon(
//           Icons.search_rounded,
//           size: 22,
//           color: theme.colorScheme.onSurfaceVariant,
//         ),
//         filled: true,
//         fillColor: theme.colorScheme.surfaceContainerLow,
//         contentPadding: const EdgeInsets.symmetric(
//           vertical: AppDimensions.paddingM,
//           horizontal: AppDimensions.paddingM,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//           borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//           borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//           borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart'; // Imported context layer shortcuts

class FaqSearchBar extends StatelessWidget {
  const FaqSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: context.textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: 'Search queries, topics, keywords...',
        hintStyle: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.outline,
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          size: AppDimensions.iconM, // Standardized icon metric token mapping
          color: context.colorScheme.onSurfaceVariant,
        ),
        filled: true,
        fillColor: context.colorScheme.surfaceContainerLow,
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingM,
          horizontal: AppDimensions.paddingM,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(color: context.colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(color: context.colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(
            color: context.colorScheme.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
