import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/toggle_availability_use_case.dart';
import 'provider_status_state.dart';

/// 🛡️ CUBIT: Handles only the Online/Offline state to prevent full-screen rebuilds.
class ProviderStatusCubit extends Cubit<ProviderStatusState> {
  final ToggleAvailabilityUseCase toggleAvailabilityUseCase;

  ProviderStatusCubit({required this.toggleAvailabilityUseCase})
    : super(ProviderStatusState());

  /// Calls the Laravel backend to toggle online/offline status via the UseCase.
  Future<bool> toggleStatus({required bool isOnline}) async {
    emit(ProviderStatusState(isLoading: true, isOnline: state.isOnline));

    final result = await toggleAvailabilityUseCase.call(
      ToggleAvailabilityParams(isOnline: isOnline),
    );

    // 🎯 Guard against screen closures during network request
    if (isClosed) return false;

    return result.fold(
      (error) {
        emit(
          ProviderStatusState(
            isLoading: false,
            isOnline: state.isOnline,
            error: error.message,
          ),
        );
        return false;
      },
      (backendConfirmedStatus) {
        emit(
          ProviderStatusState(
            isLoading: false,
            isOnline: backendConfirmedStatus,
          ),
        );
        return true;
      },
    );
  }

  /// Hydrates the initial state when the user logs in
  void setInitialStatus(bool isOnline) {
    emit(ProviderStatusState(isLoading: false, isOnline: isOnline));
  }
}
