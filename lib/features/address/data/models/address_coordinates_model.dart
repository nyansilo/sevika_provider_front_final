import '../../domain/entities/address_coordinates_entity.dart';

class AddressCoordinatesModel extends AddressCoordinatesEntity {
  const AddressCoordinatesModel({
    required super.latitude,
    required super.longitude,
  });

  factory AddressCoordinatesModel.fromJson(Map<String, dynamic> json) {
    return AddressCoordinatesModel(
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
