import 'package:flutter/material.dart';

import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';

class PriceTypeSelector extends StatelessWidget {
  final String selectedType;
  final ValueChanged<String> onChanged;

  const PriceTypeSelector({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final types = ['Fixed Price', 'Hourly Rate', 'Starting At'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pricing Model',
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
        AppDimensions.gapXS,
        Wrap(
          spacing: AppDimensions.paddingS,
          runSpacing: AppDimensions.paddingS,
          children: types.map((type) {
            final isSelected = selectedType == type;
            return ChoiceChip(
              label: Text(type),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) onChanged(type);
              },
              selectedColor: context.colorScheme.primaryContainer,
              backgroundColor: context.colorScheme.surfaceContainerHighest,
              labelStyle: TextStyle(
                color: isSelected
                    ? context.colorScheme.onPrimaryContainer
                    : context.colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                side: BorderSide(
                  color: isSelected
                      ? context.colorScheme.primary
                      : Colors.transparent,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
