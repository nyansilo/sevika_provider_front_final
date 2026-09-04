// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_dimensions.dart';

// class LegalItemTile extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String? version;
//   final IconData icon;
//   final VoidCallback onTap;

//   const LegalItemTile({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     this.version,
//     required this.icon,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Material(
//       color: theme.colorScheme.surfaceContainerLow,
//       clipBehavior: Clip.antiAlias,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppDimensions.radiusL),
//         side: BorderSide(
//           color: theme.colorScheme.outlineVariant.withValues(
//             alpha: AppDimensions.borderAlphaMuted,
//           ),
//           width: AppDimensions.borderWidthThin,
//         ),
//       ),
//       child: ListTile(
//         onTap: onTap,
//         enableFeedback: true,
//         contentPadding: const EdgeInsets.all(AppDimensions.paddingM),
//         leading: Container(
//           padding: const EdgeInsets.all(AppDimensions.paddingSM),
//           decoration: BoxDecoration(
//             color: theme.colorScheme.primary.withValues(
//               alpha: AppDimensions.containerAlphaLow,
//             ),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             icon,
//             color: theme.colorScheme.primary,
//             size: AppDimensions.iconL,
//           ),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Text(
//                 title,
//                 style: theme.textTheme.bodyMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: theme.colorScheme.onSurface,
//                 ),
//               ),
//             ),
//             if (version != null)
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: AppDimensions.paddingS,
//                   vertical: AppDimensions.paddingXXS,
//                 ),
//                 decoration: BoxDecoration(
//                   color: theme.colorScheme.surfaceContainerHigh,
//                   borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
//                 ),
//                 child: Text(
//                   version!,
//                   style: theme.textTheme.labelSmall?.copyWith(
//                     color: theme.colorScheme.onSurfaceVariant,
//                     fontSize: AppDimensions.fontSizeCaption,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//         subtitle: Padding(
//           padding: const EdgeInsets.only(top: AppDimensions.paddingXS),
//           child: Text(
//             subtitle,
//             style: theme.textTheme.bodyMedium?.copyWith(
//               color: theme.colorScheme.onSurfaceVariant,
//               fontSize: AppDimensions.fontSizeBodySecondary,
//               height: AppDimensions.lineHeightTight,
//             ),
//           ),
//         ),
//         trailing: Icon(
//           Icons.arrow_forward_ios_rounded,
//           color: theme.colorScheme.outline,
//           size: AppDimensions.iconXS,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart'; // Imported context layer shortcuts

class LegalItemTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? version;
  final IconData icon;
  final VoidCallback onTap;

  const LegalItemTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.version,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.surfaceContainerLow,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        side: BorderSide(
          color: context.colorScheme.outlineVariant.withValues(
            alpha: AppDimensions.borderAlphaMuted,
          ),
          width: AppDimensions.borderWidthThin,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        enableFeedback: true,
        contentPadding: const EdgeInsets.all(AppDimensions.paddingM),
        leading: Container(
          padding: const EdgeInsets.all(AppDimensions.paddingSM),
          decoration: BoxDecoration(
            color: context.colorScheme.primary.withValues(
              alpha: AppDimensions.containerAlphaLow,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: context.colorScheme.primary,
            size: AppDimensions.iconL,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ),
            if (version != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingS,
                  vertical: AppDimensions.paddingXXS,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
                ),
                child: Text(
                  version!,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    fontSize: AppDimensions.fontSizeCaption,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: AppDimensions.paddingXS),
          child: Text(
            subtitle,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              fontSize: AppDimensions.fontSizeBodySecondary,
              height: AppDimensions.lineHeightTight,
            ),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: context.colorScheme.outline,
          size: AppDimensions.iconXS,
        ),
      ),
    );
  }
}
