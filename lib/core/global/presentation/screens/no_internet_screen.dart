// import 'package:flutter/material.dart';
// import '../../constants/app_dimensions.dart';
// import '../../extensions/build_context_extensions.dart';

// class NoInternetScreen extends StatelessWidget {
//   final VoidCallback onRetry;

//   const NoInternetScreen({super.key, required this.onRetry});

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false, // 🛡️ Prevents bypassing via Android back button
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
//                     color: context.colorScheme.errorContainer.withValues(
//                       alpha: 0.3,
//                     ),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Icons.wifi_off_rounded,
//                     size: 80,
//                     color: context.colorScheme.error,
//                   ),
//                 ),
//                 AppDimensions.gapXL,
//                 Text(
//                   'No Internet Connection',
//                   style: context.textTheme.headlineMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: context.colorScheme.onSurface,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 AppDimensions.gapM,
//                 Text(
//                   'It looks like you are offline. Please check your Wi-Fi or cellular data network and try again to continue using Sevika.',
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
//                     onPressed: onRetry,
//                     icon: const Icon(Icons.refresh_rounded),
//                     label: const Text(
//                       'Try Again',
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

// class NoInternetScreen extends StatelessWidget {
//   final VoidCallback onRetry;

//   const NoInternetScreen({super.key, required this.onRetry});

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       child: Scaffold(
//         backgroundColor: context.colorScheme.surface,
//         body: SafeArea(
//           child: Center(
//             child: StatePlaceholder(
//               title: 'No Internet Connection',
//               message:
//                   'It looks like you are offline. Please check your Wi-Fi or cellular data network and try again to continue using Sevika.',
//               icon: Icons.wifi_off_rounded,
//               actionButtonText: 'Try Again',
//               onActionPressed: onRetry,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../extensions/build_context_extensions.dart';
import '../widgets/sevika_state_placeholder.dart';

class NoInternetScreen extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetScreen({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // 🛡️ Prevents bypassing via Android back button
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        body: SafeArea(
          child: Center(
            child: SevikaStatePlaceholder(
              title: 'No Internet Connection',
              message: 'It looks like you are offline. Please check your Wi-Fi or cellular data network and try again to continue using Sevika.',
              icon: Icons.wifi_off_rounded,
              // 🎯 Injecting the custom Error styling specifically for this screen
              iconColor: context.colorScheme.error,
              iconBackgroundColor: context.colorScheme.errorContainer
                  .withValues(alpha: 0.3),
              actionButtonText: 'Try Again',
              actionButtonIcon: Icons.refresh_rounded,
              onActionPressed: onRetry,
            ),
          ),
        ),
      ),
    );
  }
}
