// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_dimensions.dart';

// class LanguageSelectorTile extends StatelessWidget {
//   final String languageName;
//   final String nativeName;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const LanguageSelectorTile({
//     super.key,
//     required this.languageName,
//     required this.nativeName,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//       child: Container(
//         padding: const EdgeInsets.all(AppDimensions.paddingM),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? theme.colorScheme.primaryContainer.withValues(alpha: 0.15)
//               : theme.colorScheme.surfaceContainerLow,
//           borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//           border: Border.all(
//             color: isSelected
//                 ? theme.colorScheme.primary
//                 : theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
//             width: isSelected ? 1.5 : 1.0,
//           ),
//         ),
//         child: Row(
//           children: [
//             // Structural text details layout stack
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     languageName,
//                     style: theme.textTheme.bodyLarge?.copyWith(
//                       fontWeight: isSelected
//                           ? FontWeight.bold
//                           : FontWeight.normal,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     nativeName,
//                     style: theme.textTheme.bodySmall?.copyWith(
//                       color: theme.colorScheme.onSurfaceVariant,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Trailing activation indicator node
//             if (isSelected)
//               Icon(
//                 Icons.check_circle_rounded,
//                 color: theme.colorScheme.primary,
//                 size: 22,
//               )
//             else
//               Icon(
//                 Icons.radio_button_unchecked_rounded,
//                 color: theme.colorScheme.outlineVariant,
//                 size: 22,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart'; // Imported context layer shortcuts

class LanguageSelectorTile extends StatelessWidget {
  final String languageName;
  final String nativeName;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageSelectorTile({
    super.key,
    required this.languageName,
    required this.nativeName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colorScheme.primaryContainer.withValues(alpha: 0.15)
              : context.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(
            color: isSelected
                ? context.colorScheme.primary
                : context.colorScheme.outlineVariant.withValues(alpha: 0.4),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            // Structural text details layout stack
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    languageName,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    nativeName,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            // Trailing activation indicator node
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: context.colorScheme.primary,
                size: AppDimensions
                    .iconM, // Standardized icon metric token mapping
              )
            else
              Icon(
                Icons.radio_button_unchecked_rounded,
                color: context.colorScheme.outlineVariant,
                size: AppDimensions
                    .iconM, // Standardized icon metric token mapping
              ),
          ],
        ),
      ),
    );
  }
}
