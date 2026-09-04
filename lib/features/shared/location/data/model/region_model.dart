import 'package:flutter/foundation.dart';
import '../../domain/entities/region_entity.dart';

class RegionModel extends RegionEntity {
  const RegionModel({required super.id, required super.name});

  RegionEntity toEntity() => this;

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    try {
      return RegionModel(
        id: json['id'] as int? ?? 0,
        name: json['name']?.toString() ?? '',
      );
    } catch (e) {
      debugPrint('Error parsing RegionModel: $e');
      throw FormatException('Invalid structural region packet: $e');
    }
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
