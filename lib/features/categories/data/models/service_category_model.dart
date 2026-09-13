// import 'package:flutter/foundation.dart';
// import '../../domain/entities/service_category_entity.dart';

// class ServiceCategoryModel extends ServiceCategoryEntity {
//   const ServiceCategoryModel({
//     required super.categoryId,
//     required super.name,
//     required super.slug,
//     required super.iconUrl,
//     required super.isActive,
//     required super.isEmergency,
//   });

//   ServiceCategoryEntity toEntity() => this;

//   factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) {
//     try {
//       final bool parsedIsActive = json['isActive'] is bool
//           ? json['isActive'] as bool
//           : (json['is_active'] as bool? ?? true);

//       return ServiceCategoryModel(
//         // Maps backend structural integer key 'id' to domain model requirements cleanly
//         categoryId: json['id'] as int? ?? json['categoryId'] as int? ?? 0,
//         name: json['name']?.toString() ?? '',
//         slug: json['slug']?.toString() ?? '',
//         iconUrl:
//             json['image']?.toString() ??
//             json['iconUrl']?.toString() ??
//             json['icon_url']?.toString() ??
//             '',
//         isActive: parsedIsActive,
//         isEmergency:
//             json['is_emergency'] as bool? ??
//             json['isEmergency'] as bool? ??
//             false,
//       );
//     } catch (e) {
//       debugPrint('Error parsing ServiceCategoryModel: $e');
//       throw FormatException('Invalid service category structural packet: $e');
//     }
//   }

//   Map<String, dynamic> toJson() => {
//     'id': categoryId,
//     'name': name,
//     'slug': slug,
//     'icon_url': iconUrl,
//     'is_active': isActive,
//     'is_emergency': isEmergency,
//   };
// }

import 'package:flutter/foundation.dart';
import '../../domain/entities/service_category_entity.dart';

class ServiceCategoryModel extends ServiceCategoryEntity {
  const ServiceCategoryModel({
    required super.categoryId,
    required super.name,
    required super.slug,
    required super.iconUrl,
    required super.isActive,
    required super.isEmergency,
  });

  ServiceCategoryEntity toEntity() => this;

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    try {
      final bool parsedIsActive = json['isActive'] is bool
          ? json['isActive'] as bool
          : (json['is_active'] as bool? ?? true);

      // 🎯 FIXED: Safely handle 1/0, "1"/"0", "true"/"false", and true/false
      bool parseBoolean(dynamic value) {
        if (value is bool) return value;
        if (value is int) return value == 1;
        if (value is String) {
          return value == '1' || value.toLowerCase() == 'true';
        }
        return false;
      }

      return ServiceCategoryModel(
        categoryId: json['id'] as int? ?? json['categoryId'] as int? ?? 0,
        name: json['name']?.toString() ?? '',
        slug: json['slug']?.toString() ?? '',
        iconUrl:
            json['image']?.toString() ??
            json['iconUrl']?.toString() ??
            json['icon_url']?.toString() ??
            '',
        isActive: parsedIsActive,
        // 🎯 Apply the safe parser to both possible keys
        isEmergency:
            parseBoolean(json['is_emergency']) ||
            parseBoolean(json['isEmergency']),
      );
    } catch (e) {
      debugPrint('Error parsing ServiceCategoryModel: $e');
      throw FormatException('Invalid service category structural packet: $e');
    }
  }

  Map<String, dynamic> toJson() => {
    'id': categoryId,
    'name': name,
    'slug': slug,
    'icon_url': iconUrl,
    'is_active': isActive,
    'is_emergency': isEmergency,
  };
}
