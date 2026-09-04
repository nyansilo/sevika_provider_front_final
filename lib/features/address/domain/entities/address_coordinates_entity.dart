// // domain/entities/address_coordinates_entity.dart
// import 'package:equatable/equatable.dart';

// class AddressCoordinatesEntity extends Equatable {
//   final double latitude;
//   final double longitude;

//   const AddressCoordinatesEntity({
//     required this.latitude,
//     required this.longitude,
//   });

//   @override
//   List<Object?> get props => [latitude, longitude];
// }

import 'package:equatable/equatable.dart';

class AddressCoordinatesEntity extends Equatable {
  final double latitude;
  final double longitude;

  const AddressCoordinatesEntity({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}
