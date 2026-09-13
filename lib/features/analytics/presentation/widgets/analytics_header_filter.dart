import 'package:flutter/material.dart';

import '../../../../core/extensions/build_context_extensions.dart';

class AnalyticsHeaderFilter extends StatelessWidget {
  final String selectedTimeframe;
  final ValueChanged<String?> onTimeframeChanged;

  const AnalyticsHeaderFilter({
    super.key,
    required this.selectedTimeframe,
    required this.onTimeframeChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Map backend/cubit identifiers to human-readable UI dropdown titles
    final Map<String, String> timeframeLabels = {
      'thisWeek': 'This Week',
      'thisMonth': 'This Month',
      'thisYear': 'This Year',
      'allTime': 'All Time',
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Overview',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownButton<String>(
          value: timeframeLabels.containsKey(selectedTimeframe)
              ? selectedTimeframe
              : 'thisMonth',
          underline: const SizedBox(),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: context.colorScheme.primary,
          ),
          style: TextStyle(
            color: context.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
          items: timeframeLabels.entries
              .map(
                (entry) => DropdownMenuItem(
                  value: entry.key,
                  child: Text(entry.value),
                ),
              )
              .toList(),
          onChanged: onTimeframeChanged,
        ),
      ],
    );
  }
}
