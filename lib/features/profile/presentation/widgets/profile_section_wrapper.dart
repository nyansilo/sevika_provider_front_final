import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';

class ProfileSectionWrapper extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const ProfileSectionWrapper({super.key, this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(
              left: AppDimensions.paddingS,
              bottom: AppDimensions.paddingS,
            ),
            child: Text(
              title!,
              style: context.textTheme.titleSmall?.copyWith(
                color: context.colorScheme.outline,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            border: Border.all(
              color: context.colorScheme.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
          // OPTIMIZATION: Swapped ListView.separated for a lightweight Column mapper.
          // This eliminates multi-pass layout calculation inside the scrolling parent screen.
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < children.length; i++) ...[
                children[i],
                if (i < children.length - 1)
                  Divider(
                    height: 1,
                    indent:
                        56, // Perfect aesthetic gutter matching icon alignments
                    color: context.colorScheme.outlineVariant.withValues(
                      alpha: 0.3,
                    ),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
