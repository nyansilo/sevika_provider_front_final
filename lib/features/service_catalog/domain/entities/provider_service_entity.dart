// import 'package:equatable/equatable.dart';

// import '../enums/service_status.dart';

// class ProviderServiceEntity extends Equatable {
//   final String serviceId;
//   final String title;
//   final String slug;
//   final String description;
//   final ServiceStatus status;
//   final String? rejectionReason;
//   final String? image;
//   final bool isActive;
//   final int categoryId;
//   final String pricingType;
//   final String fulfillmentType;
//   final double visitFee;
//   final int minNoticeHours;
//   final int maxQuantityPerBooking;
//   final double platformCommission;
//   final double providerTakeHome;
//   final int totalBookings;

//   const ProviderServiceEntity({
//     required this.serviceId,
//     required this.title,
//     required this.slug,
//     required this.description,
//     required this.status,
//     this.rejectionReason,
//     this.image,
//     required this.isActive,
//     required this.categoryId,
//     required this.pricingType,
//     required this.fulfillmentType,
//     required this.visitFee,
//     required this.minNoticeHours,
//     required this.maxQuantityPerBooking,
//     required this.platformCommission,
//     required this.providerTakeHome,
//     required this.totalBookings,
//   });

//   @override
//   List<Object?> get props => [serviceId, status, isActive, visitFee, title];
// }

import 'package:equatable/equatable.dart';

import '../enums/service_status.dart';

class ProviderServiceEntity extends Equatable {
  final String serviceId;
  final String title;
  final String slug;
  final String description;
  final ServiceStatus status;
  final String? rejectionReason;
  final String? image;
  final bool isActive;
  final int categoryId;
  final String pricingType;
  final String fulfillmentType;
  final double visitFee;
  final int minNoticeHours;
  final int maxQuantityPerBooking;
  final double platformCommission;
  final double providerTakeHome;
  final int totalBookings;

  // 🚀 THE FIX: Add the new fields
  final String? estimatedDuration;
  final bool supportsInstantBooking;
  final List<String> inclusions;
  final List<String> exclusions;

  const ProviderServiceEntity({
    required this.serviceId,
    required this.title,
    required this.slug,
    required this.description,
    required this.status,
    this.rejectionReason,
    this.image,
    required this.isActive,
    required this.categoryId,
    required this.pricingType,
    required this.fulfillmentType,
    required this.visitFee,
    required this.minNoticeHours,
    required this.maxQuantityPerBooking,
    required this.platformCommission,
    required this.providerTakeHome,
    required this.totalBookings,

    // 🚀 THE FIX: Add to constructor
    this.estimatedDuration,
    this.supportsInstantBooking = true,
    this.inclusions = const [],
    this.exclusions = const [],
  });

  @override
  List<Object?> get props => [
    serviceId,
    status,
    isActive,
    visitFee,
    title,
    estimatedDuration,
    supportsInstantBooking,
  ];
}
