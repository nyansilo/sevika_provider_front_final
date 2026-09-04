import 'package:flutter/foundation.dart';
import '../../domain/entities/district_entity.dart';

class DistrictModel extends DistrictEntity {
  const DistrictModel({
    required super.id,
    required super.regionId,
    required super.name,
  });

  DistrictEntity toEntity() => this;

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    try {
      return DistrictModel(
        id: json['id'] as int? ?? 0,
        regionId: json['regionId'] as int? ?? json['region_id'] as int? ?? 0,
        name: json['name']?.toString() ?? '',
      );
    } catch (e) {
      debugPrint('Error parsing DistrictModel: $e');
      throw FormatException('Invalid structural district packet: $e');
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'regionId': regionId,
    'name': name,
  };
}
