// import 'package:flutter/material.dart';

// import '../../domain/entities/booking_status.dart';

// /// 👨‍🔧 CENTRALIZED PROVIDER ACTIONS HELPER
// class ProviderBookingActionHelper {
//   /// Formats the primary call-to-action button based on the current job phase.
//   static String getPrimaryActionText(BookingStatus status) {

//     switch (status) {
//       case BookingStatus.pending: // 🎯 ADDED THIS
//         return 'Accept Job';
//       case BookingStatus.quoteProvided: // 🎯 ADDED THIS
//         return 'Awaiting Client Approval';
//       case BookingStatus.accepted:
//         return 'Start Travel (En Route)';
//       case BookingStatus.enRoute:
//         return 'Arrived & Start Job';
//       case BookingStatus.ongoing:
//         return 'Complete Job';
//       case BookingStatus.pendingPayment:
//         return 'Confirm Cash Receipt';
//       default:
//         return 'View Details';
//     }
//   }

//   /// Returns the NEXT status the Provider should update the job to.
//   static String? getNextStatusAction(BookingStatus status) {
//     switch (status) {
//       case BookingStatus.accepted:
//         return 'en_route';
//       case BookingStatus.enRoute:
//         return 'in_progress'; // Maps to ongoing
//       case BookingStatus.ongoing:
//         return 'completed'; // Or pending_payment if cash
//       default:
//         return null;
//     }
//   }

//   /// Opens an alert dialog before confirming cash handover
//   static Future<bool> confirmCashHandover(
//     BuildContext context,
//     double amount,
//   ) async {
//     return await showDialog<bool>(
//           context: context,
//           builder: (ctx) => AlertDialog(
//             title: const Text('Confirm Cash Receipt'),
//             content: Text(
//               'Did you physically collect TSh $amount from the client? This will deduct the platform commission from your digital wallet.',
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(ctx, false),
//                 child: const Text('Cancel'),
//               ),
//               FilledButton(
//                 onPressed: () => Navigator.pop(ctx, true),
//                 style: FilledButton.styleFrom(
//                   backgroundColor: Colors.green.shade700,
//                 ),
//                 child: const Text('Yes, I collected it'),
//               ),
//             ],
//           ),
//         ) ??
//         false;
//   }
// }

import 'package:flutter/material.dart';

import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/booking_status.dart';

/// 👨‍🔧 CENTRALIZED PROVIDER ACTIONS HELPER
class ProviderBookingActionHelper {
  /// Formats the primary call-to-action button based on the current job phase.
  static String getPrimaryActionText(BookingEntity booking) {
    // 🎯 MARKETPLACE OVERRIDE: Customer already accepted the bid!
    if (booking.isAwardedMarketplaceBid) {
      return 'Start Travel (En Route)';
    }

    switch (booking.status) {
      case BookingStatus.pending:
      case BookingStatus
          .awaitingEstimate: // 🎯 ADDED: For incoming custom quotes
        return 'Accept Job';
      case BookingStatus.quoteProvided:
        return 'Awaiting Client Approval';
      case BookingStatus.accepted:
      case BookingStatus.confirmed: // 🎯 ADDED: Standard confirmed jobs
        return 'Start Travel (En Route)';
      case BookingStatus.enRoute:
        return 'Arrived & Start Job';
      case BookingStatus.ongoing:
        return 'Complete Job';
      case BookingStatus.pendingPayment:
        return 'Confirm Cash Receipt';
      default:
        return 'View Details';
    }
  }

  /// Returns the NEXT status the Provider should update the job to.
  static String? getNextStatusAction(BookingEntity booking) {
    // 🎯 MARKETPLACE OVERRIDE
    if (booking.isAwardedMarketplaceBid) {
      return 'en_route';
    }

    switch (booking.status) {
      case BookingStatus.pending:
      case BookingStatus.awaitingEstimate:
        return 'accepted';
      case BookingStatus.accepted:
      case BookingStatus.confirmed:
        return 'en_route';
      case BookingStatus.enRoute:
        return 'in_progress'; // Laravel expects 'in_progress', which maps to 'ongoing' in Flutter
      case BookingStatus.ongoing:
        return 'completed'; // Or pending_payment if cash
      default:
        return null;
    }
  }

  /// Opens an alert dialog before confirming cash handover
  static Future<bool> confirmCashHandover(
    BuildContext context,
    double amount,
  ) async {
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Confirm Cash Receipt'),
            content: Text(
              'Did you physically collect TSh $amount from the client? This will deduct the platform commission from your digital wallet.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                ),
                child: const Text('Yes, I collected it'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
