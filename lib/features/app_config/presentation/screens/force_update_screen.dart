// import 'package:flutter/material.dart';
// import '../../constants/app_dimensions.dart';
// import '../../extensions/build_context_extensions.dart';

// class ForceUpdateScreen extends StatelessWidget {
//   final String storeUrl; // Pass iOS App Store or Google Play URL

//   const ForceUpdateScreen({super.key, required this.storeUrl});

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false, // 🛡️ Hard lock
//       child: Scaffold(
//         backgroundColor: context.colorScheme.surface,
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(AppDimensions.paddingL),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(AppDimensions.paddingXXL),
//                   decoration: BoxDecoration(
//                     color: context.colorScheme.primaryContainer.withValues(
//                       alpha: 0.3,
//                     ),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Icons.system_update_rounded,
//                     size: 80,
//                     color: context.colorScheme.primary,
//                   ),
//                 ),
//                 AppDimensions.gapXL,
//                 Text(
//                   'Time for an Update!',
//                   style: context.textTheme.headlineMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 AppDimensions.gapM,
//                 Text(
//                   'We have added new features and squashed some bugs. To ensure you have the best and most secure experience, please update Sevika to the latest version.',
//                   style: context.textTheme.bodyLarge?.copyWith(
//                     color: context.colorScheme.onSurfaceVariant,
//                     height: 1.5,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 AppDimensions.gapXXL,
//                 SizedBox(
//                   width: double.infinity,
//                   height: 54,
//                   child: FilledButton.icon(
//                     onPressed: () {
//                       // Trigger URL Launcher to open storeUrl
//                     },
//                     icon: const Icon(Icons.file_download_rounded),
//                     label: const Text(
//                       'Update Now',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     style: FilledButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(
//                           AppDimensions.radiusL,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../../extensions/build_context_extensions.dart';
// import '../widgets/app_state_placeholder.dart';

// class ForceUpdateScreen extends StatelessWidget {
//   final String storeUrl;

//   const ForceUpdateScreen({super.key, required this.storeUrl});

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       child: Scaffold(
//         backgroundColor: context.colorScheme.surface,
//         body: SafeArea(
//           child: Center(
//             child: StatePlaceholder(
//               title: 'Time for an Update!',
//               message:
//                   'We have added new features and squashed some bugs. To ensure you have the best and most secure experience, please update Sevika to the latest version.',
//               icon: Icons.system_update_rounded,
//               actionButtonText: 'Update Now',
//               onActionPressed: () {
//                 // Trigger URL Launcher to open storeUrl here
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../../../../core/extensions/build_context_extensions.dart';
// import '../../../../core/presentation/widgets/app_state_placeholder.dart';

// class ForceUpdateScreen extends StatelessWidget {
//   final String storeUrl;

//   const ForceUpdateScreen({super.key, required this.storeUrl});

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false, // 🛡️ Hard lock
//       child: Scaffold(
//         backgroundColor: context.colorScheme.surface,
//         body: SafeArea(
//           child: Center(
//             child: SevikaStatePlaceholder(
//               title: 'Time for an Update!',
//               message:
//                   'We have added new features and squashed some bugs. To ensure you have the best and most secure experience, please update Sevika to the latest version.',
//               icon: Icons.system_update_rounded,
//               iconColor: context.colorScheme.primary,
//               iconBackgroundColor: context.colorScheme.primaryContainer
//                   .withValues(alpha: 0.3),
//               actionButtonText: 'Update Now',
//               actionButtonIcon: Icons.file_download_rounded,
//               onActionPressed: () {
//                 // Trigger URL Launcher to open storeUrl
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // 📦 ADDED: url_launcher import

import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/global/presentation/widgets/sevika_state_placeholder.dart';

class ForceUpdateScreen extends StatelessWidget {
  final String storeUrl;

  const ForceUpdateScreen({super.key, required this.storeUrl});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // 🛡️ Hard lock prevents physical/swipe back gestures
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        body: SafeArea(
          child: Center(
            child: SevikaStatePlaceholder(
              title: 'Time for an Update!',
              message: 'We have added new features and squashed some bugs. To ensure you have the best and most secure experience, please update Sevika to the latest version.',
              icon: Icons.system_update_rounded,
              iconColor: context.colorScheme.primary,
              iconBackgroundColor: context.colorScheme.primaryContainer
                  .withValues(alpha: 0.3),
              actionButtonText: 'Update Now',
              actionButtonIcon: Icons.file_download_rounded,
              onActionPressed: () async {
                // 🚀 URL Launcher implementation
                final Uri url = Uri.parse(storeUrl);

                try {
                  if (await canLaunchUrl(url)) {
                    await launchUrl(
                      url,
                      // 🎯 INDUSTRY PRACTICE: Forces the OS to handle the link in the native
                      // Play Store or App Store app instead of a webview.
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    debugPrint('Could not launch store URL: $storeUrl');
                  }
                } catch (e) {
                  debugPrint('Error launching store URL: $e');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
