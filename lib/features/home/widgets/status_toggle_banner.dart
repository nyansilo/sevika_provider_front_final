import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';

class StatusToggleBanner extends StatelessWidget {
  final bool isOnline;
  final bool isLoading; // 🚀 ADDED: Loading state flag
  final ValueChanged<bool> onToggle;

  const StatusToggleBanner({
    super.key,
    required this.isOnline,
    this.isLoading =
        false, // 🎯 Default to false so it doesn't break other screens
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: isOnline
            ? Colors.green.withValues(alpha: 0.1)
            : context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: isOnline ? Colors.green : Colors.grey,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                isOnline ? Icons.wifi_tethering : Icons.power_settings_new,
                color: isOnline
                    ? Colors.green
                    : context.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: AppDimensions.paddingS),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // 🚀 DYNAMIC TEXT: Show loading context if processing
                    isLoading
                        ? 'Updating status...'
                        : (isOnline ? 'You are Online' : 'You are Offline'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    // 🚀 DYNAMIC SUBTITLE
                    isLoading
                        ? 'Please wait a moment'
                        : (isOnline
                              ? 'Receiving job requests nearby'
                              : 'Toggle on to start receiving jobs'),
                    style: TextStyle(
                      fontSize: AppDimensions.fontSizeCaption,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // 🚀 THE FIX: Swap the switch for a spinner while loading to prevent spam-taps
          isLoading
              ? const Padding(
                  padding: EdgeInsets.only(right: 12.0, left: 8.0),
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.green,
                    ),
                  ),
                )
              : Switch.adaptive(
                  value: isOnline,
                  activeColor: Colors.green,
                  // Disable the native switch entirely if loading (Defense in depth)
                  onChanged: isLoading ? null : onToggle,
                ),
        ],
      ),
    );
  }
}
