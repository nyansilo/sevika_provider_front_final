class UpdateOfferingParams {
  final String serviceId;
  final String? title;
  final String? description;
  final int? categoryId;
  final String? pricingType;
  final String? fulfillmentType;
  final double? visitFee;
  final String? estimatedDuration;
  final bool? supportsInstantBooking;
  final bool? isActive;
  final List<String>? inclusions;
  final List<String>? exclusions;

  UpdateOfferingParams({
    required this.serviceId,
    this.title,
    this.description,
    this.categoryId,
    this.pricingType,
    this.fulfillmentType,
    this.visitFee,
    this.estimatedDuration,
    this.supportsInstantBooking,
    this.isActive,
    this.inclusions,
    this.exclusions,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (title != null) map['title'] = title;
    if (description != null) map['description'] = description;
    if (categoryId != null) map['categoryId'] = categoryId;
    if (pricingType != null) map['pricingType'] = pricingType;
    if (fulfillmentType != null) map['fulfillmentType'] = fulfillmentType;
    if (visitFee != null) map['visitFee'] = visitFee;
    if (estimatedDuration != null) map['estimatedDuration'] = estimatedDuration;
    if (supportsInstantBooking != null) {
      map['supportsInstantBooking'] = supportsInstantBooking;
    }

    // 🚀 EXACT MATCH WITH POSTMAN: 'isActive'
    if (isActive != null) map['isActive'] = isActive;

    if (inclusions != null && inclusions!.isNotEmpty) {
      map['inclusions'] = inclusions;
    }
    if (exclusions != null && exclusions!.isNotEmpty) {
      map['exclusions'] = exclusions;
    }

    return map;
  }
}
