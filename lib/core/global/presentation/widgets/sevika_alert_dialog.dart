import 'package:flutter/material.dart';

import '../../../extensions/build_context_extensions.dart';

/// A universal, flexible Alert Dialog for the Sevika app.
/// Adapts its styling based on [isDestructive] and [primaryIsFilled].
Future<T?> showSevikaAlertDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required String primaryActionText,
  required VoidCallback onPrimaryAction,
  String? secondaryActionText,
  VoidCallback? onSecondaryAction,
  bool isDestructive = false,
  bool primaryIsFilled = false,
  IconData? icon,
  bool barrierDismissible = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext dialogContext) {
      final colors = dialogContext.colorScheme;

      // 1. Build the Primary Button with robust padding and text scaling
      Widget primaryButton;
      if (primaryIsFilled) {
        primaryButton = FilledButton(
          onPressed: onPrimaryAction,
          style: FilledButton.styleFrom(
            backgroundColor: isDestructive ? colors.error : null,
            foregroundColor: isDestructive ? colors.onError : null,
            // 🎯 Added comfortable padding so the button looks proportional
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(primaryActionText, maxLines: 1),
          ),
        );
      } else {
        primaryButton = TextButton(
          onPressed: onPrimaryAction,
          style: TextButton.styleFrom(
            foregroundColor: isDestructive ? colors.error : null,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              primaryActionText,
              maxLines: 1,
              style: isDestructive
                  ? const TextStyle(fontWeight: FontWeight.bold)
                  : null,
            ),
          ),
        );
      }

      // 2. Return the Material 3 AlertDialog
      return AlertDialog(
        icon: icon != null
            ? Icon(icon, color: isDestructive ? colors.error : colors.primary)
            : null,
        title: Text(title),
        content: Text(content),
        actions: [
          if (secondaryActionText != null)
            TextButton(
              onPressed:
                  onSecondaryAction ?? () => Navigator.of(dialogContext).pop(),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  secondaryActionText,
                  maxLines: 1,
                  style: TextStyle(color: colors.onSurfaceVariant),
                ),
              ),
            ),
          primaryButton,
        ],
      );
    },
  );
}
