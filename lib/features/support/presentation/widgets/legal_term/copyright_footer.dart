// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_dimensions.dart';

// class CopyrightFooter extends StatelessWidget {
//   const CopyrightFooter({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(AppDimensions.paddingM),
//       decoration: BoxDecoration(
//         color: theme.colorScheme.surface,
//         border: Border(
//           top: BorderSide(
//             color: theme.colorScheme.outlineVariant.withValues(
//               alpha: AppDimensions.borderAlphaSubtle,
//             ),
//             width: AppDimensions.borderWidthThin,
//           ),
//         ),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             '© 2026 Service Marketplace Ltd.',
//             style: theme.textTheme.bodySmall?.copyWith(
//               fontWeight: FontWeight.bold,
//               color: theme.colorScheme.onSurface,
//             ),
//           ),
//           AppDimensions.gapXXS,
//           Text(
//             'All rights reserved. Unauthorized reproduction is legally protected.',
//             textAlign: TextAlign.center,
//             style: theme.textTheme.labelSmall?.copyWith(
//               color: theme.colorScheme.outline,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart'; // Imported context layer shortcuts

class CopyrightFooter extends StatelessWidget {
  const CopyrightFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: context.colorScheme.outlineVariant.withValues(
              alpha: AppDimensions.borderAlphaSubtle,
            ),
            width: AppDimensions.borderWidthThin,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '© 2026 Service Marketplace Ltd.',
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface,
            ),
          ),
          AppDimensions.gapXXS,
          Text(
            'All rights reserved. Unauthorized reproduction is legally protected.',
            textAlign: TextAlign.center,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}
