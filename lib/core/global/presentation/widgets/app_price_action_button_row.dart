// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_dimensions.dart';
// import '../../../../../core/extensions/build_context_extensions.dart';

// class AppPriceActionButtonRow extends StatelessWidget {
//   final String price;
//   final bool isInstantTrack;
//   final VoidCallback onBookTap;

//   const AppPriceActionButtonRow({
//     super.key,
//     required this.price,
//     required this.isInstantTrack,
//     required this.onBookTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: Text(
//             price,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: context.textTheme.bodyMedium?.copyWith(
//               color: isInstantTrack
//                   ? context.colorScheme.primary
//                   : context.colorScheme.secondary,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         IconButton.filledTonal(
//           style: IconButton.styleFrom(
//             visualDensity: VisualDensity.compact,
//             backgroundColor: isInstantTrack
//                 ? null
//                 : context.colorScheme.secondaryContainer,
//             foregroundColor: isInstantTrack
//                 ? null
//                 : context.colorScheme.onSecondaryContainer,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//             ),
//           ),
//           onPressed: onBookTap,
//           icon: Icon(
//             isInstantTrack ? Icons.add_rounded : Icons.arrow_forward_rounded,
//             size: AppDimensions.iconM,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../../../../../core/constants/app_dimensions.dart';
import '../../../../../../../core/extensions/build_context_extensions.dart';

class AppPriceActionButtonRow extends StatelessWidget {
  final String price;
  final Widget? customPriceWidget; // 🚀 ADDED: Optional custom widget for complex text layouts
  final bool isInstantTrack;
  final VoidCallback onBookTap;

  const AppPriceActionButtonRow({
    super.key,
    required this.price,
    this.customPriceWidget, // 🚀 ADDED: Constructor parameter
    required this.isInstantTrack,
    required this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          // 🎯 DYNAMIC RENDERING: Renders the custom RichText if provided, otherwise uses default string
          child:
              customPriceWidget ??
              Text(
                price,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: isInstantTrack
                      ? context.colorScheme.primary
                      : context.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        IconButton.filledTonal(
          style: IconButton.styleFrom(
            visualDensity: VisualDensity.compact,
            backgroundColor: isInstantTrack
                ? null
                : context.colorScheme.secondaryContainer,
            foregroundColor: isInstantTrack
                ? null
                : context.colorScheme.onSecondaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            ),
          ),
          onPressed: onBookTap,
          icon: Icon(
            isInstantTrack ? Icons.add_rounded : Icons.arrow_forward_rounded,
            size: AppDimensions.iconM,
          ),
        ),
      ],
    );
  }
}
