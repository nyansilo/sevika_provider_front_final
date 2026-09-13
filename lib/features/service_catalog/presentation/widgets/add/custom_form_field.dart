import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLines;
  final String? prefixText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled; // 🚀 ADDED: parameter declaration

  const CustomFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.prefixText,
    this.validator,
    this.inputFormatters,
    this.enabled = true, // 🚀 ADDED: defaults to true
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            // Visually dim the label if the field is locked
            color: enabled
                ? context.colorScheme.onSurface
                : context.colorScheme.onSurfaceVariant,
          ),
        ),
        AppDimensions.gapXS,
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          inputFormatters: inputFormatters,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          enabled: enabled, // 🚀 ADDED: Passed directly to TextFormField
          decoration: InputDecoration(
            hintText: hint,
            prefixText: prefixText,
            prefixStyle: context.textTheme.bodyLarge?.copyWith(
              color: enabled
                  ? context.colorScheme.primary
                  : context.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
            filled: true,
            // 🎨 Darken the background slightly when locked to show it's disabled
            fillColor: enabled
                ? context.colorScheme.surfaceContainerLowest
                : context.colorScheme.surfaceContainerHighest,
            contentPadding: const EdgeInsets.all(AppDimensions.paddingM),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              borderSide: BorderSide(color: context.colorScheme.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              borderSide: BorderSide(color: context.colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              borderSide: BorderSide(
                color: context.colorScheme.primary,
                width: AppDimensions.borderWidthThick,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              borderSide: BorderSide(color: context.colorScheme.error),
            ),
            // 🚀 ADDED: Specific border style for the disabled state
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              borderSide: BorderSide(
                color: context.colorScheme.outlineVariant.withValues(
                  alpha: 0.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
