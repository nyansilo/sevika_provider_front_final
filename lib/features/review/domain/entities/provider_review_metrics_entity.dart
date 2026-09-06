import 'package:equatable/equatable.dart';

class ProviderReviewMetricsEntity extends Equatable {
  final double averageRating;
  final int totalReviewCount;

  const ProviderReviewMetricsEntity({
    required this.averageRating,
    required this.totalReviewCount,
  });

  @override
  List<Object?> get props => [averageRating, totalReviewCount];
}
