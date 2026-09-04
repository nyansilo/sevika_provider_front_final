import 'package:flutter/material.dart';

import '../../../core/constants/app_dimensions.dart';
import '../../../core/extensions/build_context_extensions.dart'; // 🎯 ADDED: For localization

class HomeSectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onTapAll;

  const HomeSectionHeader({
    super.key,
    required this.title,
    required this.onTapAll,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n; // 🎯 Cache localization

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 🚀 FIXED: Wrap in Expanded to prevent layout overflow for long Swahili text
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1, // 🚀 Prevents wrapping to a second line
              overflow: TextOverflow.ellipsis, // 🚀 Adds "..." if it's too long
            ),
          ),

          // 🎯 Adds a tiny buffer space so the text never touches the button
          const SizedBox(width: AppDimensions.paddingS),

          TextButton(
            onPressed: onTapAll,
            child: Text(l10n.seeAll), // 🎯 Localized "See All"
          ),
        ],
      ),
    );
  }
}
