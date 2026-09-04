// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../core/constants/app_dimensions.dart';
// import '../../../../core/extensions/build_context_extensions.dart';
// import '../../../../core/routes/route_list.dart';
// import '../../../../core/di/service_locator.dart'; // 🚨 Required for dialog injection
// import '../../../chat/presentation/args/inbox_screen_args.dart';
// import '../../domain/entities/notification_item_entity.dart';
// import '../../domain/entities/notification_type.dart';
// import '../cubits/notification/notifications_cubit.dart';
// import '../cubits/notification/notifications_state.dart';
// import '../widgets/notification_item_tile.dart';

// // 🚨 IMPORT THE EMERGENCY CUBIT & ALERT DIALOG WIDGET
// import '../../../emergency/presentation/cubits/accept_emergency_cubit.dart';
// import '../../../emergency/presentation/widgets/incoming_emergency_alert.dart';

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   Map<String, dynamic> _resolveItemStyle(
//     ThemeData theme,
//     NotificationItemEntity item,
//   ) {
//     if (item.type == NotificationType.payment) {
//       final state = item.data.metadata.state;
//       if (state == 'failed') {
//         return {
//           'icon': Icons.sms_failed_rounded,
//           'color': theme.colorScheme.error,
//           'bg': theme.colorScheme.errorContainer.withValues(alpha: 0.4),
//         };
//       } else if (state == 'refunded') {
//         return {
//           'icon': Icons.published_with_changes_rounded,
//           'color': theme.colorScheme.tertiary,
//           'bg': theme.colorScheme.tertiaryContainer.withValues(alpha: 0.4),
//         };
//       }
//       return {
//         'icon': Icons.payment_rounded,
//         'color': Colors.green,
//         'bg': Colors.green.withValues(alpha: 0.15),
//       };
//     }

//     if (item.type == NotificationType.booking) {
//       final status = item.data.metadata.status?.toLowerCase();
//       if (status == 'cancelled') {
//         return {
//           'icon': Icons.cancel_outlined,
//           'color': theme.colorScheme.error,
//           'bg': theme.colorScheme.errorContainer.withValues(alpha: 0.2),
//         };
//       } else if (status == 'completed') {
//         return {
//           'icon': Icons.check_circle_outline_rounded,
//           'color': Colors.teal,
//           'bg': Colors.teal.withValues(alpha: 0.15),
//         };
//       }
//       return {
//         'icon': Icons.calendar_today_rounded,
//         'color': theme.colorScheme.primary,
//         'bg': theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
//       };
//     }

//     if (item.type == NotificationType.chat) {
//       return {
//         'icon': Icons.chat_bubble_outline_rounded,
//         'color': Colors.blueAccent,
//         'bg': Colors.blueAccent.withValues(alpha: 0.15),
//       };
//     }

//     // 🚨 EMERGENCY SOS STYLE
//     if (item.type == NotificationType.emergency) {
//       return {
//         'icon': Icons.emergency_share_rounded,
//         'color': theme.colorScheme.error,
//         'bg': theme.colorScheme.errorContainer.withValues(alpha: 0.8),
//       };
//     }

//     // 🛒 MARKETPLACE JOB STYLE
//     if (item.type == NotificationType.job) {
//       return {
//         'icon': Icons.work_outline_rounded,
//         'color': Colors.indigo,
//         'bg': Colors.indigo.withValues(alpha: 0.15),
//       };
//     }

//     // 📈 WAITLIST DEMAND STYLE
//     if (item.type == NotificationType.waitlist) {
//       return {
//         'icon': Icons.trending_up_rounded, // 📈 Demand indicator
//         'color': Colors.deepOrange,
//         'bg': Colors.deepOrange.withValues(alpha: 0.15),
//       };
//     }

//     final Map<NotificationType, Map<String, dynamic>> staticStyles = {
//       NotificationType.wallet: {
//         'icon': Icons.account_balance_wallet_rounded,
//         'color': Colors.purple,
//         'bg': Colors.purple.withValues(alpha: 0.15),
//       },
//       NotificationType.system: {
//         'icon': Icons.notifications_outlined,
//         'color': theme.colorScheme.outline,
//         'bg': theme.colorScheme.surfaceContainerHigh,
//       },
//     };

//     return staticStyles[item.type] ?? staticStyles[NotificationType.system]!;
//   }

//   void _handleNotificationTap(
//     BuildContext context,
//     NotificationItemEntity item,
//   ) {
//     context.read<NotificationsCubit>().markNotificationAsRead(item.id);

//     // 💬 CHAT ROUTING RESTORED: Now strictly mapped to the Provider's InboxScreenArgs
//     if (item.type == NotificationType.chat &&
//         item.data.metadata.roomId != null) {
//       String resolvedName = item.data.metadata.senderName ?? 'New Message';
//       if (resolvedName == 'New Message' && item.data.title.contains('from')) {
//         resolvedName = item.data.title.split('from ').last;
//       }

//       Navigator.pushNamed(
//         context,
//         RouteList.inboxPage,
//         arguments: InboxScreenArgs(
//           roomId: item.data.metadata.roomId.toString(),
//           customerId: item.data.metadata.senderId.toString(),
//           customerName: resolvedName,
//           jobTitle: item.data.metadata.serviceTag ?? 'Chat',
//           avatarUrl: item.data.metadata.senderAvatar ?? '',
//           customerPhone: item.data.metadata.senderPhone ?? '',
//         ),
//       );
//       return;
//     }

//     switch (item.type) {
//       case NotificationType.booking:
//         final status = item.data.metadata.status?.toLowerCase();

//         int targetTabIndex = 0; // Default to Requests (Index 0)

//         if (status == 'completed' ||
//             status == 'cancelled' ||
//             status == 'declined') {
//           targetTabIndex = 2; // History Tab (Index 2)
//         } else if (status == 'confirmed' ||
//             status == 'en_route' ||
//             status == 'in_progress' ||
//             status == 'pending_payment') {
//           targetTabIndex = 1; // Active Tab (Index 1)
//         } else {
//           targetTabIndex = 0; // Requests Tab (Index 0: pending, awaiting_estimate, quote_provided)
//         }

//         Navigator.pushNamed(
//           context,
//           RouteList.bookingDashboardPage,
//           arguments: targetTabIndex,
//         );
//         break;
//       case NotificationType.wallet:
//       case NotificationType.payment:
//         Navigator.pushNamed(context, RouteList.walletDashboardPage);
//         break;

//       case NotificationType.waitlist:
//         Navigator.pushNamed(context, RouteList.waitlistPage);
//         break;

//       // 🚨 EMERGENCY ROUTING
//       case NotificationType.emergency:
//         if (item.data.metadata.dispatchId != null) {
//           if (item.data.metadata.metadataType == 'emergency_cancelled') {
//             context.showSnackBar(
//               'This emergency has been cancelled.',
//               type: SnackBarType.info,
//             );
//             return;
//           }

//           // When the provider taps the incoming alert dialog and accepts it,
//           // ensure that once accepted, they land on the Active Bookings tab (0).
//           showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (_) => BlocProvider<AcceptEmergencyCubit>(
//               create: (_) => sl<AcceptEmergencyCubit>(),
//               child: IncomingEmergencyAlert(
//                 dispatchId: item.data.metadata.dispatchId!,
//                 category: item.data.title,
//                 addressText:
//                     item.data.metadata.addressText ??
//                     'Location provided via GPS',
//               ),
//             ),
//           );
//         }
//         break;

//       // 🛒 MARKETPLACE ROUTING
//       case NotificationType.job:
//         Navigator.pushNamed(context, RouteList.exploreMarketplacePage);
//         break;

//       case NotificationType.system:
//       default:
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: theme.colorScheme.surface,
//       appBar: AppBar(
//         backgroundColor: theme.colorScheme.surface,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Notifications',
//           style: theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           BlocBuilder<NotificationsCubit, NotificationsState>(
//             builder: (context, state) {
//               final bool hasItems =
//                   state is NotificationsLoadSuccess &&
//                   state.notifications.isNotEmpty;

//               if (!hasItems) return const SizedBox.shrink();

//               return PopupMenuButton<String>(
//                 icon: const Icon(Icons.more_vert_rounded),
//                 onSelected: (value) {
//                   if (value == 'read') {
//                     context
//                         .read<NotificationsCubit>()
//                         .markAllNotificationsAsRead();
//                   } else if (value == 'clear') {
//                     context
//                         .read<NotificationsCubit>()
//                         .clearAllNotificationHistory();
//                   }
//                 },
//                 itemBuilder: (context) => [
//                   const PopupMenuItem(
//                     value: 'read',
//                     child: Row(
//                       children: [
//                         Icon(Icons.done_all_rounded, size: 18),
//                         SizedBox(width: 8),
//                         Text('Mark all read'),
//                       ],
//                     ),
//                   ),
//                   PopupMenuItem(
//                     value: 'clear',
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.delete_sweep_rounded,
//                           size: 18,
//                           color: theme.colorScheme.error,
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           'Clear all history',
//                           style: TextStyle(color: theme.colorScheme.error),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//           const SizedBox(width: 4),
//         ],
//       ),
//       body: SafeArea(
//         child: Center(
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(
//               maxWidth: AppDimensions.maxDashboardWidth,
//             ),
//             child: BlocBuilder<NotificationsCubit, NotificationsState>(
//               builder: (context, state) {
//                 if (state is NotificationsFirstPageLoading) {
//                   return const Center(
//                     child: CircularProgressIndicator.adaptive(),
//                   );
//                 }

//                 if (state is NotificationsLoadFailure) {
//                   return _buildErrorState(
//                     theme,
//                     state.error.message ?? 'Failed to load notifications',
//                   );
//                 }

//                 if (state is NotificationsLoadSuccess) {
//                   final notifications = state.notifications;

//                   if (notifications.isEmpty) {
//                     return _buildEmptyState(theme);
//                   }

//                   return RefreshIndicator.adaptive(
//                     onRefresh: () =>
//                         context.read<NotificationsCubit>().loadNotifications(),
//                     child: ListView.separated(
//                       padding: const EdgeInsets.all(AppDimensions.paddingM),
//                       itemCount: notifications.length,
//                       separatorBuilder: (context, index) => AppDimensions.gapM,
//                       itemBuilder: (context, index) {
//                         final item = notifications[index];
//                         final style = _resolveItemStyle(theme, item);

//                         final String cleanTime = item.createdAt.length > 16
//                             ? item.createdAt.substring(11, 16)
//                             : item.createdAt;

//                         return Dismissible(
//                           key: Key(item.id),
//                           direction: DismissDirection.endToStart,
//                           background: Container(
//                             alignment: Alignment.centerRight,
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: AppDimensions.paddingL,
//                             ),
//                             decoration: BoxDecoration(
//                               color: theme.colorScheme.errorContainer
//                                   .withValues(alpha: 0.8),
//                               borderRadius: BorderRadius.circular(
//                                 AppDimensions.radiusM,
//                               ),
//                             ),
//                             child: Icon(
//                               Icons.delete_outline_rounded,
//                               color: theme.colorScheme.onErrorContainer,
//                             ),
//                           ),
//                           onDismissed: (direction) {
//                             context
//                                 .read<NotificationsCubit>()
//                                 .removeSingleNotification(item.id);
//                           },
//                           child: NotificationItemTile(
//                             title: item.data.title,
//                             description: item.data.message,
//                             timestamp: cleanTime,
//                             icon: style['icon'] as IconData,
//                             iconColor: style['color'] as Color,
//                             iconBackgroundColor: style['bg'] as Color,
//                             isRead: item.isRead,
//                             onTap: () => _handleNotificationTap(context, item),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 }

//                 return _buildEmptyState(theme);
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState(ThemeData theme) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           Icons.notifications_off_outlined,
//           size: 64,
//           color: theme.colorScheme.outline,
//         ),
//         AppDimensions.gapM,
//         Text(
//           'All Caught Up!',
//           style: theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         AppDimensions.gapXS,
//         Text(
//           'Your active notification stream log is currently empty.',
//           textAlign: TextAlign.center,
//           style: theme.textTheme.bodyMedium?.copyWith(
//             color: theme.colorScheme.onSurfaceVariant,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildErrorState(ThemeData theme, String message) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           Icons.error_outline_rounded,
//           size: 48,
//           color: theme.colorScheme.error,
//         ),
//         AppDimensions.gapM,
//         Text(
//           message,
//           textAlign: TextAlign.center,
//           style: theme.textTheme.bodyMedium,
//         ),
//         AppDimensions.gapS,
//         ElevatedButton(
//           onPressed: () =>
//               context.read<NotificationsCubit>().loadNotifications(),
//           child: const Text('Retry'),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/routes/route_list.dart';
import '../../../../core/di/service_locator.dart';
import '../../../chat/presentation/args/inbox_screen_args.dart';
import '../../domain/entities/notification_item_entity.dart';
import '../../domain/entities/notification_type.dart';
import '../cubits/notification/notifications_cubit.dart';
import '../cubits/notification/notifications_state.dart';
import '../widgets/notification_item_tile.dart';

// 🚨 IMPORT THE EMERGENCY CUBIT & ALERT DIALOG WIDGET
import '../../../emergency/presentation/cubits/accept_emergency_cubit.dart';
import '../../../emergency/presentation/widgets/incoming_emergency_alert.dart';

// 🎯 IMPORT THE ROOT LAYOUT (Ensure this path is correct for your project!)
import '../../../main_layout/presentation/screens/main_layout_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Map<String, dynamic> _resolveItemStyle(
    ThemeData theme,
    NotificationItemEntity item,
  ) {
    if (item.type == NotificationType.payment) {
      final state = item.data.metadata.state;
      if (state == 'failed') {
        return {
          'icon': Icons.sms_failed_rounded,
          'color': theme.colorScheme.error,
          'bg': theme.colorScheme.errorContainer.withValues(alpha: 0.4),
        };
      } else if (state == 'refunded') {
        return {
          'icon': Icons.published_with_changes_rounded,
          'color': theme.colorScheme.tertiary,
          'bg': theme.colorScheme.tertiaryContainer.withValues(alpha: 0.4),
        };
      }
      return {
        'icon': Icons.payment_rounded,
        'color': Colors.green,
        'bg': Colors.green.withValues(alpha: 0.15),
      };
    }

    if (item.type == NotificationType.booking) {
      final status = item.data.metadata.status?.toLowerCase();
      if (status == 'cancelled') {
        return {
          'icon': Icons.cancel_outlined,
          'color': theme.colorScheme.error,
          'bg': theme.colorScheme.errorContainer.withValues(alpha: 0.2),
        };
      } else if (status == 'completed') {
        return {
          'icon': Icons.check_circle_outline_rounded,
          'color': Colors.teal,
          'bg': Colors.teal.withValues(alpha: 0.15),
        };
      }
      return {
        'icon': Icons.calendar_today_rounded,
        'color': theme.colorScheme.primary,
        'bg': theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
      };
    }

    if (item.type == NotificationType.chat) {
      return {
        'icon': Icons.chat_bubble_outline_rounded,
        'color': Colors.blueAccent,
        'bg': Colors.blueAccent.withValues(alpha: 0.15),
      };
    }

    if (item.type == NotificationType.emergency) {
      return {
        'icon': Icons.emergency_share_rounded,
        'color': theme.colorScheme.error,
        'bg': theme.colorScheme.errorContainer.withValues(alpha: 0.8),
      };
    }

    if (item.type == NotificationType.job) {
      return {
        'icon': Icons.work_outline_rounded,
        'color': Colors.indigo,
        'bg': Colors.indigo.withValues(alpha: 0.15),
      };
    }

    if (item.type == NotificationType.waitlist) {
      return {
        'icon': Icons.trending_up_rounded, // 📈 Demand indicator
        'color': Colors.deepOrange,
        'bg': Colors.deepOrange.withValues(alpha: 0.15),
      };
    }

    final Map<NotificationType, Map<String, dynamic>> staticStyles = {
      NotificationType.wallet: {
        'icon': Icons.account_balance_wallet_rounded,
        'color': Colors.purple,
        'bg': Colors.purple.withValues(alpha: 0.15),
      },
      NotificationType.system: {
        'icon': Icons.notifications_outlined,
        'color': theme.colorScheme.outline,
        'bg': theme.colorScheme.surfaceContainerHigh,
      },
    };

    return staticStyles[item.type] ?? staticStyles[NotificationType.system]!;
  }

  void _handleNotificationTap(
    BuildContext context,
    NotificationItemEntity item,
  ) {
    context.read<NotificationsCubit>().markNotificationAsRead(item.id);

    if (item.type == NotificationType.chat &&
        item.data.metadata.roomId != null) {
      String resolvedName = item.data.metadata.senderName ?? 'New Message';
      if (resolvedName == 'New Message' && item.data.title.contains('from')) {
        resolvedName = item.data.title.split('from ').last;
      }

      Navigator.pushNamed(
        context,
        RouteList.inboxPage,
        arguments: InboxScreenArgs(
          roomId: item.data.metadata.roomId.toString(),
          customerId: item.data.metadata.senderId.toString(),
          customerName: resolvedName,
          jobTitle: item.data.metadata.serviceTag ?? 'Chat',
          avatarUrl: item.data.metadata.senderAvatar ?? '',
          customerPhone: item.data.metadata.senderPhone ?? '',
        ),
      );
      return;
    }

    switch (item.type) {
      case NotificationType.booking:
        final status = item.data.metadata.status?.toLowerCase() ?? '';
        final title = item.data.title.toLowerCase();
        int targetTabIndex = 0; // Default to Requests

        if (status == 'completed' ||
            status == 'cancelled' ||
            status == 'declined') {
          targetTabIndex = 2; // History Tab
        } else if (status == 'confirmed' ||
            status == 'accepted' ||
            status == 'en_route' ||
            status == 'in_progress' ||
            status == 'pending_payment' ||
            title.contains('emergency')) {
          targetTabIndex = 1; // 🎯 Active Tab GUARANTEED
        } else {
          targetTabIndex = 0; // Requests Tab
        }

        // 🎯 THE INDUSTRY STANDARD ROUTING FIX:
        // 1. Pop all overlays (including Notification Screen) until we reach the Root Layout
        Navigator.popUntil(context, (route) => route.isFirst);

        // 2. Command the Root Layout to jump to Tab 1 (My Jobs), and command
        // the inner Booking Dashboard to jump to the `targetTabIndex`!
        MainLayoutScreen.layoutKey.currentState?.navigateToTab(
          1,
          innerIndex: targetTabIndex,
        );
        break;

      case NotificationType.wallet:
      case NotificationType.payment:
        Navigator.pop(context); // Close notification screen
        Navigator.pushNamed(context, RouteList.walletDashboardPage);
        break;

      case NotificationType.waitlist:
        Navigator.pop(context); // Close notification screen
        Navigator.pushNamed(context, RouteList.waitlistPage);
        break;

      case NotificationType.emergency:
        if (item.data.metadata.dispatchId != null) {
          if (item.data.metadata.metadataType == 'emergency_cancelled') {
            context.showSnackBar(
              'This emergency has been cancelled.',
              type: SnackBarType.info,
            );
            return;
          }

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => BlocProvider<AcceptEmergencyCubit>(
              create: (_) => sl<AcceptEmergencyCubit>(),
              child: IncomingEmergencyAlert(
                dispatchId: item.data.metadata.dispatchId!,
                category: item.data.title,
                addressText:
                    item.data.metadata.addressText ??
                    'Location provided via GPS',
              ),
            ),
          );
        }
        break;

      case NotificationType.job:
        Navigator.pop(context); // Close notification screen
        Navigator.pushNamed(context, RouteList.exploreMarketplacePage);
        break;

      case NotificationType.system:
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notifications',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              final bool hasItems =
                  state is NotificationsLoadSuccess &&
                  state.notifications.isNotEmpty;

              if (!hasItems) return const SizedBox.shrink();

              return PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert_rounded),
                onSelected: (value) {
                  if (value == 'read') {
                    context
                        .read<NotificationsCubit>()
                        .markAllNotificationsAsRead();
                  } else if (value == 'clear') {
                    context
                        .read<NotificationsCubit>()
                        .clearAllNotificationHistory();
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'read',
                    child: Row(
                      children: [
                        Icon(Icons.done_all_rounded, size: 18),
                        SizedBox(width: 8),
                        Text('Mark all read'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'clear',
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_sweep_rounded,
                          size: 18,
                          color: theme.colorScheme.error,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Clear all history',
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppDimensions.maxDashboardWidth,
            ),
            child: BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                if (state is NotificationsFirstPageLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                if (state is NotificationsLoadFailure) {
                  return _buildErrorState(
                    theme,
                    state.error.message ?? 'Failed to load notifications',
                  );
                }

                if (state is NotificationsLoadSuccess) {
                  final notifications = state.notifications;

                  if (notifications.isEmpty) {
                    return _buildEmptyState(theme);
                  }

                  return RefreshIndicator.adaptive(
                    onRefresh: () =>
                        context.read<NotificationsCubit>().loadNotifications(),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(AppDimensions.paddingM),
                      itemCount: notifications.length,
                      separatorBuilder: (context, index) => AppDimensions.gapM,
                      itemBuilder: (context, index) {
                        final item = notifications[index];
                        final style = _resolveItemStyle(theme, item);

                        final String cleanTime = item.createdAt.length > 16
                            ? item.createdAt.substring(11, 16)
                            : item.createdAt;

                        return Dismissible(
                          key: Key(item.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.paddingL,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.errorContainer
                                  .withValues(alpha: 0.8),
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusM,
                              ),
                            ),
                            child: Icon(
                              Icons.delete_outline_rounded,
                              color: theme.colorScheme.onErrorContainer,
                            ),
                          ),
                          onDismissed: (direction) {
                            context
                                .read<NotificationsCubit>()
                                .removeSingleNotification(item.id);
                          },
                          child: NotificationItemTile(
                            title: item.data.title,
                            description: item.data.message,
                            timestamp: cleanTime,
                            icon: style['icon'] as IconData,
                            iconColor: style['color'] as Color,
                            iconBackgroundColor: style['bg'] as Color,
                            isRead: item.isRead,
                            onTap: () => _handleNotificationTap(context, item),
                          ),
                        );
                      },
                    ),
                  );
                }

                return _buildEmptyState(theme);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.notifications_off_outlined,
          size: 64,
          color: theme.colorScheme.outline,
        ),
        AppDimensions.gapM,
        Text(
          'All Caught Up!',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        AppDimensions.gapXS,
        Text(
          'Your active notification stream log is currently empty.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(ThemeData theme, String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline_rounded,
          size: 48,
          color: theme.colorScheme.error,
        ),
        AppDimensions.gapM,
        Text(
          message,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
        AppDimensions.gapS,
        ElevatedButton(
          onPressed: () =>
              context.read<NotificationsCubit>().loadNotifications(),
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
