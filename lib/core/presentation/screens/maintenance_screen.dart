// import 'package:flutter/material.dart';
// import '../../constants/app_dimensions.dart';
// import '../../extensions/build_context_extensions.dart';

// class MaintenanceScreen extends StatelessWidget {
//   final String? estimatedCompletionTime;

//   const MaintenanceScreen({super.key, this.estimatedCompletionTime});

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
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
//                     color: context.colorScheme.secondaryContainer.withValues(
//                       alpha: 0.3,
//                     ),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Icons.handyman_rounded,
//                     size: 80,
//                     color: context.colorScheme.secondary,
//                   ),
//                 ),
//                 AppDimensions.gapXL,
//                 Text(
//                   'We\'ll be right back',
//                   style: context.textTheme.headlineMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 AppDimensions.gapM,
//                 Text(
//                   'Sevika is currently undergoing scheduled maintenance to improve your experience. Thank you for your patience!',
//                   style: context.textTheme.bodyLarge?.copyWith(
//                     color: context.colorScheme.onSurfaceVariant,
//                     height: 1.5,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 if (estimatedCompletionTime != null) ...[
//                   AppDimensions.gapL,
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: AppDimensions.paddingL,
//                       vertical: AppDimensions.paddingS,
//                     ),
//                     decoration: BoxDecoration(
//                       color: context.colorScheme.surfaceContainerHighest,
//                       borderRadius: BorderRadius.circular(
//                         AppDimensions.radiusM,
//                       ),
//                     ),
//                     child: Text(
//                       'Expected return: $estimatedCompletionTime',
//                       style: context.textTheme.labelLarge?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: context.colorScheme.onSurfaceVariant,
//                       ),
//                     ),
//                   ),
//                 ],
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

// class MaintenanceScreen extends StatelessWidget {
//   final String? estimatedCompletionTime;

//   const MaintenanceScreen({super.key, this.estimatedCompletionTime});

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       child: Scaffold(
//         backgroundColor: context.colorScheme.surface,
//         body: SafeArea(
//           child: Center(
//             child: StatePlaceholder(
//               title: 'We\'ll be right back',
//               message:
//                   'Sevika is currently undergoing scheduled maintenance to improve your experience. Thank you for your patience!'
//                   '${estimatedCompletionTime != null ? '\n\nExpected return: $estimatedCompletionTime' : ''}',
//               icon: Icons.handyman_rounded,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../extensions/build_context_extensions.dart';
import '../widgets/sevika_state_placeholder.dart';

class MaintenanceScreen extends StatelessWidget {
  final String? estimatedCompletionTime;

  const MaintenanceScreen({super.key, this.estimatedCompletionTime});

  @override
  Widget build(BuildContext context) {
    // 🎯 Dynamically append the ETA to the message if it exists
    final etaText = estimatedCompletionTime != null
        ? '\n\nExpected return: $estimatedCompletionTime'
        : '';

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        body: SafeArea(
          child: Center(
            child: SevikaStatePlaceholder(
              title: 'We\'ll be right back',
              message:
                  'Sevika is currently undergoing scheduled maintenance to improve your experience. Thank you for your patience!$etaText',
              icon: Icons.handyman_rounded,
              iconColor: context.colorScheme.secondary,
              iconBackgroundColor: context.colorScheme.secondaryContainer
                  .withValues(alpha: 0.3),
            ),
          ),
        ),
      ),
    );
  }
}
