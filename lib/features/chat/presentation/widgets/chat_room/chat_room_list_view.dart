import 'package:flutter/material.dart';

import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';

import '../../../../../core/extensions/date_formatter_extension.dart';
import '../../../../../core/routes/route_list.dart';
import '../../../domain/entities/chat_room_entity.dart';
import '../../args/inbox_screen_args.dart';
import '../inbox/chat_room_tile.dart';

class ChatRoomListView extends StatelessWidget {
  final List<ChatRoomEntity> chatRooms;

  const ChatRoomListView({super.key, required this.chatRooms});

  @override
  Widget build(BuildContext context) {
    if (chatRooms.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline_rounded,
              size: AppDimensions.iconL * 2,
              color: context.colorScheme.outline,
            ),
            AppDimensions.gapM,
            Text(
              'No conversations found',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.outline,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingS),
      itemCount: chatRooms.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        indent: 76,
        color: context.colorScheme.outlineVariant.withValues(alpha: 0.2),
      ),
      itemBuilder: (context, index) {
        final room = chatRooms[index];

        return ChatRoomTile(
          // 👨‍🔧 PROVIDER PERSPECTIVE: The "recipient" of these messages is the Customer.
          // Note: If your ChatRoomTile still uses the variable 'providerName', you should rename
          // it to 'customerName' or simply 'name' in that file to keep things clean!
          customerName: room.recipient.fullName,

          // Customers don't have business names, so we just label them as 'Client'
          // or you could pass the actual requested service name if your entity supports it.
          serviceTag: 'Client',

          lastMessage: room.lastMessage ?? 'No messages yet',
          timeString: room.lastMessageTime?.toSimpleTime() ?? '',
          unreadCount: room.unreadCount,
          avatarUrl: room.recipient.avatarUrl,

          onTap: () {
            // 🎯 CLEAN ARCHITECTURE UPGRADE:
            // Now uses the strictly-typed Provider-facing InboxScreenArgs DTO.
            // This prevents crashes and ensures the Call Feature gets the customerId it needs!
            Navigator.pushNamed(
              context,
              RouteList.inboxPage,
              arguments: InboxScreenArgs(
                roomId: room.roomId,

                // 📞 Required for Agora Calls to ring the Customer's device
                customerId: room.recipient.id.toString(),

                customerName: room.recipient.fullName,

                // 👨‍🔧 Fallback job title. If your ChatRoomEntity has a reference
                // to the actual booking, pass `room.booking.serviceName` here!
                jobTitle: 'Service Request',

                avatarUrl: room.recipient.avatarUrl,

                customerPhone:
                    room.recipient.phoneNumber ??
                    '', // Fallback to empty if null
                // 🎯 If your ChatRoomEntity fetches the booking data, pass it here
                // so the provider can click "View Job" in the chat app bar:
                // bookingEntity: room.booking,
              ),
            );
          },
        );
      },
    );
  }
}
