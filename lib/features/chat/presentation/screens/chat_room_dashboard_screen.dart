// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/constants/app_dimensions.dart';
// import '../../../../core/extensions/build_context_extensions.dart';
// import '../cubits/chat_cubit.dart';
// import '../cubits/chat_state.dart';
// import '../widgets/chat_room/chat_room_list_view.dart';

// class ChatRoomDashboardScreen extends StatefulWidget {
//   const ChatRoomDashboardScreen({super.key});

//   @override
//   State<ChatRoomDashboardScreen> createState() =>
//       _ChatRoomDashboardScreenState();
// }

// class _ChatRoomDashboardScreenState extends State<ChatRoomDashboardScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: context.colorScheme.surface,
//       appBar: AppBar(
//         backgroundColor: context.colorScheme.surface,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Messages',
//           style: context.textTheme.titleLarge?.copyWith(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           // 🎯 UPDATED: Wrap icon in BlocBuilder to conditionally disable it when loading
//           BlocBuilder<ChatCubit, ChatState>(
//             builder: (context, state) {
//               final isReady = state is ChatRoomsLoadSuccess;
//               final hasUnread =
//                   isReady && state.rooms.any((r) => r.unreadCount > 0);

//               return IconButton(
//                 icon: const Icon(Icons.done_all_rounded),
//                 // Only enable the button if the state is loaded AND there are unread messages
//                 onPressed: hasUnread
//                     ? () => context.read<ChatCubit>().markAllRoomsAsRead()
//                     : null,
//                 tooltip: 'Mark all as read',
//                 color: hasUnread
//                     ? context.colorScheme.primary
//                     : context.colorScheme.outline.withValues(alpha: 0.5),
//               );
//             },
//           ),
//           AppDimensions.gapS,
//         ],
//         bottom: TabBar(
//           controller: _tabController,
//           isScrollable: false,
//           indicatorSize: TabBarIndicatorSize.tab,
//           indicatorWeight: 3,
//           labelStyle: const TextStyle(fontWeight: FontWeight.bold),
//           unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
//           tabs: const [
//             Tab(text: 'All Chats'),
//             Tab(text: 'Unread'),
//             Tab(text: 'Active Jobs'),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: Center(
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(
//               maxWidth: AppDimensions.maxDashboardWidth,
//             ),
//             child: BlocBuilder<ChatCubit, ChatState>(
//               builder: (context, state) {
//                 if (state is ChatRoomsLoading || state is ChatInitial) {
//                   return const Center(
//                     child: CircularProgressIndicator.adaptive(),
//                   );
//                 }

//                 if (state is ChatRoomsLoadFailure) {
//                   return Center(
//                     child: Text(
//                       state.error.message ??
//                           'An error occurred while loading chats.', // 🎯 Fallback applied
//                       style: context.textTheme.bodyLarge?.copyWith(
//                         color: context.colorScheme.error,
//                       ),
//                     ),
//                   );
//                 }

//                 if (state is ChatRoomsLoadSuccess) {
//                   final allRooms = state.rooms;
//                   final unreadRooms = allRooms
//                       .where((r) => r.unreadCount > 0)
//                       .toList();
//                   final activeRooms = allRooms
//                       .where((r) => r.bookingId.isNotEmpty)
//                       .toList();

//                   return TabBarView(
//                     controller: _tabController,
//                     children: [
//                       ChatRoomListView(chatRooms: allRooms),
//                       ChatRoomListView(chatRooms: unreadRooms),
//                       ChatRoomListView(chatRooms: activeRooms),
//                     ],
//                   );
//                 }

//                 return const SizedBox.shrink();
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/presentation/widgets/sevika_state_placeholder.dart';
import '../cubits/chat_cubit.dart';
import '../cubits/chat_state.dart';
import '../widgets/chat_room/chat_room_list_view.dart';

class ChatRoomDashboardScreen extends StatefulWidget {
  const ChatRoomDashboardScreen({super.key});

  @override
  State<ChatRoomDashboardScreen> createState() =>
      _ChatRoomDashboardScreenState();
}

class _ChatRoomDashboardScreenState extends State<ChatRoomDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Messages',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              final isReady = state is ChatRoomsLoadSuccess;
              final hasUnread =
                  isReady && state.rooms.any((r) => r.unreadCount > 0);

              return IconButton(
                icon: const Icon(Icons.done_all_rounded),
                onPressed: hasUnread
                    ? () => context.read<ChatCubit>().markAllRoomsAsRead()
                    : null,
                tooltip: 'Mark all as read',
                color: hasUnread
                    ? context.colorScheme.primary
                    : context.colorScheme.outline.withValues(alpha: 0.5),
              );
            },
          ),
          AppDimensions.gapS,
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          tabs: const [
            Tab(text: 'All Chats'),
            Tab(text: 'Unread'),
            Tab(text: 'Active Jobs'),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppDimensions.maxDashboardWidth,
            ),
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatRoomsLoading || state is ChatInitial) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                if (state is ChatRoomsLoadFailure) {
                  // 🎯 UPGRADED Error State
                  return SevikaStatePlaceholder(
                    title: 'Load Failed',
                    message:
                        state.error.message ??
                        'An error occurred while loading chats.',
                    icon: Icons.error_outline_rounded,
                    iconColor: context.colorScheme.error,
                    iconBackgroundColor: context.colorScheme.errorContainer
                        .withValues(alpha: 0.3),
                    actionButtonText: 'Try Again',
                    actionButtonIcon: Icons.refresh_rounded,
                    onActionPressed: () =>
                        context.read<ChatCubit>().loadChatRooms(),
                  );
                }

                if (state is ChatRoomsLoadSuccess) {
                  final allRooms = state.rooms;
                  final unreadRooms = allRooms
                      .where((r) => r.unreadCount > 0)
                      .toList();
                  final activeRooms = allRooms
                      .where((r) => r.bookingId.isNotEmpty)
                      .toList();

                  return TabBarView(
                    controller: _tabController,
                    children: [
                      ChatRoomListView(chatRooms: allRooms),
                      ChatRoomListView(chatRooms: unreadRooms),
                      ChatRoomListView(chatRooms: activeRooms),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
