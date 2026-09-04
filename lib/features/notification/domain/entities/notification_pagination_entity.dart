import 'package:equatable/equatable.dart';

class NotificationPaginationEntity extends Equatable {
  final int total;
  final int count;
  final int perPage;
  final int currentPage;
  final int lastPage;
  final bool hasNextPage;

  const NotificationPaginationEntity({
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
    required this.hasNextPage,
  });

  @override
  List<Object?> get props => [
    total,
    count,
    perPage,
    currentPage,
    lastPage,
    hasNextPage,
  ];
}
