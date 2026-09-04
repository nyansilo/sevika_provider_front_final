// import 'package:flutter/material.dart';

// import '../../../../core/constants/app_dimensions.dart';
// import '../../../../core/extensions/build_context_extensions.dart';
// import '../../domain/entities/booking_entity.dart';
// import '../../domain/entities/booking_status.dart';

// class ProviderJobCard extends StatelessWidget {
//   final BookingEntity booking;
//   final VoidCallback onTap;
//   final VoidCallback? onAccept;
//   final VoidCallback? onDecline;

//   const ProviderJobCard({
//     super.key,
//     required this.booking,
//     required this.onTap,
//     this.onAccept,
//     this.onDecline,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final bool isPending = booking.status == BookingStatus.pending;

//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(AppDimensions.radiusL),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: AppDimensions.paddingM),
//         padding: const EdgeInsets.all(AppDimensions.paddingM),
//         decoration: BoxDecoration(
//           color: context.colorScheme.surface,
//           borderRadius: BorderRadius.circular(AppDimensions.radiusL),
//           border: Border.all(
//             color: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
//           ),
//           // Slight shadow for depth
//           boxShadow: [
//             BoxShadow(
//               color: context.colorScheme.shadow.withValues(alpha: 0.03),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 👨‍🔧 HEADER: Customer Info & Status
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 24,
//                   backgroundColor: context.colorScheme.primaryContainer,
//                   // 🎯 SAFE CHECK: Use new customer entity fields
//                   backgroundImage:
//                       booking.customer?.avatar != null &&
//                           booking.customer!.avatar.isNotEmpty
//                       ? NetworkImage(booking.customer!.avatar)
//                       : null,
//                   child:
//                       (booking.customer?.avatar == null ||
//                           booking.customer!.avatar.isEmpty)
//                       ? Icon(Icons.person, color: context.colorScheme.primary)
//                       : null,
//                 ),
//                 AppDimensions.gapM,
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         // 🎯 SAFE CHECK: Use new customer entity fields
//                         booking.customer?.fullName ?? 'Verified Client',
//                         style: context.textTheme.titleMedium?.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       Text(
//                         booking.bookingReference, // Job ID
//                         style: context.textTheme.bodySmall?.copyWith(
//                           color: context.colorScheme.onSurfaceVariant,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Dynamic Status Badge
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 6,
//                   ),
//                   decoration: BoxDecoration(
//                     color: isPending
//                         ? Colors.orange.withValues(alpha: 0.1)
//                         : context.colorScheme.primaryContainer,
//                     borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
//                   ),
//                   child: Text(
//                     booking.status.name.toUpperCase(),
//                     style: context.textTheme.labelSmall?.copyWith(
//                       color: isPending
//                           ? Colors.orange.shade800
//                           : context.colorScheme.primary,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             AppDimensions.gapM,
//             const Divider(height: 1),
//             AppDimensions.gapM,

//             // 👨‍🔧 BODY: Logistics
//             Row(
//               children: [
//                 Icon(
//                   Icons.build_circle_outlined,
//                   size: 16,
//                   color: context.colorScheme.outline,
//                 ),
//                 AppDimensions.gapS,
//                 Expanded(
//                   child: Text(
//                     // 🎯 REPLACED: Use backend's resolved service name
//                     booking.requestedService,
//                     style: context.textTheme.bodyMedium?.copyWith(
//                       fontWeight: FontWeight.w600,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 6),
//             Row(
//               children: [
//                 Icon(
//                   Icons.calendar_today_outlined,
//                   size: 16,
//                   color: context.colorScheme.outline,
//                 ),
//                 AppDimensions.gapS,
//                 Expanded(
//                   child: Text(
//                     // 🎯 FIXED: Changed scheduledTime to scheduledAt!
//                     booking.scheduledAt,
//                     style: context.textTheme.bodyMedium,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 6),
//             Row(
//               children: [
//                 Icon(
//                   Icons.location_on_outlined,
//                   size: 16,
//                   color: context.colorScheme.outline,
//                 ),
//                 AppDimensions.gapS,
//                 Expanded(
//                   child: Text(
//                     // 🎯 REPLACED: Uses new flat executionAddress
//                     booking.executionAddress,
//                     style: context.textTheme.bodyMedium,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),

//             AppDimensions.gapL,

//             // 👨‍🔧 FOOTER: Earnings & Actions
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Estimated Payout',
//                       style: context.textTheme.labelSmall?.copyWith(
//                         color: context.colorScheme.onSurfaceVariant,
//                       ),
//                     ),
//                     Text(
//                       // 🎯 REPLACED: Safely handles null custom quote payouts
//                       booking.payoutAmount != null
//                           ? 'TSh ${booking.payoutAmount}'
//                           : 'Pending Quote',
//                       style: context.textTheme.titleMedium?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green.shade700, // Cash green
//                       ),
//                     ),
//                   ],
//                 ),

//                 // Show Accept/Decline ONLY if the job is pending
//                 if (isPending)
//                   Row(
//                     children: [
//                       OutlinedButton(
//                         onPressed: onDecline,
//                         style: OutlinedButton.styleFrom(
//                           foregroundColor: context.colorScheme.error,
//                           side: BorderSide(color: context.colorScheme.error),
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                         ),
//                         child: const Text('Decline'),
//                       ),
//                       AppDimensions.gapS,
//                       FilledButton(
//                         onPressed: onAccept,
//                         style: FilledButton.styleFrom(
//                           backgroundColor: context.colorScheme.primary,
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                         ),
//                         child: const Text('Accept'),
//                       ),
//                     ],
//                   )
//                 else
//                   FilledButton.icon(
//                     onPressed: onTap,
//                     icon: const Icon(Icons.arrow_forward_rounded, size: 18),
//                     label: const Text('Manage Job'),
//                     style: FilledButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                     ),
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/booking_status.dart';

class ProviderJobCard extends StatelessWidget {
  final BookingEntity booking;
  final VoidCallback onTap;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;

  const ProviderJobCard({
    super.key,
    required this.booking,
    required this.onTap,
    this.onAccept,
    this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    // 🎯 1. EXPANDED ACTION STATE: Quotes use 'awaitingEstimate', Instant uses 'pending'
    final bool needsAction =
        booking.status == BookingStatus.pending ||
        booking.status == BookingStatus.awaitingEstimate;

    // 🎯 2. RESOLVE TYPE COLORS & THEMES
    final bool isEmergency = booking.isEmergency;
    final bool isQuote = booking.bookingType == 'custom_quote';

    Color cardBorderColor = context.colorScheme.outlineVariant.withValues(
      alpha: 0.5,
    );
    if (isEmergency) cardBorderColor = context.colorScheme.error;
    if (isQuote) cardBorderColor = Colors.deepPurple.withValues(alpha: 0.5);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppDimensions.paddingM),
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          border: Border.all(
            color: cardBorderColor,
            width: isEmergency ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.shadow.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👨‍🔧 HEADER: Customer Info & Badges
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: context.colorScheme.primaryContainer,
                  backgroundImage:
                      booking.customer?.avatar != null &&
                          booking.customer!.avatar.isNotEmpty
                      ? NetworkImage(booking.customer!.avatar)
                      : null,
                  child:
                      (booking.customer?.avatar == null ||
                          booking.customer!.avatar.isEmpty)
                      ? Icon(Icons.person, color: context.colorScheme.primary)
                      : null,
                ),
                AppDimensions.gapM,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.customer?.fullName ?? 'Verified Client',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        booking.bookingReference,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                // 🎯 3. DYNAMIC BOOKING TYPE BADGE
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildTypeBadge(context, isEmergency, isQuote),
                    const SizedBox(height: 4),
                    _buildStatusBadge(context, needsAction),
                  ],
                ),
              ],
            ),

            AppDimensions.gapM,
            const Divider(height: 1),
            AppDimensions.gapM,

            // 👨‍🔧 BODY: Logistics
            Row(
              children: [
                Icon(
                  Icons.build_circle_outlined,
                  size: 16,
                  color: context.colorScheme.outline,
                ),
                AppDimensions.gapS,
                Expanded(
                  child: Text(
                    booking.requestedService,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  isEmergency
                      ? Icons.timer_outlined
                      : Icons.calendar_today_outlined,
                  size: 16,
                  color: isEmergency
                      ? context.colorScheme.error
                      : context.colorScheme.outline,
                ),
                AppDimensions.gapS,
                Expanded(
                  child: Text(
                    isEmergency
                        ? 'URGENT: Dispatch Immediately'
                        : booking.scheduledAt,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: isEmergency ? context.colorScheme.error : null,
                      fontWeight: isEmergency
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: context.colorScheme.outline,
                ),
                AppDimensions.gapS,
                Expanded(
                  child: Text(
                    booking.executionAddress,
                    style: context.textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            AppDimensions.gapL,

            // 👨‍🔧 FOOTER: Earnings & Dynamic Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isQuote ? 'Budget / Estimate' : 'Estimated Payout',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      booking.payoutAmount != null
                          ? 'TSh ${booking.payoutAmount}'
                          : (isQuote ? 'Needs Your Bid' : 'Pending'),
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isQuote
                            ? Colors.deepPurple
                            : Colors.green.shade700,
                      ),
                    ),
                  ],
                ),

                // 🎯 4. CONTEXTUAL ACTION BUTTONS
                if (needsAction)
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: onDecline,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: context.colorScheme.error,
                          side: BorderSide(color: context.colorScheme.error),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        child: const Text('Decline'),
                      ),
                      AppDimensions.gapS,
                      _buildPrimaryActionButton(context, isEmergency, isQuote),
                    ],
                  )
                else
                  // 🎯 FIXED: Check if the job is in the past!
                  Builder(
                    builder: (context) {
                      final isPastJob =
                          booking.status == BookingStatus.completed ||
                          booking.status == BookingStatus.cancelled;

                      return FilledButton.icon(
                        onPressed: onTap,
                        icon: Icon(
                          isPastJob
                              ? Icons.receipt_long_rounded
                              : Icons.arrow_forward_rounded,
                          size: 18,
                        ),
                        label: Text(isPastJob ? 'View Details' : 'Manage Job'),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          // De-emphasize the button if the job is already done
                          backgroundColor: isPastJob
                              ? context.colorScheme.surfaceContainerHighest
                              : context.colorScheme.primary,
                          foregroundColor: isPastJob
                              ? context.colorScheme.onSurface
                              : context.colorScheme.onPrimary,
                        ),
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- HELPER UI WIDGETS ---

  Widget _buildTypeBadge(BuildContext context, bool isEmergency, bool isQuote) {
    String label = 'INSTANT';
    Color bgColor = context.colorScheme.primaryContainer;
    Color textColor = context.colorScheme.primary;
    IconData? icon;

    if (isEmergency) {
      label = 'SOS EMERGENCY';
      bgColor = context.colorScheme.errorContainer;
      textColor = context.colorScheme.error;
      icon = Icons.warning_amber_rounded;
    } else if (isQuote) {
      label = 'CUSTOM QUOTE';
      bgColor = Colors.deepPurple.withValues(alpha: 0.1);
      textColor = Colors.deepPurple;
      icon = Icons.request_quote_outlined;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, bool needsAction) {
    return Text(
      booking.status.name.toUpperCase(),
      style: context.textTheme.labelSmall?.copyWith(
        color: needsAction
            ? Colors.orange.shade800
            : context.colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildPrimaryActionButton(
    BuildContext context,
    bool isEmergency,
    bool isQuote,
  ) {
    String label = 'Accept';
    Color bgColor = context.colorScheme.primary;
    Color fgColor = context.colorScheme.onPrimary;

    if (isEmergency) {
      label = 'Accept SOS';
      bgColor = context.colorScheme.error;
      fgColor = context.colorScheme.onError;
    } else if (isQuote) {
      label = 'Submit Bid';
      bgColor = Colors.deepPurple;
      fgColor = Colors.white;
    }

    return FilledButton(
      onPressed: onAccept,
      style: FilledButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: Text(label),
    );
  }
}
