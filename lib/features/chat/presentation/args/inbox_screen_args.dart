import 'package:equatable/equatable.dart';

// 🎯 REQUIRED: Import BookingEntity so the Provider can access the full job details from the chat
import '../../../booking/domain/entities/booking_entity.dart';

/// 📨 Inbox Screen Args (Provider Perspective)
///
/// Strongly typed arguments required to navigate to the InboxScreen.
/// This prevents runtime crashes caused by missing Map keys or typos.
class InboxScreenArgs extends Equatable {
  final String roomId;

  // 🎯 CORE FIX: This must map to the CUSTOMER's ID when navigating from a notification!
  final String
  customerId; // 📞 Required for Call Feature (UUID to ring the customer)

  final String customerName;
  final String jobTitle; // 👨‍🔧 Displayed as the subtitle in the App Bar
  final String avatarUrl;
  final String customerPhone;

  // 🎯 NEW: Replaced Quote/Bid logic with the actual Booking Entity.
  // This allows the Provider to tap "View Job" in the Chat AppBar and jump straight to the job details.
  final BookingEntity? bookingEntity;

  const InboxScreenArgs({
    required this.roomId,
    required this.customerId,
    required this.customerName,
    required this.jobTitle,
    required this.avatarUrl,
    required this.customerPhone,
    this.bookingEntity,
  });

  /// Allows cloning the args with slight modifications if needed
  InboxScreenArgs copyWith({
    String? roomId,
    String? customerId,
    String? customerName,
    String? jobTitle,
    String? avatarUrl,
    String? customerPhone,
    BookingEntity? bookingEntity,
  }) {
    return InboxScreenArgs(
      roomId: roomId ?? this.roomId,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      jobTitle: jobTitle ?? this.jobTitle,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      customerPhone: customerPhone ?? this.customerPhone,
      bookingEntity: bookingEntity ?? this.bookingEntity,
    );
  }

  @override
  List<Object?> get props => [
    roomId,
    customerId,
    customerName,
    jobTitle,
    avatarUrl,
    customerPhone,
    bookingEntity,
  ];
}
