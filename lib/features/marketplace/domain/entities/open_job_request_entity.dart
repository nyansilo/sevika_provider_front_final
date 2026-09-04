import 'package:equatable/equatable.dart';

class OpenJobRequestEntity extends Equatable {
  final int jobRequestId;
  final String category;
  final String title;
  final String description;
  final String status;
  final String createdAt;

  const OpenJobRequestEntity({
    required this.jobRequestId,
    required this.category,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    jobRequestId,
    category,
    title,
    description,
    status,
    createdAt,
  ];
}
