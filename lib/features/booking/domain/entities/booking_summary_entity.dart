import 'package:equatable/equatable.dart';

class BookingSummaryEntity extends Equatable {
  final int totalCount;
  final int activeCount;
  final int completedCount;

  const BookingSummaryEntity({
    required this.totalCount,
    required this.activeCount,
    required this.completedCount,
  });

  @override
  List<Object?> get props => [totalCount, activeCount, completedCount];
}
