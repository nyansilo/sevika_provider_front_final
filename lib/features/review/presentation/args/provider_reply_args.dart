class ProviderReplyArgs {
  final int reviewId;
  final String customerName;
  final String serviceName;
  final String feedback;
  final int score;
  final String? existingReply;

  ProviderReplyArgs({
    required this.reviewId,
    required this.customerName,
    required this.serviceName,
    required this.feedback,
    required this.score,
    this.existingReply,
  });
}
