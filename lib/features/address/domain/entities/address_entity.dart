// import 'package:equatable/equatable.dart';

// class AddressEntity extends Equatable {
//   final String id;
//   final String title; // e.g., "Home", "Work", "Mom's House"
//   final String streetAddress; // e.g., "123 Nyerere Road"
//   final String apartmentRoom; // e.g., "Apt 4B", "Block G" (Optional)
//   final String city; // e.g., "Dar es Salaam", "Mwanza"
//   final double latitude; // Used for map marker integration
//   final double longitude; // Used for map marker integration
//   final bool isDefault; // Flag for primary checkout selection

//   const AddressEntity({
//     required this.id,
//     required this.title,
//     required this.streetAddress,
//     required this.apartmentRoom,
//     required this.city,
//     required this.latitude,
//     required this.longitude,
//     required this.isDefault,
//   });

//   /// UI Helper: Computes a clean, comma-separated printable layout block
//   String get formattedFullAddress {
//     final roomDetails = apartmentRoom.isNotEmpty ? '$apartmentRoom, ' : '';
//     return '$roomDetails$streetAddress, $city';
//   }

//   @override
//   List<Object?> get props => [
//     id,
//     title,
//     streetAddress,
//     apartmentRoom,
//     city,
//     latitude,
//     longitude,
//     isDefault,
//   ];
// }

import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String id;
  final String title; // e.g., "Home", "Work"
  final String streetAddress; // e.g., "Morogoro Road, Block G"
  final String apartmentRoom; // e.g., "Room 12" (Optional)
  final int regionId;
  final String regionName;
  final int districtId;
  final String districtName;
  final double latitude;
  final double longitude;
  final bool isDefault;

  const AddressEntity({
    required this.id,
    required this.title,
    required this.streetAddress,
    required this.apartmentRoom,
    required this.regionId,
    required this.regionName,
    required this.districtId,
    required this.districtName,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
  });

  /// UI Helper: Computes a clean, comma-separated printable layout block
  String get formattedFullAddress {
    final roomDetails = apartmentRoom.isNotEmpty ? '$apartmentRoom, ' : '';
    return '$roomDetails$streetAddress, $districtName, $regionName';
  }

  @override
  List<Object?> get props => [
    id,
    title,
    streetAddress,
    apartmentRoom,
    regionId,
    regionName,
    districtId,
    districtName,
    latitude,
    longitude,
    isDefault,
  ];
}
