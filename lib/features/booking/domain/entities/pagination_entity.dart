import 'package:equatable/equatable.dart';

class PaginationEntity extends Equatable {
  final int total;
  final int count;
  final int perPage;
  final int currentPage;
  final int lastPage;
  final bool hasMore;

  const PaginationEntity({
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [
    total,
    count,
    perPage,
    currentPage,
    lastPage,
    hasMore,
  ];
}
