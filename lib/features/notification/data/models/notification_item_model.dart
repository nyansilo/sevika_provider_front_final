import 'package:flutter/foundation.dart';

import '../../domain/entities/notification_item_entity.dart';
import '../../domain/entities/notification_type.dart';
import 'notification_data_model.dart';

class NotificationItemModel extends NotificationItemEntity {
  const NotificationItemModel({
    required super.id,
    required super.type,
    required NotificationDataModel super.data,
    super.readAt,
    required super.createdAt,
  });

  factory NotificationItemModel.fromJson(Map<String, dynamic> json) {
    try {
      final String rawType = json['type']?.toString() ?? '';

      final Map<String, dynamic> payloadBlock =
          json.containsKey('data') && json['data'] is Map<String, dynamic>
          ? json['data'] as Map<String, dynamic>
          : json;

      final Map<String, dynamic> metadataBlock =
          payloadBlock['metadata'] as Map<String, dynamic>? ?? const {};

      NotificationType determinedType = NotificationType.system;

      if (rawType.contains('Booking') ||
          metadataBlock.containsKey('bookingReference')) {
        determinedType = NotificationType.booking;
      } else if (rawType.contains('Wallet') ||
          metadataBlock['type'] == 'wallet_refund' ||
          metadataBlock['type'] == 'wallet_topup' ||
          metadataBlock['type'] == 'escrow_release' ||
          metadataBlock['type'] == 'withdrawal_update' ||
          metadataBlock.containsKey('is_frozen')) {
        determinedType = NotificationType.wallet;
      } else if (rawType.contains('Payment') ||
          metadataBlock.containsKey('paymentId')) {
        determinedType = NotificationType.payment;
      } else if (rawType.contains('Chat') ||
          metadataBlock.containsKey('roomId')) {
        determinedType = NotificationType.chat;
      } else if (rawType.contains('Waitlist') ||
          metadataBlock.containsKey('waitlistId')) {
        // 📈 RESTORED FOR DEMAND ALERTS
        determinedType = NotificationType.waitlist;
      } else if (rawType.contains('Job') ||
          metadataBlock.containsKey('jobRequestId')) {
        determinedType = NotificationType.job;
      } else if (rawType.contains('Auth') ||
          rawType.contains('Password') ||
          metadataBlock['type'] == 'password_reset') {
        determinedType = NotificationType.auth;
      } else if (rawType.contains('Emergency') ||
          rawType.contains('EmergencyBroadcast') ||
          metadataBlock.containsKey('dispatchId')) {
        // 🚨 ADDED: Emergency identification
        determinedType = NotificationType.emergency;
      } else {
        determinedType = NotificationType.fromString(rawType);
      }

      return NotificationItemModel(
        id: json['id']?.toString() ?? '',
        type: determinedType,
        data: NotificationDataModel.fromJson(payloadBlock),
        readAt: json['readAt']?.toString() ?? json['read_at']?.toString(),
        createdAt:
            json['createdAt']?.toString() ??
            json['created_at']?.toString() ??
            DateTime.now().toIso8601String(),
      );
    } catch (e, stackTrace) {
      debugPrint(
        'Parsing Exception inside NotificationItemModel: $e\n$stackTrace',
      );
      throw FormatException(
        'Invalid Notification structural model mapping: $e',
      );
    }
  }

  NotificationItemEntity toEntity() {
    return NotificationItemEntity(
      id: id,
      type: type,
      data: data,
      readAt: readAt,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type.name,
    'data': (data as NotificationDataModel).toJson(),
    'readAt': readAt,
    'createdAt': createdAt,
  };
}
