import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';

class AddressPresetSelector extends StatelessWidget {
  final String selectedType;
  final Function(String) onSelected;

  const AddressPresetSelector({
    super.key,
    required this.selectedType,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ['Home', 'Work', 'Office', 'Custom'].map((type) {
        final isSelected = selectedType == type;
        return Padding(
          padding: const EdgeInsets.only(right: AppDimensions.size8),
          child: ChoiceChip(
            label: Text(type),
            selected: isSelected,
            onSelected: (_) => onSelected(type),
            selectedColor: context.colorScheme.primaryContainer,
            labelStyle: context.textTheme.bodyMedium?.copyWith(
              color: isSelected
                  ? context.colorScheme.onPrimaryContainer
                  : context.colorScheme.onSurfaceVariant,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      }).toList(),
    );
  }
}
