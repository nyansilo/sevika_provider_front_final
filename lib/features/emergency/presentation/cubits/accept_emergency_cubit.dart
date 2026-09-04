import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/accept_emergency_usecase.dart';
import '../../domain/usecases/params/accept_emergency_params.dart';
import 'accept_emergency_state.dart';

class AcceptEmergencyCubit extends Cubit<AcceptEmergencyState> {
  final AcceptEmergencyUseCase useCase;
  AcceptEmergencyCubit({required this.useCase})
    : super(AcceptEmergencyInitial());

  Future<void> acceptSOS(String dispatchId) async {
    emit(AcceptEmergencyLoading());
    final result = await useCase.call(
      AcceptEmergencyParams(dispatchId: dispatchId),
    );
    if (isClosed) return;
    result.fold(
      (error) => emit(AcceptEmergencyFailure(error)),
      (booking) => emit(AcceptEmergencySuccess(booking)),
    );
  }
}
