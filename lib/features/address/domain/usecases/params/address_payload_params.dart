// import 'package:equatable/equatable.dart';

// class AddressPayloadParams extends Equatable {
//   final String label;
//   final String addressLine1;
//   final String? addressLine2;
//   final String city;
//   final String regionOrState;
//   final String? postalCode;
//   final String country;
//   final double? latitude;
//   final double? longitude;
//   final bool isDefault;

//   const AddressPayloadParams({
//     required this.label,
//     required this.addressLine1,
//     this.addressLine2,
//     required this.city,
//     required this.regionOrState,
//     this.postalCode,
//     this.country = 'Tanzania',
//     this.latitude,
//     this.longitude,
//     required this.isDefault,
//   });

//   /// 🚀 ALIGNED: Maps perfectly to camelCase parameters for backend parsing validation layers
//   Map<String, dynamic> toMap() {
//     return {
//       'label': label,
//       'addressLine1': addressLine1,
//       if (addressLine2 != null) 'addressLine2': addressLine2,
//       'city': city,
//       'regionOrState': regionOrState,
//       if (postalCode != null) 'postalCode': postalCode,
//       'country': country,
//       if (latitude != null && longitude != null)
//         'coordinates': {'latitude': latitude, 'longitude': longitude},
//       'isDefault': isDefault ? 1 : 0, // Keeps your integer flag handling intact
//     };
//   }

//   /// Alias method provided to prevent breakage if referenced elsewhere in your core codebase interceptors
//   Map<String, dynamic> toJson() => toMap();

//   @override
//   List<Object?> get props => [
//     label,
//     addressLine1,
//     addressLine2,
//     city,
//     regionOrState,
//     postalCode,
//     country,
//     latitude,
//     longitude,
//     isDefault,
//   ];
// }

import 'package:equatable/equatable.dart';

class AddressPayloadParams extends Equatable {
  final String label;
  final String addressLine1;
  final String? addressLine2;
  final int regionId;
  final int districtId;
  final String? postalCode;
  final String country;
  final double? latitude;
  final double? longitude;
  final bool isDefault;

  const AddressPayloadParams({
    required this.label,
    required this.addressLine1,
    this.addressLine2,
    required this.regionId,
    required this.districtId,
    this.postalCode,
    this.country = 'Tanzania',
    this.latitude,
    this.longitude,
    required this.isDefault,
  });

  /// 🚀 ALIGNED: Maps perfectly to camelCase parameters for backend parsing validation layers
  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'addressLine1': addressLine1,
      if (addressLine2 != null) 'addressLine2': addressLine2,
      'regionId': regionId,
      'districtId': districtId,
      if (postalCode != null) 'postalCode': postalCode,
      'country': country,
      if (latitude != null && longitude != null)
        'coordinates': {'latitude': latitude, 'longitude': longitude},
      'isDefault':
          isDefault, // Matches FormRequest boolean validation expectations cleanly
    };
  }

  Map<String, dynamic> toJson() => toMap();

  @override
  List<Object?> get props => [
    label,
    addressLine1,
    addressLine2,
    regionId,
    districtId,
    postalCode,
    country,
    latitude,
    longitude,
    isDefault,
  ];
}
