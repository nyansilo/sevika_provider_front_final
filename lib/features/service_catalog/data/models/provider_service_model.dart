// import '../../domain/entities/provider_service_entity.dart';
// import '../../domain/enums/service_status.dart';

// class ProviderServiceModel extends ProviderServiceEntity {
//   const ProviderServiceModel({
//     required super.serviceId,
//     required super.title,
//     required super.slug,
//     required super.description,
//     required super.status,
//     super.rejectionReason,
//     super.image,
//     required super.isActive,
//     required super.categoryId,
//     required super.pricingType,
//     required super.fulfillmentType,
//     required super.visitFee,
//     required super.minNoticeHours,
//     required super.maxQuantityPerBooking,
//     required super.platformCommission,
//     required super.providerTakeHome,
//     required super.totalBookings,
//   });

//   factory ProviderServiceModel.fromJson(Map<String, dynamic> json) {
//     final calculations = json['calculations'] ?? {};
//     final analytics = json['analytics'] ?? {};

//     return ProviderServiceModel(
//       serviceId: json['serviceId'] ?? '',
//       title: json['title'] ?? '',
//       slug: json['slug'] ?? '',
//       description: json['description'] ?? '',
//       status: ServiceStatus.fromString(json['status'] ?? 'unknown'),
//       rejectionReason: json['rejectionReason'],
//       image: json['image'],
//       isActive: json['isActive'] ?? false,
//       categoryId: json['categoryId'] ?? 0,
//       pricingType: json['pricingType'] ?? '',
//       fulfillmentType: json['fulfillmentType'] ?? '',
//       visitFee: (json['visitFee'] as num?)?.toDouble() ?? 0.0,
//       minNoticeHours: (json['minNoticeHours'] as num?)?.toInt() ?? 1,
//       maxQuantityPerBooking:
//           (json['maxQuantityPerBooking'] as num?)?.toInt() ?? 1,
//       platformCommission:
//           (calculations['platformCommission'] as num?)?.toDouble() ?? 0.0,
//       providerTakeHome:
//           (calculations['providerTakeHome'] as num?)?.toDouble() ?? 0.0,
//       totalBookings: (analytics['totalBookings'] as num?)?.toInt() ?? 0,
//     );
//   }

//   ProviderServiceEntity toEntity() => this;
// }

import '../../domain/entities/provider_service_entity.dart';
import '../../domain/enums/service_status.dart';

class ProviderServiceModel extends ProviderServiceEntity {
  const ProviderServiceModel({
    required super.serviceId,
    required super.title,
    required super.slug,
    required super.description,
    required super.status,
    super.rejectionReason,
    super.image,
    required super.isActive,
    required super.categoryId,
    required super.pricingType,
    required super.fulfillmentType,
    required super.visitFee,
    required super.minNoticeHours,
    required super.maxQuantityPerBooking,
    required super.platformCommission,
    required super.providerTakeHome,
    required super.totalBookings,

    // 🚀 THE FIX: Add to Model constructor
    super.estimatedDuration,
    super.supportsInstantBooking,
    super.inclusions,
    super.exclusions,
  });

  factory ProviderServiceModel.fromJson(Map<String, dynamic> json) {
    final calculations = json['calculations'] ?? {};
    final analytics = json['analytics'] ?? {};

    return ProviderServiceModel(
      serviceId: json['serviceId'] ?? '',
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      status: ServiceStatus.fromString(json['status'] ?? 'unknown'),
      rejectionReason: json['rejectionReason'],
      image: json['image'],
      isActive: json['isActive'] ?? false,
      categoryId: json['categoryId'] ?? 0,
      pricingType: json['pricingType'] ?? '',
      fulfillmentType: json['fulfillmentType'] ?? 'home', // Fallback added
      // 🚀 THE FIX: Parse the new fields!
      estimatedDuration: json['estimatedDuration']?.toString(),
      supportsInstantBooking: json['supportsInstantBooking'] as bool? ?? true,
      inclusions:
          (json['inclusions'] as List?)?.map((e) => e.toString()).toList() ??
          [],
      exclusions:
          (json['exclusions'] as List?)?.map((e) => e.toString()).toList() ??
          [],

      visitFee: (json['visitFee'] as num?)?.toDouble() ?? 0.0,
      minNoticeHours: (json['minNoticeHours'] as num?)?.toInt() ?? 1,
      maxQuantityPerBooking:
          (json['maxQuantityPerBooking'] as num?)?.toInt() ?? 1,
      platformCommission:
          (calculations['platformCommission'] as num?)?.toDouble() ?? 0.0,
      providerTakeHome:
          (calculations['providerTakeHome'] as num?)?.toDouble() ?? 0.0,
      totalBookings: (analytics['totalBookings'] as num?)?.toInt() ?? 0,
    );
  }

  ProviderServiceEntity toEntity() => this;
}
