import 'package:equatable/equatable.dart';
import 'region_entity.dart';
import 'district_entity.dart';

class LocationBoundariesEntity extends Equatable {
  final List<RegionEntity> regions;
  final List<DistrictEntity> districts;

  const LocationBoundariesEntity({
    required this.regions,
    required this.districts,
  });

  @override
  List<Object?> get props => [regions, districts];
}
