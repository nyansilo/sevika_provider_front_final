import 'package:flutter/material.dart';

import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/presentation/widgets/app_circle_avatar.dart';

class ChatRoomTile extends StatelessWidget {
  final String customerName; // 👨‍🔧 🎯 Renamed from providerName
  final String serviceTag;
  final String lastMessage;
  final String timeString;
  final int unreadCount;
  final String avatarUrl;
  final VoidCallback onTap;

  const ChatRoomTile({
    super.key,
    required this.customerName,
    required this.serviceTag,
    required this.lastMessage,
    required this.timeString,
    required this.unreadCount,
    required this.avatarUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasUnread = unreadCount > 0;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingS,
        ),
        child: Row(
          children: [
            AppCircleAvatar(
              imageUrl: avatarUrl,
              radius: AppDimensions.avatarRadiusM, // Usually 24 or 26
            ),
            AppDimensions.gapM,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          customerName, // 👨‍🔧 Provider sees Customer Name
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: hasUnread
                                ? FontWeight.bold
                                : FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      AppDimensions.gapS,
                      Text(
                        timeString,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: hasUnread
                              ? context.colorScheme.primary
                              : context.colorScheme.outline,
                          fontWeight: hasUnread
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          lastMessage,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: hasUnread
                                ? context.colorScheme.onSurface
                                : context.colorScheme.onSurfaceVariant,
                            fontWeight: hasUnread
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (hasUnread) ...[
                        AppDimensions.gapS,
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            unreadCount > 99 ? '99+' : unreadCount.toString(),
                            style: context.textTheme.labelSmall?.copyWith(
                              color: context.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
