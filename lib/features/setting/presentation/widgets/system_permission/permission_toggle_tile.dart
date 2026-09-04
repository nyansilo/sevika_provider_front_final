// import 'package:flutter/material.dart';

// import '../../../../../core/constants/app_dimensions.dart';

// class PermissionToggleTile extends StatelessWidget {
//   final String title;
//   final String description;
//   final IconData icon;
//   final bool isEnabled;
//   final ValueChanged<bool> onChanged;

//   const PermissionToggleTile({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.icon,
//     required this.isEnabled,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Container(
//       padding: const EdgeInsets.all(AppDimensions.paddingM),
//       decoration: BoxDecoration(
//         color: theme.colorScheme.surfaceContainerLow,
//         borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//         border: Border.all(
//           color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
//         ),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Left Side Status Identifier Icon Node
//           Container(
//             padding: const EdgeInsets.all(8.0),
//             decoration: BoxDecoration(
//               color: isEnabled
//                   ? theme.colorScheme.primaryContainer.withValues(alpha: 0.2)
//                   : theme.colorScheme.surfaceContainerHighest,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               icon,
//               color: isEnabled
//                   ? theme.colorScheme.primary
//                   : theme.colorScheme.outline,
//               size: 22,
//             ),
//           ),
//           AppDimensions.gapM,

//           // Central Informative Description Area
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: theme.textTheme.bodyLarge?.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   description,
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     color: theme.colorScheme.onSurfaceVariant,
//                     height: 1.3,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           AppDimensions.gapM,

//           // Adaptive Selection Switch Engine Node
//           Switch.adaptive(
//             value: isEnabled,
//             onChanged: onChanged,
//             activeColor: theme.colorScheme.primary,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart'; // Imported context layer shortcuts

class PermissionToggleTile extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isEnabled;
  final ValueChanged<bool> onChanged;

  const PermissionToggleTile({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.isEnabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: context.colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side Status Identifier Icon Node
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: isEnabled
                  ? context.colorScheme.primaryContainer.withValues(alpha: 0.2)
                  : context.colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isEnabled
                  ? context.colorScheme.primary
                  : context.colorScheme.outline,
              size:
                  AppDimensions.iconM, // Standardized icon metric token mapping
            ),
          ),
          AppDimensions.gapM,

          // Central Informative Description Area
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          AppDimensions.gapM,

          // Adaptive Selection Switch Engine Node
          Switch.adaptive(
            value: isEnabled,
            onChanged: onChanged,
            activeThumbColor: context
                .colorScheme
                .primary, // Kept up-to-date with non-deprecated specs
          ),
        ],
      ),
    );
  }
}
