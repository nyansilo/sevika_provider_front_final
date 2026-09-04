// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../domain/usecases/update_booking_status_usecase.dart';
// import '../../../domain/usecases/confirm_cash_receipt_usecase.dart';
// import '../../../domain/usecases/accept_emergency_usecase.dart';
// import '../../../domain/usecases/params/update_booking_status_params.dart';
// import '../../../domain/usecases/params/confirm_cash_receipt_params.dart';
// import 'manage_job_state.dart';

// class ManageJobCubit extends Cubit<ManageJobState> {
//   final UpdateBookingStatusUseCase updateStatusUseCase;
//   final ConfirmCashReceiptUseCase confirmCashUseCase;
//   final AcceptEmergencyUseCase acceptEmergencyUseCase;

//   ManageJobCubit({
//     required this.updateStatusUseCase,
//     required this.confirmCashUseCase,
//     required this.acceptEmergencyUseCase,
//   }) : super(const ManageJobInitial());

//   Future<void> updateJobStatus(UpdateBookingStatusParams params) async {
//     emit(const ManageJobLoading());
//     final result = await updateStatusUseCase.call(params);
//     if (isClosed) return;
//     result.fold(
//       (error) => emit(ManageJobFailure(error)),
//       (booking) => emit(ManageJobSuccess(booking)),
//     );
//   }

//   Future<void> confirmCashCollection(String reference) async {
//     emit(const ManageJobLoading());
//     final result = await confirmCashUseCase.call(
//       ConfirmCashReceiptParams(bookingReference: reference),
//     );
//     if (isClosed) return;
//     result.fold(
//       (error) => emit(ManageJobFailure(error)),
//       (booking) => emit(ManageJobSuccess(booking)),
//     );
//   }

//   Future<void> acceptEmergency(String dispatchId) async {
//     emit(const ManageJobLoading());
//     final result = await acceptEmergencyUseCase.call(dispatchId);
//     if (isClosed) return;
//     result.fold(
//       (error) => emit(ManageJobFailure(error)),
//       (booking) => emit(ManageJobSuccess(booking)),
//     );
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/update_booking_status_usecase.dart';
import '../../../domain/usecases/confirm_cash_receipt_usecase.dart';
import '../../../domain/usecases/accept_emergency_usecase.dart';
import '../../../domain/usecases/get_booking_details_usecase.dart'; // 🎯 ADDED
import '../../../domain/usecases/params/update_booking_status_params.dart';
import '../../../domain/usecases/params/confirm_cash_receipt_params.dart';
import 'manage_job_state.dart';

class ManageJobCubit extends Cubit<ManageJobState> {
  final UpdateBookingStatusUseCase updateStatusUseCase;
  final ConfirmCashReceiptUseCase confirmCashUseCase;
  final AcceptEmergencyUseCase acceptEmergencyUseCase;
  final GetBookingDetailsUseCase getBookingDetailsUseCase; // 🎯 ADDED

  ManageJobCubit({
    required this.updateStatusUseCase,
    required this.confirmCashUseCase,
    required this.acceptEmergencyUseCase,
    required this.getBookingDetailsUseCase, // 🎯 ADDED
  }) : super(const ManageJobInitial());

  Future<void> updateJobStatus(UpdateBookingStatusParams params) async {
    emit(const ManageJobLoading());
    final result = await updateStatusUseCase.call(params);
    if (isClosed) return;
    result.fold(
      (error) => emit(ManageJobFailure(error)),
      (booking) => emit(ManageJobSuccess(booking)),
    );
  }

  Future<void> confirmCashCollection(String reference) async {
    emit(const ManageJobLoading());
    final result = await confirmCashUseCase.call(
      ConfirmCashReceiptParams(bookingReference: reference),
    );
    if (isClosed) return;
    result.fold(
      (error) => emit(ManageJobFailure(error)),
      (booking) => emit(ManageJobSuccess(booking)),
    );
  }

  Future<void> acceptEmergency(String dispatchId) async {
    emit(const ManageJobLoading());
    final result = await acceptEmergencyUseCase.call(dispatchId);
    if (isClosed) return;
    result.fold(
      (error) => emit(ManageJobFailure(error)),
      (booking) => emit(ManageJobSuccess(booking)),
    );
  }

  // 🎯 ADDED: This is the method that safely triggers the Pull-To-Refresh!
  Future<void> fetchJobDetails(String reference) async {
    emit(const ManageJobLoading());
    final result = await getBookingDetailsUseCase.call(reference);
    if (isClosed) return;
    result.fold(
      (error) => emit(ManageJobFailure(error)),
      // 🎯 FIX: Now it emits our dedicated FetchSuccess state
      (booking) => emit(ManageJobFetchSuccess(booking)),
    );
  }
}
