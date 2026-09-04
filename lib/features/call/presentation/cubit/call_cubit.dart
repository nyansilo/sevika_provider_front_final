import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/enums/call_type.dart';
import '../../domain/usecases/initiate_call_use_case.dart';
import '../../domain/usecases/params/initiate_call_params.dart';
import 'call_state.dart';

/// 🧠 Call Cubit
///
/// Acts as the brain between the UI (Presentation) and the Business Logic (Domain).
class CallCubit extends Cubit<CallState> {
  final InitiateCallUseCase initiateCallUseCase;

  CallCubit({required this.initiateCallUseCase}) : super(const CallInitial());

  /// Triggers the API request to fetch secure tokens for an internet call.
  ///
  /// [receiverId] String UUID of the receiver.
  /// [callType] Strict Enum defining audio or video call.
  Future<void> initiateCall({
    required String receiverId,
    CallType callType = CallType.audio,
  }) async {
    emit(const CallLoading());

    final params = InitiateCallParams(
      receiverId: receiverId,
      callType: callType,
    );

    final result = await initiateCallUseCase.call(params);

    if (isClosed) return;

    result.fold(
      (appError) => emit(CallFailure(error: appError)),
      (callEntity) => emit(CallInitiatedSuccess(callEntity)),
    );
  }
}
