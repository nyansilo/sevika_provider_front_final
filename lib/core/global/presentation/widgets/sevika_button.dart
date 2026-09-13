import 'package:flutter/material.dart';

import '../../../constants/animation_constants.dart';
import '../../../constants/app_dimensions.dart';
import '../../../extensions/build_context_extensions.dart';

class SevikaButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isSecondary;
  final bool isDestructive; // 🚀 ADDED: For Delete Review and critical actions
  final bool isOutlined; // 🚀 ADDED: For ghost buttons/cancel actions
  final IconData? icon;

  const SevikaButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isSecondary = false,
    this.isDestructive = false,
    this.isOutlined = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;

    // 🎨 Dynamic Color Resolution Pipeline
    Color resolveBackgroundColor() {
      if (isOutlined) return Colors.transparent;
      if (isDestructive) return context.colorScheme.error;
      if (isSecondary) return context.colorScheme.secondaryContainer;
      return context.colorScheme.primary;
    }

    Color resolveForegroundColor() {
      if (isDestructive) {
        return isOutlined
            ? context.colorScheme.error
            : context.colorScheme.onError;
      }
      if (isSecondary) return context.colorScheme.onSecondaryContainer;
      if (isOutlined) return context.colorScheme.primary;
      return context.colorScheme.onPrimary;
    }

    final Color backgroundColor = resolveBackgroundColor();
    final Color foregroundColor = resolveForegroundColor();

    return AnimatedContainer(
      duration: AnimationConstants.durationFast,
      curve: AnimationConstants.curveDefaultEntrance,
      width: double.infinity,
      height: AppDimensions.targetButtonHeight,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: isOutlined
              ? Colors.transparent
              : context.colorScheme.surfaceContainerHighest,
          disabledForegroundColor: context.colorScheme.onSurfaceVariant,
          elevation: (isSecondary || isOutlined)
              ? 0
              : AppDimensions.borderWidthThick,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            // 🚀 Apply border strictly for outlined variants
            side: isOutlined
                ? BorderSide(
                    color: isDisabled
                        ? context.colorScheme.outlineVariant
                        : foregroundColor,
                    width: AppDimensions.borderWidthThin,
                  )
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: AppDimensions.size24,
                width: AppDimensions.size24,
                child: CircularProgressIndicator(
                  strokeWidth: AppDimensions.borderWidthThick,
                  valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: AppDimensions.iconM),
                    AppDimensions.gapHS,
                  ],
                  // Defensively bound text to prevent right-edge overflows safely
                  Flexible(
                    child: Text(
                      text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: isDisabled
                            ? context.colorScheme.onSurfaceVariant
                            : foregroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
