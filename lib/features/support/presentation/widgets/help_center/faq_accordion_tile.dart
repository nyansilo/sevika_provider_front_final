// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_dimensions.dart';

// class FaqAccordionTile extends StatelessWidget {
//   final String question;
//   final String answer;

//   const FaqAccordionTile({
//     super.key,
//     required this.question,
//     required this.answer,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     // Swap Container for Material to allow ink splashes to paint correctly
//     return Material(
//       color: theme.colorScheme.surfaceContainerLow,
//       clipBehavior: Clip
//           .antiAlias, // Ensures the tile contents don't bleed out of the corners
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppDimensions.radiusL),
//         side: BorderSide(
//           color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
//         ),
//       ),
//       child: Theme(
//         // Keeps the layout clean by removing the default ExpansionTile border lines
//         data: theme.copyWith(dividerColor: Colors.transparent),
//         child: ExpansionTile(
//           iconColor: theme.colorScheme.primary,
//           collapsedIconColor: theme.colorScheme.outline,
//           title: Text(
//             question,
//             style: theme.textTheme.bodyMedium?.copyWith(
//               fontWeight: FontWeight.w500,
//               color: theme.colorScheme.onSurface,
//             ),
//           ),
//           childrenPadding: const EdgeInsets.fromLTRB(
//             AppDimensions.paddingM,
//             0,
//             AppDimensions.paddingM,
//             AppDimensions.paddingM,
//           ),
//           children: [
//             Text(
//               answer,
//               style: theme.textTheme.bodyMedium?.copyWith(
//                 color: theme.colorScheme.onSurfaceVariant,
//                 height: 1.4,
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

class FaqAccordionTile extends StatelessWidget {
  final String question;
  final String answer;

  const FaqAccordionTile({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.surfaceContainerLow,
      clipBehavior: Clip
          .antiAlias, // Ensures the tile contents don't bleed out of the corners
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        side: BorderSide(
          color: context.colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Theme(
        // Keeps the layout clean by removing the default ExpansionTile border lines
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: context.colorScheme.primary,
          collapsedIconColor: context.colorScheme.outline,
          title: Text(
            question,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colorScheme.onSurface,
            ),
          ),
          childrenPadding: const EdgeInsets.fromLTRB(
            AppDimensions.paddingM,
            0,
            AppDimensions.paddingM,
            AppDimensions.paddingM,
          ),
          children: [
            Text(
              answer,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
