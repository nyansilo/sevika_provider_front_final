// class ProposeServiceParams {
//   final String title;
//   final String description;
//   final int categoryId;
//   final String pricingType;
//   final String fulfillmentType;
//   final double visitFee;
//   final String estimatedDuration;
//   final bool supportsInstantBooking;
//   final List<String>? inclusions;
//   final List<String>? exclusions;

//   ProposeServiceParams({
//     required this.title,
//     required this.description,
//     required this.categoryId,
//     required this.pricingType,
//     required this.fulfillmentType,
//     required this.visitFee,
//     required this.estimatedDuration,
//     required this.supportsInstantBooking,
//     this.inclusions,
//     this.exclusions,
//   });

//   Map<String, dynamic> toJson() => {
//     "title": title,
//     "description": description,
//     "categoryId": categoryId,
//     "pricingType": pricingType,
//     "fulfillmentType": fulfillmentType,
//     "visitFee": visitFee,
//     "estimatedDuration": estimatedDuration,
//     "supportsInstantBooking": supportsInstantBooking,
//     "inclusions": inclusions,
//     "exclusions": exclusions,
//   };
// }

class ProposeServiceParams {
  final String title;
  final String description;
  final int categoryId;
  final String pricingType;
  final String fulfillmentType;
  final double visitFee;
  final String estimatedDuration;
  final bool supportsInstantBooking;
  final List<String>? inclusions;
  final List<String>? exclusions;

  ProposeServiceParams({
    required this.title,
    required this.description,
    required this.categoryId,
    required this.pricingType,
    required this.fulfillmentType,
    required this.visitFee,
    required this.estimatedDuration,
    required this.supportsInstantBooking,
    this.inclusions,
    this.exclusions,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "categoryId": categoryId,
      "pricingType": pricingType,
      "fulfillmentType": fulfillmentType,
      "visitFee": visitFee,
      "estimatedDuration": estimatedDuration,
      "supportsInstantBooking": supportsInstantBooking,

      // 🚀 THE FIX: Only attach these to the JSON payload if they actually have data!
      if (inclusions != null && inclusions!.isNotEmpty)
        "inclusions": inclusions,
      if (exclusions != null && exclusions!.isNotEmpty)
        "exclusions": exclusions,
    };
  }
}
