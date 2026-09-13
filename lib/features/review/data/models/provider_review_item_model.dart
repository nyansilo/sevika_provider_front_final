// import '../../domain/entities/provider_review_item_entity.dart';
// import 'provider_review_customer_model.dart';

// class ProviderReviewItemModel extends ProviderReviewItemEntity {
//   const ProviderReviewItemModel({
//     required super.reviewId,
//     required super.bookingId,
//     super.bookingRef,
//     required super.score,
//     required super.feedback,
//     super.providerReply,
//     super.repliedAt,
//     required super.submitted,
//     required super.timeAgo,
//     required super.serviceName,
//     required ProviderReviewCustomerModel super.customer,
//   });

//   factory ProviderReviewItemModel.fromJson(Map<String, dynamic> json) {
//     return ProviderReviewItemModel(
//       reviewId: json['reviewId'] as int? ?? json['id'] as int? ?? 0,
//       bookingId: json['bookingId'] as int? ?? json['booking_id'] as int? ?? 0,
//       bookingRef: json['bookingRef']?.toString(),
//       score: json['score'] as int? ?? json['rating'] as int? ?? 0,
//       feedback:
//           json['feedback']?.toString() ?? json['comment']?.toString() ?? '',
//       providerReply:
//           json['providerReply']?.toString() ??
//           json['provider_reply']?.toString(),
//       repliedAt:
//           json['repliedAt']?.toString() ?? json['replied_at']?.toString(),
//       submitted: json['submitted']?.toString() ?? '',
//       timeAgo: json['timeAgo']?.toString() ?? '',
//       serviceName: json['serviceName']?.toString() ?? 'Service',
//       customer: ProviderReviewCustomerModel.fromJson(
//         json['customer'] as Map<String, dynamic>? ?? const {},
//       ),
//     );
//   }
// }

// lib/features/reviews/data/models/provider_review_item_model.dart
import '../../domain/entities/provider_review_item_entity.dart';
import 'provider_review_customer_model.dart';

class ProviderReviewItemModel extends ProviderReviewItemEntity {
  const ProviderReviewItemModel({
    required super.reviewId,
    required super.bookingId,
    super.bookingRef,
    required super.score,
    required super.feedback,
    super.providerReply,
    super.repliedAt,
    required super.submitted,
    required super.timeAgo,
    required super.serviceName,
    required ProviderReviewCustomerModel super.customer,
  });

  factory ProviderReviewItemModel.fromJson(Map<String, dynamic> json) {
    return ProviderReviewItemModel(
      reviewId: json['reviewId'] as int? ?? json['id'] as int? ?? 0,
      bookingId: json['bookingId'] as int? ?? json['booking_id'] as int? ?? 0,
      bookingRef: json['bookingRef']?.toString(),
      score: json['score'] as int? ?? json['rating'] as int? ?? 0,
      feedback:
          json['feedback']?.toString() ?? json['comment']?.toString() ?? '',
      providerReply:
          json['providerReply']?.toString() ??
          json['provider_reply']?.toString(),
      repliedAt:
          json['repliedAt']?.toString() ?? json['replied_at']?.toString(),
      submitted: json['submitted']?.toString() ?? '',
      timeAgo: json['timeAgo']?.toString() ?? '',
      serviceName: json['serviceName']?.toString() ?? 'Service',
      customer: ProviderReviewCustomerModel.fromJson(
        json['customer'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }

  /// 🚀 Explicit conversion to Entity
  ProviderReviewItemEntity toEntity() {
    return ProviderReviewItemEntity(
      reviewId: reviewId,
      bookingId: bookingId,
      bookingRef: bookingRef,
      score: score,
      feedback: feedback,
      providerReply: providerReply,
      repliedAt: repliedAt,
      submitted: submitted,
      timeAgo: timeAgo,
      serviceName: serviceName,
      customer: (customer as ProviderReviewCustomerModel).toEntity(),
    );
  }
}
