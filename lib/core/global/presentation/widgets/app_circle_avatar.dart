// import 'package:flutter/material.dart';
// import '../../constants/app_dimensions.dart';
// import '../../extensions/build_context_extensions.dart';
// import 'app_image_placeholder.dart';

// class AppCircleAvatar extends StatelessWidget {
//   final String imageUrl;
//   final double radius;
//   final IconData fallbackIcon;

//   const AppCircleAvatar({
//     super.key,
//     required this.imageUrl,
//     this.radius = AppDimensions.avatarRadiusM,
//     this.fallbackIcon = Icons.person_rounded,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final double diameter = radius * 2;

//     return ClipOval(
//       child: Container(
//         width: diameter,
//         height: diameter,
//         color: context.colorScheme.primaryContainer,
//         child: imageUrl.trim().isNotEmpty
//             ? Image.network(
//                 imageUrl,
//                 width: diameter,
//                 height: diameter,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) =>
//                     AppImagePlaceholder(icon: fallbackIcon, iconSize: radius),
//                 loadingBuilder: (context, child, loadingProgress) {
//                   if (loadingProgress == null) return child;
//                   return Center(
//                     child: SizedBox(
//                       width: radius,
//                       height: radius,
//                       child: CircularProgressIndicator(
//                         strokeWidth: AppDimensions.borderWidthThin,
//                         value: loadingProgress.expectedTotalBytes != null
//                             ? loadingProgress.cumulativeBytesLoaded /
//                                   loadingProgress.expectedTotalBytes!
//                             : null,
//                       ),
//                     ),
//                   );
//                 },
//               )
//             : AppImagePlaceholder(icon: fallbackIcon, iconSize: radius),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../constants/app_dimensions.dart';
import '../../../extensions/build_context_extensions.dart';
import 'app_image_placeholder.dart';
import 'app_network_image.dart'; // 🎯 ADD THIS IMPORT

class AppCircleAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final IconData fallbackIcon;

  const AppCircleAvatar({
    super.key,
    required this.imageUrl,
    this.radius = AppDimensions.avatarRadiusM,
    this.fallbackIcon = Icons.person_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final double diameter = radius * 2;

    return ClipOval(
      child: Container(
        width: diameter,
        height: diameter,
        color: context.colorScheme.primaryContainer,
        child: imageUrl.trim().isNotEmpty
            // 🎯 FIXED: Replaced raw Image.network with your bulletproof AppNetworkImage
            ? AppNetworkImage(
                imageUrl: imageUrl,
                width: diameter,
                height: diameter,
                fit: BoxFit.cover,
                errorIcon: fallbackIcon,
              )
            : AppImagePlaceholder(icon: fallbackIcon, iconSize: radius),
      ),
    );
  }
}
