// // domain/entities/customer_address_entity.dart
// import 'package:equatable/equatable.dart';
// import 'address_coordinates_entity.dart';

// class CustomerAddressEntity extends Equatable {
//   final String addressId;
//   final String label;
//   final String addressLine1;
//   final String? addressLine2;
//   final String city;
//   final String regionOrState;
//   final String? postalCode;
//   final String country;
//   final AddressCoordinatesEntity coordinates;
//   final bool isDefault;
//   final DateTime? createdAt;

//   const CustomerAddressEntity({
//     required this.addressId,
//     required this.label,
//     required this.addressLine1,
//     this.addressLine2,
//     required this.city,
//     required this.regionOrState,
//     this.postalCode,
//     required this.country,
//     required this.coordinates,
//     required this.isDefault,
//     this.createdAt,
//   });

//   @override
//   List<Object?> get props => [
//     addressId,
//     label,
//     addressLine1,
//     addressLine2,
//     city,
//     regionOrState,
//     postalCode,
//     country,
//     coordinates,
//     isDefault,
//     createdAt,
//   ];
// }

import 'package:equatable/equatable.dart';
import 'address_coordinates_entity.dart';

class CustomerAddressEntity extends Equatable {
  final String addressId;
  final String label;
  final String addressLine1;
  final String? addressLine2;
  // 🎯 UPDATED: Swapped out legacy city/regionOrState string parameters
  final int regionId;
  final String regionName;
  final int districtId;
  final String districtName;
  final String? postalCode;
  final String country;
  final AddressCoordinatesEntity coordinates;
  final bool isDefault;
  final DateTime? createdAt;

  const CustomerAddressEntity({
    required this.addressId,
    required this.label,
    required this.addressLine1,
    this.addressLine2,
    required this.regionId,
    required this.regionName,
    required this.districtId,
    required this.districtName,
    this.postalCode,
    required this.country,
    required this.coordinates,
    required this.isDefault,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
    addressId,
    label,
    addressLine1,
    addressLine2,
    regionId,
    regionName,
    districtId,
    districtName,
    postalCode,
    country,
    coordinates,
    isDefault,
    createdAt,
  ];
}
