// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_dimensions.dart';

// class ContactSupportCard extends StatelessWidget {
//   const ContactSupportCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Container(
//       padding: const EdgeInsets.all(AppDimensions.paddingM),
//       decoration: BoxDecoration(
//         color: theme.colorScheme.surface,
//         border: Border(
//           top: BorderSide(
//             color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
//             width: 0.5,
//           ),
//         ),
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(AppDimensions.paddingM),
//         decoration: BoxDecoration(
//           color: theme.colorScheme.primaryContainer.withValues(alpha: 0.25),
//           borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
//           border: Border.all(
//             color: theme.colorScheme.primaryContainer.withValues(alpha: 0.6),
//           ),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'Still have roadblocks?',
//                     style: theme.textTheme.bodyMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     'Our operational staff are live 24/7.',
//                     style: theme.textTheme.bodySmall?.copyWith(
//                       color: theme.colorScheme.onSurfaceVariant,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             AppDimensions.gapM,
//             FilledButton.icon(
//               onPressed: () {
//                 // Initialize modern live chat messaging UI session pipeline
//               },
//               icon: const Icon(Icons.forum_rounded, size: 18),
//               label: Text(
//                 'Live Chat',
//                 style: theme.textTheme.labelMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: theme.colorScheme.onPrimary,
//                 ),
//               ),
//               style: FilledButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: AppDimensions.paddingM,
//                   vertical: AppDimensions.paddingS,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//                 ),
//               ),
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

class ContactSupportCard extends StatelessWidget {
  const ContactSupportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 0.5,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: context.colorScheme.primaryContainer.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          border: Border.all(
            color: context.colorScheme.primaryContainer.withValues(alpha: 0.6),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Still have roadblocks?',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Our operational staff are live 24/7.',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            AppDimensions.gapM,
            FilledButton.icon(
              onPressed: () {
                // Initialize modern live chat messaging UI session pipeline
              },
              icon: const Icon(
                Icons.forum_rounded,
                size: AppDimensions
                    .iconS, // Standardized icon metric token mapping
              ),
              label: Text(
                'Live Chat',
                style: context.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onPrimary,
                ),
              ),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingM,
                  vertical: AppDimensions.paddingS,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
