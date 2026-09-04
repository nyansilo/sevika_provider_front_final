import 'package:equatable/equatable.dart';

class NotificationMetadataEntity extends Equatable {
  // Ledger / Settlement metrics
  final String? paymentId;
  final String? state;
  final String? gateway;
  final String? currency;
  final String? transactionReference;

  // Booking / Operational metrics
  final int? bookingId;
  final String? bookingReference;
  final String? status;
  final String? triggerContext;

  // Chat & UI metrics
  final String? roomId;
  final String? messageId;
  final String? senderId;
  final String? senderName;
  final String? senderAvatar;
  final String? senderPhone;
  final String? serviceTag;
  final String? body;
  final String? sentAt;

  // 🎯 Wallet Status
  final bool? isFrozen;
  final String? updatedAt;
  final String? metadataType;

  // 📈 Waitlist & Service Context (Restored)
  final String? waitlistId;
  final String? serviceId;
  final String? serviceSlug;

  // 🎯 Jobs & Bidding
  final String? jobRequestId;
  final String? bidId;

  // 🚨 Emergency SOS
  final String? dispatchId;
  final String? addressText;

  // 🎯 Auth
  final String? code;
  final String? expiresIn;

  // Shared generic properties
  final num? amount;

  const NotificationMetadataEntity({
    this.paymentId,
    this.state,
    this.gateway,
    this.currency,
    this.transactionReference,
    this.bookingId,
    this.bookingReference,
    this.status,
    this.triggerContext,
    this.roomId,
    this.messageId,
    this.senderId,
    this.senderName,
    this.senderAvatar,
    this.senderPhone,
    this.serviceTag,
    this.body,
    this.sentAt,
    this.isFrozen,
    this.updatedAt,
    this.metadataType,
    this.waitlistId, // 📈 Restored
    this.serviceId,
    this.serviceSlug, // 📈 Restored
    this.jobRequestId,
    this.bidId,
    this.dispatchId, // 🚨 Added
    this.addressText, // 🚨 Added
    this.code,
    this.expiresIn,
    this.amount,
  });

  bool get isPaymentNotification => paymentId != null;

  @override
  List<Object?> get props => [
    paymentId,
    state,
    gateway,
    currency,
    transactionReference,
    bookingId,
    bookingReference,
    status,
    triggerContext,
    roomId,
    messageId,
    senderId,
    senderName,
    senderAvatar,
    senderPhone,
    serviceTag,
    body,
    sentAt,
    isFrozen,
    updatedAt,
    metadataType,
    waitlistId, // 📈 Restored
    serviceId,
    serviceSlug, // 📈 Restored
    jobRequestId,
    bidId,
    dispatchId, // 🚨 Added
    addressText, // 🚨 Added
    code,
    expiresIn,
    amount,
  ];
}
