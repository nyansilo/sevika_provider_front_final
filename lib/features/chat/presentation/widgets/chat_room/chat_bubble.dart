// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_dimensions.dart';
// import '../../../../../core/extensions/build_context_extensions.dart';

// class ChatBubble extends StatelessWidget {
//   final String message;
//   final String timeString;
//   final bool isMe;

//   // 📍 NEW: Location parameters
//   final bool isLocation;
//   final Map<String, dynamic>? locationMetadata;

//   const ChatBubble({
//     super.key,
//     required this.message,
//     required this.timeString,
//     required this.isMe,
//     this.isLocation = false, // Defaults to false so old code doesn't break
//     this.locationMetadata,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           return ConstrainedBox(
//             constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.72),
//             child: Column(
//               crossAxisAlignment: isMe
//                   ? CrossAxisAlignment.end
//                   : CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: AppDimensions.paddingM,
//                     vertical: AppDimensions.paddingSM,
//                   ),
//                   decoration: BoxDecoration(
//                     color: isMe
//                         ? context.colorScheme.primary
//                         : context.colorScheme.surfaceContainerLow,
//                     borderRadius: BorderRadius.only(
//                       topLeft: const Radius.circular(AppDimensions.radiusM),
//                       topRight: const Radius.circular(AppDimensions.radiusM),
//                       bottomLeft: Radius.circular(
//                         isMe ? AppDimensions.radiusM : AppDimensions.radiusXS,
//                       ),
//                       bottomRight: Radius.circular(
//                         isMe ? AppDimensions.radiusXS : AppDimensions.radiusM,
//                       ),
//                     ),
//                     border: isMe
//                         ? null
//                         : Border.all(
//                             color: context.colorScheme.outlineVariant
//                                 .withValues(
//                                   alpha: AppDimensions.borderAlphaMuted,
//                                 ),
//                             width: AppDimensions.borderWidthThin,
//                           ),
//                   ),
//                   // 📍 NEW: Toggle between standard text and the rich location UI
//                   child: isLocation
//                       ? _buildLocationContent(context)
//                       : _buildTextContent(context),
//                 ),
//                 AppDimensions.gapXXS,
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: AppDimensions.paddingXS,
//                   ),
//                   child: Text(
//                     timeString,
//                     style: context.textTheme.bodySmall?.copyWith(
//                       fontSize: AppDimensions.fontSizeCaption,
//                       color: context.colorScheme.outline,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   /// Standard Text Message UI
//   Widget _buildTextContent(BuildContext context) {
//     return Text(
//       message,
//       style: context.textTheme.bodyMedium?.copyWith(
//         color: isMe
//             ? context.colorScheme.onPrimary
//             : context.colorScheme.onSurface,
//       ),
//     );
//   }

//   /// 📍 Rich Location Message UI
//   Widget _buildLocationContent(BuildContext context) {
//     // Extract metadata safely
//     final String label =
//         locationMetadata?['label']?.toString() ?? 'Shared Location';
//     final dynamic lat = locationMetadata?['latitude'];
//     final dynamic lng = locationMetadata?['longitude'];

//     final Color textColor = isMe
//         ? context.colorScheme.onPrimary
//         : context.colorScheme.onSurface;
//     final Color subTextColor = isMe
//         ? context.colorScheme.onPrimary.withValues(alpha: 0.7)
//         : context.colorScheme.onSurfaceVariant;
//     final Color iconColor = isMe
//         ? context.colorScheme.onPrimary
//         : context.colorScheme.primary;

//     return InkWell(
//       // 🚀 FUTURE TODO: Launch Google Maps or Apple Maps here!
//       onTap: () {
//         if (lat != null && lng != null) {
//           debugPrint('📍 Opening map for Lat: $lat, Lng: $lng');
//         }
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Icon(
//                 Icons.location_on_rounded,
//                 color: iconColor,
//                 size: AppDimensions.iconM,
//               ),
//               AppDimensions.gapXS,
//               Flexible(
//                 child: Text(
//                   label,
//                   style: context.textTheme.titleSmall?.copyWith(
//                     color: textColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           if (lat != null && lng != null) ...[
//             AppDimensions.gapXXS,
//             Text(
//               'Tap to view on map',
//               style: context.textTheme.bodySmall?.copyWith(
//                 color: subTextColor,
//                 fontStyle: FontStyle.italic,
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

// 📍 NEW: Import the map launcher service
import '../../../../../core/services/map_launcher_service.dart';

import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String timeString;
  final bool isMe;

  // 📍 Location parameters
  final bool isLocation;
  final Map<String, dynamic>? locationMetadata;

  const ChatBubble({
    super.key,
    required this.message,
    required this.timeString,
    required this.isMe,
    this.isLocation = false,
    this.locationMetadata,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.72),
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingM,
                    vertical: AppDimensions.paddingSM,
                  ),
                  decoration: BoxDecoration(
                    color: isMe
                        ? context.colorScheme.primary
                        : context.colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(AppDimensions.radiusM),
                      topRight: const Radius.circular(AppDimensions.radiusM),
                      bottomLeft: Radius.circular(
                        isMe ? AppDimensions.radiusM : AppDimensions.radiusXS,
                      ),
                      bottomRight: Radius.circular(
                        isMe ? AppDimensions.radiusXS : AppDimensions.radiusM,
                      ),
                    ),
                    border: isMe
                        ? null
                        : Border.all(
                            color: context.colorScheme.outlineVariant
                                .withValues(
                                  alpha: AppDimensions.borderAlphaMuted,
                                ),
                            width: AppDimensions.borderWidthThin,
                          ),
                  ),
                  // 📍 Toggle between standard text and the rich location UI
                  child: isLocation
                      ? _buildLocationContent(context)
                      : _buildTextContent(context),
                ),
                AppDimensions.gapXXS,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingXS,
                  ),
                  child: Text(
                    timeString,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: AppDimensions.fontSizeCaption,
                      color: context.colorScheme.outline,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Standard Text Message UI
  Widget _buildTextContent(BuildContext context) {
    return Text(
      message,
      style: context.textTheme.bodyMedium?.copyWith(
        color: isMe
            ? context.colorScheme.onPrimary
            : context.colorScheme.onSurface,
      ),
    );
  }

  /// 📍 Rich Location Message UI
  Widget _buildLocationContent(BuildContext context) {
    // Extract metadata safely
    final String label =
        locationMetadata?['label']?.toString() ?? 'Shared Location';
    final double? lat = double.tryParse(
      locationMetadata?['latitude']?.toString() ?? '',
    );
    final double? lng = double.tryParse(
      locationMetadata?['longitude']?.toString() ?? '',
    );

    final Color textColor = isMe
        ? context.colorScheme.onPrimary
        : context.colorScheme.onSurface;
    final Color subTextColor = isMe
        ? context.colorScheme.onPrimary.withValues(alpha: 0.7)
        : context.colorScheme.onSurfaceVariant;
    final Color iconColor = isMe
        ? context.colorScheme.onPrimary
        : context.colorScheme.primary;

    return InkWell(
      // 🚀 NATIVE MAP LAUNCHER
      onTap: () {
        if (lat != null && lng != null) {
          debugPrint('📍 Launching native map for Lat: $lat, Lng: $lng');
          // Calls our new service to open Apple Maps or Google Maps
          MapLauncherService.launchCoordinates(lat, lng, label: label);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_rounded,
                color: iconColor,
                size: AppDimensions.iconM,
              ),
              AppDimensions.gapXS,
              Flexible(
                child: Text(
                  label,
                  style: context.textTheme.titleSmall?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (lat != null && lng != null) ...[
            AppDimensions.gapXXS,
            Text(
              'Tap to view on map',
              style: context.textTheme.bodySmall?.copyWith(
                color: subTextColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
