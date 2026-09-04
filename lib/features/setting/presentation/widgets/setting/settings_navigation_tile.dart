// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_dimensions.dart';

// class SettingsNavigationTile extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final VoidCallback onTap;
//   final Color? isDestructiveColor;

//   const SettingsNavigationTile({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.onTap,
//     this.isDestructiveColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final activeColor = isDestructiveColor ?? theme.colorScheme.onSurface;

//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: AppDimensions.paddingM,
//           vertical: AppDimensions.paddingM,
//         ),
//         child: Row(
//           children: [
//             Icon(
//               icon,
//               color: isDestructiveColor ?? theme.colorScheme.onSurfaceVariant,
//               size: AppDimensions.iconM,
//             ),
//             AppDimensions.gapM,
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: theme.textTheme.bodyLarge?.copyWith(
//                       fontWeight: FontWeight.w500,
//                       color: activeColor,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     subtitle,
//                     style: theme.textTheme.bodySmall?.copyWith(
//                       color: isDestructiveColor != null
//                           ? isDestructiveColor!.withValues(alpha: 0.8)
//                           : theme.colorScheme.onSurfaceVariant,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             AppDimensions.gapS,
//             Icon(
//               Icons.chevron_right_rounded,
//               color:
//                   isDestructiveColor?.withValues(alpha: 0.6) ??
//                   theme.colorScheme.outline,
//               size: AppDimensions.iconM,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart'; // Imported context layer shortcuts

class SettingsNavigationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? isDestructiveColor;

  const SettingsNavigationTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = isDestructiveColor ?? context.colorScheme.onSurface;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingM,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructiveColor ?? context.colorScheme.onSurfaceVariant,
              size: AppDimensions.iconM,
            ),
            AppDimensions.gapM,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: activeColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: isDestructiveColor != null
                          ? isDestructiveColor!.withValues(alpha: 0.8)
                          : context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            AppDimensions.gapS,
            Icon(
              Icons.chevron_right_rounded,
              color:
                  isDestructiveColor?.withValues(alpha: 0.6) ??
                  context.colorScheme.outline,
              size: AppDimensions.iconM,
            ),
          ],
        ),
      ),
    );
  }
}
