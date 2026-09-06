import 'package:equatable/equatable.dart';

class ReplyToReviewParams extends Equatable {
  final int reviewId;
  final String providerReply;

  const ReplyToReviewParams({
    required this.reviewId,
    required this.providerReply,
  });

  Map<String, dynamic> toMap() => {'providerReply': providerReply};

  @override
  List<Object?> get props => [reviewId, providerReply];
}
