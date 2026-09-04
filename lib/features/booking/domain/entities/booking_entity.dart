// import 'package:equatable/equatable.dart';

// import 'booking_status.dart';
// import 'booking_item_entity.dart';
// import 'customer_entity.dart';
// import 'provider_entity.dart';
// import 'quote_metadata_entity.dart';

// class BookingEntity extends Equatable {
//   final int bookingId;
//   final String bookingReference;
//   final String bookingType;
//   final String fulfillmentType;

//   final String? addressId;
//   final String? chatRoomId;
//   final BookingStatus status;

//   // 📍 LIVE TRACKING GPS COORDINATES
//   final double? customerLatitude;
//   final double? customerLongitude;
//   final double? providerLatitude;
//   final double? providerLongitude;

//   final String? paymentMethod;
//   final String? amount;
//   final String? subtotalAmount;

//   // 🎯 FIXED: Made these nullable because Provider JSON doesn't send them
//   final String? safetyFee;
//   final String? totalAmount;
//   final int? rawSubtotalAmount;
//   final int? rawSafetyFee;
//   final int? rawTotalAmount;

//   // 🎯 The Provider JSON sends payoutAmount
//   final double? payoutAmount;

//   final String scheduledAt;
//   final String executionAddress;
//   final String executionCity;
//   final String? specialInstructions;
//   final QuoteMetadataEntity? quoteMetadata;

//   final String? verificationPin;
//   final String? invoiceUrl;

//   final bool isPaid;
//   // 🎯 FIXED: Made these nullable
//   final String? paymentStatus;
//   final String? createdAt;

//   final String? startedAt;
//   final String requestedService;

//   final List<BookingItemEntity> items;
//   final CustomerEntity? customer;
//   final ProviderEntity? provider;

//   const BookingEntity({
//     required this.bookingId,
//     required this.bookingReference,
//     required this.bookingType,
//     this.fulfillmentType = 'home',
//     this.startedAt,
//     this.addressId,
//     this.chatRoomId,
//     required this.status,
//     this.customerLatitude,
//     this.customerLongitude,
//     this.providerLatitude,
//     this.providerLongitude,
//     this.paymentMethod,
//     this.amount,
//     this.subtotalAmount,
//     this.safetyFee,
//     this.totalAmount,
//     this.rawSubtotalAmount,
//     this.rawSafetyFee,
//     this.rawTotalAmount,
//     this.payoutAmount,
//     required this.scheduledAt,
//     required this.executionAddress,
//     required this.executionCity,
//     this.specialInstructions,
//     this.quoteMetadata,
//     this.verificationPin,
//     this.invoiceUrl,
//     this.isPaid = false,
//     this.paymentStatus,
//     this.createdAt,
//     required this.items,
//     required this.requestedService,
//     this.customer,
//     this.provider,
//   });

//   String? get bidId => quoteMetadata?.bidId;
//   bool get isEmergency => bookingType == 'emergency';
//   bool get isCancellable =>
//       status == BookingStatus.pending ||
//       status == BookingStatus.awaitingEstimate ||
//       status == BookingStatus.quoteProvided;
//   bool get isCurrentlyActive => status == BookingStatus.ongoing;

//   // 🚀 THE WORKAROUND FLAG: Detects if this is a Marketplace Bid disguised as a custom quote
//   bool get isAwardedMarketplaceBid =>
//       bookingType == 'custom_quote' &&
//       status == BookingStatus.quoteProvided &&
//       quoteMetadata?.bidId != null;

//   @override
//   List<Object?> get props => [
//     bookingId,
//     bookingReference,
//     bookingType,
//     fulfillmentType,
//     addressId,
//     chatRoomId,
//     status,
//     customerLatitude,
//     customerLongitude,
//     providerLatitude,
//     providerLongitude,
//     paymentMethod,
//     amount,
//     subtotalAmount,
//     safetyFee,
//     totalAmount,
//     rawSubtotalAmount,
//     rawSafetyFee,
//     rawTotalAmount,
//     payoutAmount,
//     scheduledAt,
//     executionAddress,
//     executionCity,
//     specialInstructions,
//     quoteMetadata,
//     verificationPin,
//     invoiceUrl,
//     isPaid,
//     paymentStatus,
//     createdAt,
//     startedAt,
//     items,
//     requestedService,
//     customer,
//     provider,
//   ];
// }

import 'package:equatable/equatable.dart';

import 'booking_status.dart';
import 'booking_item_entity.dart';
import 'customer_entity.dart';
import 'provider_entity.dart';
import 'quote_metadata_entity.dart';

class BookingEntity extends Equatable {
  final int bookingId;
  final String bookingReference;
  final String bookingType;
  final String fulfillmentType;

  final String? addressId;
  final String? chatRoomId;
  final BookingStatus status;

  // 📍 LIVE TRACKING GPS COORDINATES
  final double? customerLatitude;
  final double? customerLongitude;
  final double? providerLatitude;
  final double? providerLongitude;

  final String? paymentMethod;
  final String? amount;
  final String? subtotalAmount;

  // 🎯 FIXED: Made these nullable because Provider JSON doesn't send them
  final String? safetyFee;
  final String? totalAmount;
  final int? rawSubtotalAmount;
  final int? rawSafetyFee;
  final int? rawTotalAmount;

  // 🎯 The Provider JSON sends payoutAmount
  final double? payoutAmount;

  final String scheduledAt;
  final String executionAddress;
  final String executionCity;
  final String? specialInstructions;
  final QuoteMetadataEntity? quoteMetadata;

  final String? verificationPin;
  final String? invoiceUrl;

  final bool isPaid;
  // 🎯 FIXED: Made these nullable
  final String? paymentStatus;
  final String? createdAt;

  final String? startedAt;
  final String requestedService;

  final List<BookingItemEntity> items;
  final CustomerEntity? customer;
  final ProviderEntity? provider;

  const BookingEntity({
    required this.bookingId,
    required this.bookingReference,
    required this.bookingType,
    this.fulfillmentType = 'home',
    this.startedAt,
    this.addressId,
    this.chatRoomId,
    required this.status,
    this.customerLatitude,
    this.customerLongitude,
    this.providerLatitude,
    this.providerLongitude,
    this.paymentMethod,
    this.amount,
    this.subtotalAmount,
    this.safetyFee,
    this.totalAmount,
    this.rawSubtotalAmount,
    this.rawSafetyFee,
    this.rawTotalAmount,
    this.payoutAmount,
    required this.scheduledAt,
    required this.executionAddress,
    required this.executionCity,
    this.specialInstructions,
    this.quoteMetadata,
    this.verificationPin,
    this.invoiceUrl,
    this.isPaid = false,
    this.paymentStatus,
    this.createdAt,
    required this.items,
    required this.requestedService,
    this.customer,
    this.provider,
  });

  String? get bidId => quoteMetadata?.bidId;
  bool get isEmergency => bookingType == 'emergency';
  bool get isCancellable =>
      status == BookingStatus.pending ||
      status == BookingStatus.awaitingEstimate ||
      status == BookingStatus.quoteProvided;
  bool get isCurrentlyActive => status == BookingStatus.ongoing;

  // 🚀 THE WORKAROUND FLAG: Detects if this is a Marketplace Bid disguised as a custom quote
  bool get isAwardedMarketplaceBid =>
      bookingType == 'custom_quote' &&
      status == BookingStatus.quoteProvided &&
      quoteMetadata?.bidId != null;

  // 🎯 ADDED: The copyWith method for clean, immutable state updates!
  BookingEntity copyWith({
    int? bookingId,
    String? bookingReference,
    String? bookingType,
    String? fulfillmentType,
    String? addressId,
    String? chatRoomId,
    BookingStatus? status,
    double? customerLatitude,
    double? customerLongitude,
    double? providerLatitude,
    double? providerLongitude,
    String? paymentMethod,
    String? amount,
    String? subtotalAmount,
    String? safetyFee,
    String? totalAmount,
    int? rawSubtotalAmount,
    int? rawSafetyFee,
    int? rawTotalAmount,
    double? payoutAmount,
    String? scheduledAt,
    String? executionAddress,
    String? executionCity,
    String? specialInstructions,
    QuoteMetadataEntity? quoteMetadata,
    String? verificationPin,
    String? invoiceUrl,
    bool? isPaid,
    String? paymentStatus,
    String? createdAt,
    String? startedAt,
    String? requestedService,
    List<BookingItemEntity>? items,
    CustomerEntity? customer,
    ProviderEntity? provider,
  }) {
    return BookingEntity(
      bookingId: bookingId ?? this.bookingId,
      bookingReference: bookingReference ?? this.bookingReference,
      bookingType: bookingType ?? this.bookingType,
      fulfillmentType: fulfillmentType ?? this.fulfillmentType,
      addressId: addressId ?? this.addressId,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      status: status ?? this.status,
      customerLatitude: customerLatitude ?? this.customerLatitude,
      customerLongitude: customerLongitude ?? this.customerLongitude,
      providerLatitude: providerLatitude ?? this.providerLatitude,
      providerLongitude: providerLongitude ?? this.providerLongitude,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      amount: amount ?? this.amount,
      subtotalAmount: subtotalAmount ?? this.subtotalAmount,
      safetyFee: safetyFee ?? this.safetyFee,
      totalAmount: totalAmount ?? this.totalAmount,
      rawSubtotalAmount: rawSubtotalAmount ?? this.rawSubtotalAmount,
      rawSafetyFee: rawSafetyFee ?? this.rawSafetyFee,
      rawTotalAmount: rawTotalAmount ?? this.rawTotalAmount,
      payoutAmount: payoutAmount ?? this.payoutAmount,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      executionAddress: executionAddress ?? this.executionAddress,
      executionCity: executionCity ?? this.executionCity,
      specialInstructions: specialInstructions ?? this.specialInstructions,
      quoteMetadata: quoteMetadata ?? this.quoteMetadata,
      verificationPin: verificationPin ?? this.verificationPin,
      invoiceUrl: invoiceUrl ?? this.invoiceUrl,
      isPaid: isPaid ?? this.isPaid,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt ?? this.startedAt,
      items: items ?? this.items,
      requestedService: requestedService ?? this.requestedService,
      customer: customer ?? this.customer,
      provider: provider ?? this.provider,
    );
  }

  @override
  List<Object?> get props => [
    bookingId,
    bookingReference,
    bookingType,
    fulfillmentType,
    addressId,
    chatRoomId,
    status,
    customerLatitude,
    customerLongitude,
    providerLatitude,
    providerLongitude,
    paymentMethod,
    amount,
    subtotalAmount,
    safetyFee,
    totalAmount,
    rawSubtotalAmount,
    rawSafetyFee,
    rawTotalAmount,
    payoutAmount,
    scheduledAt,
    executionAddress,
    executionCity,
    specialInstructions,
    quoteMetadata,
    verificationPin,
    invoiceUrl,
    isPaid,
    paymentStatus,
    createdAt,
    startedAt,
    items,
    requestedService,
    customer,
    provider,
  ];
}
