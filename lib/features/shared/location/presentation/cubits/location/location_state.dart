import 'package:equatable/equatable.dart';

import '../../../../../../core/errors/app_error.dart';
import '../../../domain/entities/district_entity.dart';
import '../../../domain/entities/region_entity.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {
  const LocationInitial();
}

class LocationLoading extends LocationState {
  const LocationLoading();
}

class LocationLoaded extends LocationState {
  final List<RegionEntity> regions;
  final List<DistrictEntity> districts;

  const LocationLoaded({required this.regions, required this.districts});

  @override
  List<Object?> get props => [regions, districts];
}

class LocationError extends LocationState {
  final AppError error;
  final String message;

  const LocationError(
    this.error, {
    this.message = 'Failed to load administrative boundaries.',
  });

  @override
  List<Object?> get props => [error, message];
}
