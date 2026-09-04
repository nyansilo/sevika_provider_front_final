// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_dimensions.dart';

// class AssuranceFeatureCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final String? badgeLabel;
//   final IconData icon;
//   final Color iconColor;

//   const AssuranceFeatureCard({
//     super.key,
//     required this.title,
//     required this.description,
//     this.badgeLabel,
//     required this.icon,
//     required this.iconColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Container(
//       padding: const EdgeInsets.all(AppDimensions.paddingM),
//       decoration: BoxDecoration(
//         color: theme.colorScheme.surfaceContainerLow,
//         borderRadius: BorderRadius.circular(AppDimensions.radiusL),
//         border: Border.all(
//           color: theme.colorScheme.outlineVariant.withValues(
//             alpha: AppDimensions.borderAlphaMuted,
//           ),
//           width: AppDimensions.borderWidthThin,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(icon, color: iconColor, size: AppDimensions.iconL),
//               AppDimensions.gapS,
//               Expanded(
//                 child: Text(
//                   title,
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: theme.colorScheme.onSurface,
//                   ),
//                 ),
//               ),
//               if (badgeLabel != null)
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: AppDimensions.paddingS,
//                     vertical: AppDimensions.paddingXXS,
//                   ),
//                   decoration: BoxDecoration(
//                     color: iconColor.withValues(
//                       alpha: AppDimensions.containerAlphaLow,
//                     ),
//                     borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
//                   ),
//                   child: Text(
//                     badgeLabel!,
//                     style: theme.textTheme.labelSmall?.copyWith(
//                       color: iconColor,
//                       fontWeight: FontWeight.bold,
//                       fontSize: AppDimensions.fontSizeCaption,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//           AppDimensions.gapSM,
//           Text(
//             description,
//             style: theme.textTheme.bodyMedium?.copyWith(
//               color: theme.colorScheme.onSurfaceVariant,
//               fontSize: AppDimensions.fontSizeBodySecondary,
//               height: AppDimensions.lineHeightTight,
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

class AssuranceFeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final String? badgeLabel;
  final IconData icon;
  final Color iconColor;

  const AssuranceFeatureCard({
    super.key,
    required this.title,
    required this.description,
    this.badgeLabel,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(
          color: context.colorScheme.outlineVariant.withValues(
            alpha: AppDimensions.borderAlphaMuted,
          ),
          width: AppDimensions.borderWidthThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: AppDimensions.iconL),
              AppDimensions.gapS,
              Expanded(
                child: Text(
                  title,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ),
              if (badgeLabel != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingS,
                    vertical: AppDimensions.paddingXXS,
                  ),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(
                      alpha: AppDimensions.containerAlphaLow,
                    ),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
                  ),
                  child: Text(
                    badgeLabel!,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: iconColor,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.fontSizeCaption,
                    ),
                  ),
                ),
            ],
          ),
          AppDimensions.gapSM,
          Text(
            description,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              fontSize: AppDimensions.fontSizeBodySecondary,
              height: AppDimensions.lineHeightTight,
            ),
          ),
        ],
      ),
    );
  }
}
