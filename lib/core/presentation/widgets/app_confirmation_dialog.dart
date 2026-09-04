// import 'package:flutter/material.dart';
// import '../../core/constants/app_dimensions.dart';
// import '../../core/extensions/build_context_extensions.dart';
// import 'app_button.dart';

// class AppConfirmationDialog extends StatelessWidget {
//   final String title;
//   final String content;
//   final String confirmLabel;
//   final String cancelLabel;
//   final VoidCallback onConfirm;
//   final IconData icon;
//   final bool isDestructive;

//   const AppConfirmationDialog({
//     super.key,
//     required this.title,
//     required this.content,
//     required this.confirmLabel,
//     this.cancelLabel = 'Cancel',
//     required this.onConfirm,
//     required this.icon,
//     this.isDestructive = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: context.colorScheme.surface,
//       surfaceTintColor: Colors.transparent,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
//       ),
//       icon: CircleAvatar(
//         radius: AppDimensions.avatarRadiusL,
//         backgroundColor: isDestructive
//             ? context.colorScheme.errorContainer.withValues(alpha: 0.2)
//             : context.colorScheme.primaryContainer.withValues(alpha: 0.2),
//         child: Icon(
//           icon,
//           color: isDestructive
//               ? context.colorScheme.error
//               : context.colorScheme.primary,
//           size: AppDimensions.iconXL,
//         ),
//       ),
//       title: Text(
//         title,
//         style: context.textTheme.titleMedium?.copyWith(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       content: Text(
//         content,
//         textAlign: TextAlign.center,
//         style: context.textTheme.bodyMedium?.copyWith(
//           color: context.colorScheme.onSurfaceVariant,
//           height: AppDimensions.lineHeightNormal,
//         ),
//       ),
//       actionsPadding: const EdgeInsets.fromLTRB(
//         AppDimensions.paddingM,
//         AppDimensions.paddingXS,
//         AppDimensions.paddingM,
//         AppDimensions.paddingM,
//       ),
//       actions: [
//         Row(
//           children: [
//             Expanded(
//               child: OutlinedButton(
//                 onPressed: () => Navigator.pop(context),
//                 style: OutlinedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: AppDimensions.paddingM,
//                   ),
//                   side: BorderSide(
//                     color: context.colorScheme.outlineVariant.withValues(
//                       alpha: 0.8,
//                     ),
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//                   ),
//                 ),
//                 child: Text(
//                   cancelLabel,
//                   style: context.textTheme.labelLarge?.copyWith(
//                     fontWeight: FontWeight.w600,
//                     color: context.colorScheme.onSurfaceVariant,
//                   ),
//                 ),
//               ),
//             ),
//             AppDimensions.gapM,
//             Expanded(
//               child: AppButton(
//                 text: confirmLabel,
//                 isSecondary: !isDestructive,
//                 onPressed: () {
//                   Navigator.pop(context);
//                   onConfirm();
//                 },
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../constants/app_dimensions.dart';
import '../../extensions/build_context_extensions.dart'; // Import path to your extension class

class AppConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final String label;
  final VoidCallback onDeleteConfirmed;

  const AppConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.label,
    required this.onDeleteConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
      ),
      icon: CircleAvatar(
        radius: AppDimensions.avatarRadiusL,
        backgroundColor: context.colorScheme.errorContainer.withValues(
          alpha: 0.2,
        ),
        child: Icon(
          Icons.delete_forever_rounded,
          color: context.colorScheme.error,
          size: AppDimensions.iconXL,
        ),
      ),
      title: Text(
        title,
        style: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.onSurfaceVariant,
          height: AppDimensions.lineHeightNormal,
        ),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(
        AppDimensions.paddingM,
        AppDimensions.paddingXS,
        AppDimensions.paddingM,
        AppDimensions.paddingM,
      ),
      actions: [
        Row(
          children: [
            // CANCEL BUTTON
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.paddingM,
                  ),
                  side: BorderSide(
                    color: context.colorScheme.outlineVariant.withValues(
                      alpha: 0.8,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            AppDimensions.gapM,
            // DESTRUCTIVE ACTION BUTTON (Delete Text explicitly White)
            Expanded(
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  onDeleteConfirmed();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: context.colorScheme.error,
                  foregroundColor:
                      Colors.white, // Forces content foreground to white
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.paddingM,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                ),
                child: Text(
                  'Delete',
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors
                        .white, // Guarantees white appearance overriding fallback themes
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
