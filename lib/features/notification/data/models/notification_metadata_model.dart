// import '../../domain/entities/notification_metadata_entity.dart';

// class NotificationMetadataModel extends NotificationMetadataEntity {
//   const NotificationMetadataModel({
//     super.paymentId,
//     super.state,
//     super.gateway,
//     super.currency,
//     super.transactionReference,
//     super.bookingId,
//     super.bookingReference,
//     super.status,
//     super.triggerContext,
//     super.roomId,
//     super.messageId,
//     super.senderId,
//     super.senderName,
//     super.senderAvatar,
//     super.senderPhone,
//     super.serviceTag,
//     super.body,
//     super.sentAt,
//     super.isFrozen,
//     super.updatedAt,
//     super.metadataType,
//     super.waitlistId,
//     super.serviceId,
//     super.serviceSlug,
//     super.jobRequestId,
//     super.bidId,
//     super.dispatchId, // 🚨 Added
//     super.addressText, // 🚨 Added
//     super.code,
//     super.expiresIn,
//     super.amount,
//   });

//   factory NotificationMetadataModel.fromJson(Map<String, dynamic> json) {
//     return NotificationMetadataModel(
//       paymentId:
//           json['paymentId']?.toString() ?? json['payment_id']?.toString(),
//       state: json['state']?.toString(),
//       gateway: json['gateway']?.toString(),
//       currency: json['currency']?.toString(),

//       transactionReference:
//           json['transactionReference']?.toString() ??
//           json['transaction_reference']?.toString(),

//       bookingId: (json['bookingId'] ?? json['booking_id']) != null
//           ? int.tryParse((json['bookingId'] ?? json['booking_id']).toString())
//           : null,

//       bookingReference: json['bookingReference']?.toString(),
//       status: json['status']?.toString(),
//       triggerContext: json['triggerContext']?.toString(),

//       roomId: json['roomId']?.toString(),
//       messageId: json['messageId']?.toString(),
//       senderId: json['senderId']?.toString(),
//       senderName: json['senderName']?.toString(),
//       senderAvatar: json['senderAvatar']?.toString(),
//       senderPhone: json['senderPhone']?.toString(),
//       serviceTag: json['serviceTag']?.toString(),
//       body: json['body']?.toString(),
//       sentAt: json['sentAt']?.toString(),

//       metadataType: json['type']?.toString(),
//       isFrozen: json['is_frozen'] != null
//           ? (json['is_frozen'].toString() == 'true' ||
//                 json['is_frozen'] == 1 ||
//                 json['is_frozen'] == true)
//           : null,
//       updatedAt: json['updated_at']?.toString(),

//       // 📈 RESTORED: Waitlist Metadata mapping
//       waitlistId: json['waitlistId']?.toString(),
//       serviceId: json['serviceId']?.toString(),
//       serviceSlug: json['serviceSlug']?.toString(),

//       jobRequestId: json['jobRequestId']?.toString(),
//       bidId: json['bidId']?.toString(),

//       // 🚨 ADDED: Emergency SOS Metadata Mapping
//       dispatchId:
//           json['dispatchId']?.toString() ?? json['dispatch_id']?.toString(),
//       addressText:
//           json['addressText']?.toString() ?? json['address_text']?.toString(),

//       code: json['code']?.toString(),
//       expiresIn: json['expiresIn']?.toString(),
//       amount: json['amount'] != null
//           ? num.tryParse(json['amount'].toString())
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     if (paymentId != null) 'paymentId': paymentId,
//     if (state != null) 'state': state,
//     if (gateway != null) 'gateway': gateway,
//     if (currency != null) 'currency': currency,
//     if (transactionReference != null)
//       'transactionReference': transactionReference,
//     if (bookingId != null) 'bookingId': bookingId,
//     if (bookingReference != null) 'bookingReference': bookingReference,
//     if (status != null) 'status': status,
//     if (triggerContext != null) 'triggerContext': triggerContext,
//     if (roomId != null) 'roomId': roomId,
//     if (messageId != null) 'messageId': messageId,
//     if (senderId != null) 'senderId': senderId,
//     if (senderName != null) 'senderName': senderName,
//     if (senderAvatar != null) 'senderAvatar': senderAvatar,
//     if (senderPhone != null) 'senderPhone': senderPhone,
//     if (serviceTag != null) 'serviceTag': serviceTag,
//     if (body != null) 'body': body,
//     if (sentAt != null) 'sentAt': sentAt,
//     if (metadataType != null) 'metadataType': metadataType,
//     if (isFrozen != null) 'isFrozen': isFrozen,
//     if (updatedAt != null) 'updatedAt': updatedAt,
//     if (waitlistId != null) 'waitlistId': waitlistId, // 📈 Restored
//     if (serviceId != null) 'serviceId': serviceId,
//     if (serviceSlug != null) 'serviceSlug': serviceSlug, // 📈 Restored
//     if (jobRequestId != null) 'jobRequestId': jobRequestId,
//     if (bidId != null) 'bidId': bidId,
//     if (dispatchId != null) 'dispatchId': dispatchId, // 🚨 Added
//     if (addressText != null) 'addressText': addressText, // 🚨 Added
//     if (code != null) 'code': code,
//     if (expiresIn != null) 'expiresIn': expiresIn,
//     if (amount != null) 'amount': amount,
//   };
// }

import '../../domain/entities/notification_metadata_entity.dart';

class NotificationMetadataModel extends NotificationMetadataEntity {
  const NotificationMetadataModel({
    super.paymentId,
    super.state,
    super.gateway,
    super.currency,
    super.transactionReference,
    super.bookingId,
    super.bookingReference,
    super.status,
    super.triggerContext,
    super.roomId,
    super.messageId,
    super.senderId,
    super.senderName,
    super.senderAvatar,
    super.senderPhone,
    super.serviceTag,
    super.body,
    super.sentAt,
    super.isFrozen,
    super.updatedAt,
    super.metadataType,
    super.waitlistId,
    super.serviceId,
    super.serviceSlug,
    super.jobRequestId,
    super.bidId,
    super.dispatchId,
    super.addressText,
    super.code,
    super.expiresIn,
    super.amount,
  });

  factory NotificationMetadataModel.fromJson(Map<String, dynamic> json) {
    return NotificationMetadataModel(
      paymentId:
          json['paymentId']?.toString() ?? json['payment_id']?.toString(),
      state: json['state']?.toString(),
      gateway: json['gateway']?.toString(),
      currency: json['currency']?.toString(),

      transactionReference:
          json['transactionReference']?.toString() ??
          json['transaction_reference']?.toString(),

      bookingId: (json['bookingId'] ?? json['booking_id']) != null
          ? int.tryParse((json['bookingId'] ?? json['booking_id']).toString())
          : null,

      bookingReference: json['bookingReference']?.toString(),
      status: json['status']?.toString(),

      // 🚀 AUTOMATION FIX: Map Laravel's eventContext to Flutter's triggerContext!
      triggerContext:
          json['triggerContext']?.toString() ??
          json['eventContext']?.toString() ??
          json['event_context']?.toString(),

      roomId: json['roomId']?.toString(),
      messageId: json['messageId']?.toString(),
      senderId: json['senderId']?.toString(),
      senderName: json['senderName']?.toString(),
      senderAvatar: json['senderAvatar']?.toString(),
      senderPhone: json['senderPhone']?.toString(),
      serviceTag: json['serviceTag']?.toString(),
      body: json['body']?.toString(),
      sentAt: json['sentAt']?.toString(),

      metadataType: json['type']?.toString(),
      isFrozen: json['is_frozen'] != null
          ? (json['is_frozen'].toString() == 'true' ||
                json['is_frozen'] == 1 ||
                json['is_frozen'] == true)
          : null,
      updatedAt: json['updated_at']?.toString(),

      waitlistId: json['waitlistId']?.toString(),
      serviceId: json['serviceId']?.toString(),
      serviceSlug: json['serviceSlug']?.toString(),

      jobRequestId: json['jobRequestId']?.toString(),
      bidId: json['bidId']?.toString(),

      dispatchId:
          json['dispatchId']?.toString() ?? json['dispatch_id']?.toString(),
      addressText:
          json['addressText']?.toString() ?? json['address_text']?.toString(),

      code: json['code']?.toString(),
      expiresIn: json['expiresIn']?.toString(),
      amount: json['amount'] != null
          ? num.tryParse(json['amount'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    if (paymentId != null) 'paymentId': paymentId,
    if (state != null) 'state': state,
    if (gateway != null) 'gateway': gateway,
    if (currency != null) 'currency': currency,
    if (transactionReference != null)
      'transactionReference': transactionReference,
    if (bookingId != null) 'bookingId': bookingId,
    if (bookingReference != null) 'bookingReference': bookingReference,
    if (status != null) 'status': status,
    if (triggerContext != null) 'triggerContext': triggerContext,
    if (roomId != null) 'roomId': roomId,
    if (messageId != null) 'messageId': messageId,
    if (senderId != null) 'senderId': senderId,
    if (senderName != null) 'senderName': senderName,
    if (senderAvatar != null) 'senderAvatar': senderAvatar,
    if (senderPhone != null) 'senderPhone': senderPhone,
    if (serviceTag != null) 'serviceTag': serviceTag,
    if (body != null) 'body': body,
    if (sentAt != null) 'sentAt': sentAt,
    if (metadataType != null) 'metadataType': metadataType,
    if (isFrozen != null) 'isFrozen': isFrozen,
    if (updatedAt != null) 'updatedAt': updatedAt,
    if (waitlistId != null) 'waitlistId': waitlistId,
    if (serviceId != null) 'serviceId': serviceId,
    if (serviceSlug != null) 'serviceSlug': serviceSlug,
    if (jobRequestId != null) 'jobRequestId': jobRequestId,
    if (bidId != null) 'bidId': bidId,
    if (dispatchId != null) 'dispatchId': dispatchId,
    if (addressText != null) 'addressText': addressText,
    if (code != null) 'code': code,
    if (expiresIn != null) 'expiresIn': expiresIn,
    if (amount != null) 'amount': amount,
  };
}
