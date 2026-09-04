import 'package:equatable/equatable.dart';

class DistrictEntity extends Equatable {
  final int id;
  final int regionId;
  final String name;

  const DistrictEntity({
    required this.id,
    required this.regionId,
    required this.name,
  });

  @override
  List<Object?> get props => [id, regionId, name];
}
