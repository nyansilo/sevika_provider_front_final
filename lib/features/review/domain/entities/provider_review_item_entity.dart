import 'package:equatable/equatable.dart';

import 'provider_review_customer_entity.dart';

class ProviderReviewItemEntity extends Equatable {
  final int reviewId;
  final int bookingId;
  final String? bookingRef;
  final int score;
  final String feedback;
  final String? providerReply;
  final String? repliedAt;
  final String submitted;
  final String timeAgo;
  final String serviceName;
  final ProviderReviewCustomerEntity customer;

  const ProviderReviewItemEntity({
    required this.reviewId,
    required this.bookingId,
    this.bookingRef,
    required this.score,
    required this.feedback,
    this.providerReply,
    this.repliedAt,
    required this.submitted,
    required this.timeAgo,
    required this.serviceName,
    required this.customer,
  });

  @override
  List<Object?> get props => [
    reviewId,
    bookingId,
    bookingRef,
    score,
    feedback,
    providerReply,
    repliedAt,
    submitted,
    timeAgo,
    serviceName,
    customer,
  ];
}
