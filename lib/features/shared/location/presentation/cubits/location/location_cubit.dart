import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/fetch_administrative_boundaries_usecase.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final FetchAdministrativeBoundariesUseCase
  fetchAdministrativeBoundariesUseCase;

  LocationCubit({required this.fetchAdministrativeBoundariesUseCase})
    : super(const LocationInitial());

  /// Synchronizes dynamic administrative regions and districts from the backend
  Future<void> fetchAdministrativeBoundaries({
    bool forceRefresh = false,
  }) async {
    if (state is LocationLoading && !forceRefresh) return;

    emit(const LocationLoading());

    final result = await fetchAdministrativeBoundariesUseCase.call(NoParams());

    result.fold(
      // 🎯 FIXED: Uses ?? to safely handle string? to string assignment without crashing
      (appError) => emit(
        LocationError(
          appError,
          message:
              appError.message ?? 'Failed to load administrative boundaries.',
        ),
      ),
      (boundaries) => emit(
        LocationLoaded(
          regions: boundaries.regions,
          districts: boundaries.districts,
        ),
      ),
    );
  }
}
