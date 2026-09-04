// import 'package:flutter/material.dart';
// import '../../constants/app_dimensions.dart';
// import '../../extensions/build_context_extensions.dart';

// class StatePlaceholder extends StatelessWidget {
//   final String title;
//   final String message;
//   final IconData icon;
//   final String? actionButtonText;
//   final VoidCallback? onActionPressed;

//   const StatePlaceholder({
//     super.key,
//     required this.title,
//     required this.message,
//     required this.icon,
//     this.actionButtonText,
//     this.onActionPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(AppDimensions.paddingL),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(AppDimensions.size20),
//             decoration: BoxDecoration(
//               color: context.colorScheme.primaryContainer.withValues(
//                 alpha: AppDimensions.maxOnboardingWidth / 1250,
//               ),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               icon,
//               size: AppDimensions.iconXXL,
//               color: context.colorScheme.primary,
//             ),
//           ),
//           const SizedBox(height: AppDimensions.size20),
//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: context.textTheme.titleLarge?.copyWith(
//               fontWeight: FontWeight.bold,
//               fontSize: AppDimensions.fontSizeHeading,
//             ),
//           ),
//           AppDimensions.gapVS,
//           Text(
//             message,
//             textAlign: TextAlign.center,
//             style: context.textTheme.bodyMedium?.copyWith(
//               color: context.colorScheme.onSurfaceVariant,
//               fontSize: AppDimensions.fontSizeBodyPrimary,
//             ),
//           ),
//           if (actionButtonText != null && onActionPressed != null) ...[
//             AppDimensions.gapVL,
//             SizedBox(
//               width: AppDimensions.categoryGridMaxExtent,
//               height: AppDimensions.compactButtonHeight,
//               child: ElevatedButton(
//                 onPressed: onActionPressed,
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//                   ),
//                 ),
//                 child: Text(actionButtonText!),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../constants/app_dimensions.dart';
import '../../extensions/build_context_extensions.dart';

class StatePlaceholderOld extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final String? actionButtonText;
  final IconData? actionButtonIcon;
  final VoidCallback? onActionPressed;
  final Color? iconColor;
  final Color? iconBackgroundColor;

  const StatePlaceholderOld({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    this.actionButtonText,
    this.actionButtonIcon,
    this.onActionPressed,
    this.iconColor,
    this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // Default to primary theme colors if custom colors aren't provided
    final actualIconColor = iconColor ?? context.colorScheme.primary;
    final actualBgColor =
        iconBackgroundColor ??
        context.colorScheme.primaryContainer.withValues(alpha: 0.3);

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingXXL),
            decoration: BoxDecoration(
              color: actualBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 80, color: actualIconColor),
          ),
          AppDimensions.gapXL,
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface,
            ),
          ),
          AppDimensions.gapM,
          Text(
            message,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          if (actionButtonText != null && onActionPressed != null) ...[
            AppDimensions.gapXXL,
            SizedBox(
              width: double.infinity,
              height: 54,
              child: actionButtonIcon != null
                  ? FilledButton.icon(
                      onPressed: onActionPressed,
                      icon: Icon(actionButtonIcon),
                      label: Text(
                        actionButtonText!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusL,
                          ),
                        ),
                      ),
                    )
                  : FilledButton(
                      onPressed: onActionPressed,
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusL,
                          ),
                        ),
                      ),
                      child: Text(
                        actionButtonText!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
            ),
          ],
        ],
      ),
    );
  }
}
