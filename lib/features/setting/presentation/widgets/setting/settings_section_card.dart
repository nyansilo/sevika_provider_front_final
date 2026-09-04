// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_dimensions.dart';

// class SettingsSectionCard extends StatelessWidget {
//   final String title;
//   final List<Widget> children;

//   const SettingsSectionCard({
//     super.key,
//     required this.title,
//     required this.children,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(
//             left: AppDimensions.paddingS,
//             bottom: AppDimensions.paddingS,
//           ),
//           child: Text(
//             title.toUpperCase(),
//             style: theme.textTheme.labelMedium?.copyWith(
//               color: theme.colorScheme.outline,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 1.1,
//             ),
//           ),
//         ),
//         Container(
//           decoration: BoxDecoration(
//             color: theme.colorScheme.surfaceContainerHigh,
//             borderRadius: BorderRadius.circular(AppDimensions.radiusL),
//             border: Border.all(
//               color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
//             ),
//           ),
//           child: ListView.separated(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: children.length,
//             separatorBuilder: (context, index) => Divider(
//               height: 1,
//               indent:
//                   56, // Align cleanly with text bounding boxes past leading icons
//               color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
//             ),
//             itemBuilder: (context, index) => children[index],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart'; // Imported context layer shortcuts

class SettingsSectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSectionCard({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppDimensions.paddingS,
            bottom: AppDimensions.paddingS,
          ),
          child: Text(
            title.toUpperCase(),
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colorScheme.outline,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
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
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: children.length,
            separatorBuilder: (_, _) => Divider(
              height: 1,
              indent:
                  56, // Align cleanly with text bounding boxes past leading icons
              color: context.colorScheme.outlineVariant.withValues(alpha: 0.3),
            ),
            itemBuilder: (_, index) => children[index],
          ),
        ),
      ],
    );
  }
}
