// import 'package:flutter/material.dart';
// import '../../../core/constants/app_dimensions.dart';
// import '../../../core/extensions/build_context_extensions.dart';
// import '../../../core/presentation/widgets/app_circle_avatar.dart';

// class HomeHeader extends StatelessWidget {
//   final String imageUrl;
//   final String locationLabel;
//   final int notificationCount;
//   final VoidCallback? onProfileTap;
//   final VoidCallback? onLocationTap;
//   final VoidCallback? onNotificationTap;
//   final VoidCallback? onSearchTap;
//   final VoidCallback? onFilterTap;

//   const HomeHeader({
//     super.key,
//     required this.imageUrl,
//     required this.locationLabel,
//     this.notificationCount = 0,
//     this.onProfileTap,
//     this.onLocationTap,
//     this.onNotificationTap,
//     this.onSearchTap,
//     this.onFilterTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Upper Row: Profile & Stacked Location Dropdown Hub
//           Row(
//             children: [
//               GestureDetector(
//                 onTap: onProfileTap,
//                 child: AppCircleAvatar(
//                   imageUrl: imageUrl,
//                   radius: AppDimensions.avatarRadiusM,
//                 ),
//               ),
//               AppDimensions.gapM,

//               // Centralized Location Picker Engine
//               Expanded(
//                 child: InkWell(
//                   onTap: onLocationTap,
//                   borderRadius: BorderRadius.circular(AppDimensions.radiusS),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         'Your Location',
//                         style: context.textTheme.labelSmall?.copyWith(
//                           color: context.colorScheme.onSurfaceVariant,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Flexible(
//                             child: Text(
//                               locationLabel,
//                               style: context.textTheme.bodyLarge?.copyWith(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           Icon(
//                             Icons.arrow_drop_down_rounded,
//                             color: context.colorScheme.primary,
//                             size: AppDimensions.iconM,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // Right-aligned Notifications Anchor
//               if (onNotificationTap != null) ...[
//                 AppDimensions.gapS,
//                 IconButton.outlined(
//                   onPressed: onNotificationTap,
//                   icon: Badge(
//                     isLabelVisible: notificationCount > 0,
//                     label: Text(
//                       notificationCount > 99 ? '99+' : '$notificationCount',
//                     ),
//                     child: const Icon(Icons.notifications_none_rounded),
//                   ),
//                 ),
//               ],
//             ],
//           ),
//           AppDimensions.gapL,

//           // Structural Search Input Frame Target
//           GestureDetector(
//             onTap: onSearchTap,
//             child: AbsorbPointer(
//               absorbing: onSearchTap != null,
//               child: SearchBar(
//                 hintText: 'Search for cleaners, plumbers, handymen...',
//                 leading: const Icon(Icons.search_rounded),
//                 trailing: onFilterTap != null
//                     ? [
//                         IconButton(
//                           icon: const Icon(Icons.tune_rounded),
//                           onPressed: onFilterTap,
//                         ),
//                       ]
//                     : null,
//                 elevation: WidgetStateProperty.all(0),
//                 backgroundColor: WidgetStateProperty.all(
//                   context.colorScheme.surfaceContainerLow,
//                 ),
//                 shape: WidgetStateProperty.all(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(AppDimensions.radiusL),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../core/constants/app_dimensions.dart';
import '../../../core/extensions/build_context_extensions.dart';
import '../../../core/global/presentation/widgets/app_circle_avatar.dart';

class HomeHeader extends StatelessWidget {
  final String imageUrl;
  final String locationLabel;
  final int notificationCount;
  final VoidCallback? onProfileTap;
  final VoidCallback? onLocationTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onFilterTap;

  const HomeHeader({
    super.key,
    required this.imageUrl,
    required this.locationLabel,
    this.notificationCount = 0,
    this.onProfileTap,
    this.onLocationTap,
    this.onNotificationTap,
    this.onSearchTap,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n; // 🎯 Cache localization instance

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onProfileTap,
                child: AppCircleAvatar(
                  imageUrl: imageUrl,
                  radius: AppDimensions.avatarRadiusM,
                ),
              ),
              AppDimensions.gapM,

              Expanded(
                child: InkWell(
                  onTap: onLocationTap,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        l10n.yourLocation, // 🎯 Localized
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              locationLabel, // (City is passed dynamically)
                              style: context.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down_rounded,
                            color: context.colorScheme.primary,
                            size: AppDimensions.iconM,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              if (onNotificationTap != null) ...[
                AppDimensions.gapS,
                IconButton.outlined(
                  onPressed: onNotificationTap,
                  icon: Badge(
                    isLabelVisible: notificationCount > 0,
                    label: Text(
                      notificationCount > 99 ? '99+' : '$notificationCount',
                    ),
                    child: const Icon(Icons.notifications_none_rounded),
                  ),
                ),
              ],
            ],
          ),
          AppDimensions.gapL,

          GestureDetector(
            onTap: onSearchTap,
            child: AbsorbPointer(
              absorbing: onSearchTap != null,
              child: SearchBar(
                hintText: l10n.searchHintPlumbers, // 🎯 Localized
                leading: const Icon(Icons.search_rounded),
                trailing: onFilterTap != null
                    ? [
                        IconButton(
                          icon: const Icon(Icons.tune_rounded),
                          onPressed: onFilterTap,
                        ),
                      ]
                    : null,
                elevation: WidgetStateProperty.all(0),
                backgroundColor: WidgetStateProperty.all(
                  context.colorScheme.surfaceContainerLow,
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
