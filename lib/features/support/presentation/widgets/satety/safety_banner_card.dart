// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_dimensions.dart';

// class SafetyBannerCard extends StatelessWidget {
//   const SafetyBannerCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Container(
//       padding: const EdgeInsets.all(AppDimensions.paddingM),
//       decoration: BoxDecoration(
//         color: theme.colorScheme.primaryContainer.withValues(
//           alpha: AppDimensions.containerAlphaLow,
//         ),
//         borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
//         border: Border.all(
//           color: theme.colorScheme.primary.withValues(
//             alpha: AppDimensions.borderAlphaSubtle,
//           ),
//           width: AppDimensions.borderWidthThin,
//         ),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(AppDimensions.paddingSM),
//             decoration: BoxDecoration(
//               color: theme.colorScheme.primary.withValues(
//                 alpha: AppDimensions.containerAlphaLow,
//               ),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.gpp_good_rounded,
//               color: theme.colorScheme.primary,
//               size: AppDimensions.iconXL,
//             ),
//           ),
//           AppDimensions.gapM,
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Ecosystem Secure Guard',
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: theme.colorScheme.onPrimaryContainer,
//                   ),
//                 ),
//                 AppDimensions.gapXXS,
//                 Text(
//                   'Your profile, interactions, and financial transactions are protected by end-to-end security frameworks.',
//                   style: theme.textTheme.bodySmall?.copyWith(
//                     color: theme.colorScheme.onSurfaceVariant,
//                     fontSize:
//                         AppDimensions.fontSizeBodySecondary -
//                         AppDimensions.paddingXXS, // Matches theme layout specs
//                     height: AppDimensions.lineHeightTight,
//                   ),
//                 ),
//               ],
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

class SafetyBannerCard extends StatelessWidget {
  const SafetyBannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer.withValues(
          alpha: AppDimensions.containerAlphaLow,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        border: Border.all(
          color: context.colorScheme.primary.withValues(
            alpha: AppDimensions.borderAlphaSubtle,
          ),
          width: AppDimensions.borderWidthThin,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingSM),
            decoration: BoxDecoration(
              color: context.colorScheme.primary.withValues(
                alpha: AppDimensions.containerAlphaLow,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.gpp_good_rounded,
              color: context.colorScheme.primary,
              size: AppDimensions.iconXL,
            ),
          ),
          AppDimensions.gapM,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ecosystem Secure Guard',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onPrimaryContainer,
                  ),
                ),
                AppDimensions.gapXXS,
                Text(
                  'Your profile, interactions, and financial transactions are protected by end-to-end security frameworks.',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    fontSize:
                        AppDimensions.fontSizeBodySecondary -
                        AppDimensions.paddingXXS, // Matches theme layout specs
                    height: AppDimensions.lineHeightTight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
