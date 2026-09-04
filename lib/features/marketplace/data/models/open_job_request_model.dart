import '../../domain/entities/open_job_request_entity.dart';

class OpenJobRequestModel extends OpenJobRequestEntity {
  const OpenJobRequestModel({
    required super.jobRequestId,
    required super.category,
    required super.title,
    required super.description,
    required super.status,
    required super.createdAt,
  });

  // 🎯 STRICT MAPPING: Exposes explicit conversion to Domain Entity
  OpenJobRequestEntity toEntity() => this;

  factory OpenJobRequestModel.fromJson(Map<String, dynamic> json) {
    return OpenJobRequestModel(
      jobRequestId: num.tryParse(json['jobRequestId'].toString())?.toInt() ?? 0,
      category: json['category']?.toString() ?? 'General',
      title: json['title']?.toString() ?? 'Untitled Request',
      description:
          json['description']?.toString() ?? 'No description provided.',
      status: json['status']?.toString() ?? 'open',
      createdAt: json['createdAt']?.toString() ?? '',
    );
  }
}
