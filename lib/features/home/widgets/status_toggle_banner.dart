import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';

class StatusToggleBanner extends StatelessWidget {
  final bool isOnline;
  final ValueChanged<bool> onToggle;

  const StatusToggleBanner({
    super.key,
    required this.isOnline,
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
                    isOnline ? 'You are Online' : 'You are Offline',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    isOnline
                        ? 'Receiving job requests nearby'
                        : 'Toggle on to start receiving jobs',
                    style: TextStyle(
                      fontSize: AppDimensions.fontSizeCaption,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Switch.adaptive(
            value: isOnline,
            activeColor: Colors.green,
            onChanged: onToggle,
          ),
        ],
      ),
    );
  }
}
