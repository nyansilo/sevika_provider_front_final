import 'package:flutter/material.dart';

import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';

class CategoryDropdownField extends StatelessWidget {
  final String? selectedCategory;
  final List<String> categories;
  final ValueChanged<String?> onChanged;

  const CategoryDropdownField({
    super.key,
    required this.selectedCategory,
    required this.categories,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Service Category',
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
        AppDimensions.gapXS,
        DropdownButtonFormField<String>(
          value: selectedCategory,
          icon: Icon(Icons.arrow_drop_down, color: context.colorScheme.primary),
          decoration: InputDecoration(
            filled: true,
            fillColor: context.colorScheme.surfaceContainerLowest,
            contentPadding: const EdgeInsets.all(AppDimensions.paddingM),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              borderSide: BorderSide(color: context.colorScheme.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              borderSide: BorderSide(color: context.colorScheme.outlineVariant),
            ),
          ),
          hint: const Text('Select a category'),
          items: categories.map((category) {
            return DropdownMenuItem(value: category, child: Text(category));
          }).toList(),
          onChanged: onChanged,
          validator: (value) =>
              value == null ? 'Please select a category' : null,
        ),
      ],
    );
  }
}
