// import 'package:flutter/foundation.dart';
// import '../../domain/entities/customer_address_entity.dart';
// import 'address_coordinates_model.dart';

// class CustomerAddressModel extends CustomerAddressEntity {
//   const CustomerAddressModel({
//     required super.addressId,
//     required super.label,
//     required super.addressLine1,
//     super.addressLine2,
//     required super.city,
//     required super.regionOrState,
//     super.postalCode,
//     required super.country,
//     required AddressCoordinatesModel super.coordinates,
//     required super.isDefault,
//     super.createdAt,
//   });

//   CustomerAddressEntity toEntity() => this;

//   factory CustomerAddressModel.fromJson(Map<String, dynamic> json) {
//     try {
//       return CustomerAddressModel(
//         addressId:
//             json['addressId']?.toString() ?? json['id']?.toString() ?? '',
//         label: json['label']?.toString() ?? '',
//         addressLine1:
//             json['addressLine1']?.toString() ??
//             json['address_line_1']?.toString() ??
//             '',
//         addressLine2:
//             json['addressLine2']?.toString() ??
//             json['address_line_2']?.toString(),
//         city: json['city']?.toString() ?? '',
//         regionOrState:
//             json['regionOrState']?.toString() ??
//             json['region_or_state']?.toString() ??
//             '',
//         postalCode:
//             json['postalCode']?.toString() ?? json['postal_code']?.toString(),
//         country: json['country']?.toString() ?? 'Tanzania',
//         coordinates: AddressCoordinatesModel.fromJson(
//           json['coordinates'] as Map<String, dynamic>? ?? const {},
//         ),
//         isDefault: json['isDefault'] is bool
//             ? json['isDefault'] as bool
//             : (json['is_default'] as bool? ?? false),
//         createdAt: json['createdAt'] != null
//             ? DateTime.tryParse(json['createdAt'].toString())
//             : (json['created_at'] != null
//                   ? DateTime.tryParse(json['created_at'].toString())
//                   : null),
//       );
//     } catch (e, stackTrace) {
//       debugPrint(
//         'Parsing Exception inside CustomerAddressModel: $e \n $stackTrace',
//       );
//       throw FormatException(
//         'Invalid Data Packet Structure for Address payload: $e',
//       );
//     }
//   }
// }

import 'package:flutter/foundation.dart';
import '../../domain/entities/customer_address_entity.dart';
import 'address_coordinates_model.dart';

class CustomerAddressModel extends CustomerAddressEntity {
  const CustomerAddressModel({
    required super.addressId,
    required super.label,
    required super.addressLine1,
    super.addressLine2,
    required super.regionId,
    required super.regionName,
    required super.districtId,
    required super.districtName,
    super.postalCode,
    required super.country,
    required AddressCoordinatesModel super.coordinates,
    required super.isDefault,
    super.createdAt,
  });

  CustomerAddressEntity toEntity() => this;

  factory CustomerAddressModel.fromJson(Map<String, dynamic> json) {
    try {
      return CustomerAddressModel(
        addressId:
            json['addressId']?.toString() ?? json['id']?.toString() ?? '',
        label: json['label']?.toString() ?? '',
        addressLine1:
            json['addressLine1']?.toString() ??
            json['address_line_1']?.toString() ??
            '',
        addressLine2:
            json['addressLine2']?.toString() ??
            json['address_line_2']?.toString(),
        regionId: (json['regionId'] ?? json['region_id'] as num?)?.toInt() ?? 0,
        regionName:
            json['regionName']?.toString() ??
            json['region_name']?.toString() ??
            '',
        districtId:
            (json['districtId'] ?? json['district_id'] as num?)?.toInt() ?? 0,
        districtName:
            json['districtName']?.toString() ??
            json['district_name']?.toString() ??
            '',
        postalCode:
            json['postalCode']?.toString() ?? json['postal_code']?.toString(),
        country: json['country']?.toString() ?? 'Tanzania',
        coordinates: AddressCoordinatesModel.fromJson(
          json['coordinates'] as Map<String, dynamic>? ?? const {},
        ),
        isDefault: json['isDefault'] is bool
            ? json['isDefault'] as bool
            : (json['is_default'] as bool? ?? false),
        createdAt: json['createdAt'] != null
            ? DateTime.tryParse(json['createdAt'].toString())
            : (json['created_at'] != null
                  ? DateTime.tryParse(json['created_at'].toString())
                  : null),
      );
    } catch (e, stackTrace) {
      debugPrint(
        'Parsing Exception inside CustomerAddressModel: $e \n $stackTrace',
      );
      throw FormatException(
        'Invalid Data Packet Structure for Address payload: $e',
      );
    }
  }
}
