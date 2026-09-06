import 'package:equatable/equatable.dart';

class ProviderReviewPaginationEntity extends Equatable {
  final int currentPage;
  final bool hasMore;

  const ProviderReviewPaginationEntity({
    required this.currentPage,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [currentPage, hasMore];
}
