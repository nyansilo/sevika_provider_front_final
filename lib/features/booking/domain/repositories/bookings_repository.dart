// import 'package:dartz/dartz.dart';

// import '../../../../core/errors/app_error.dart';
// import '../entities/booking_entity.dart';
// import '../entities/booking_response_entity.dart';
// import '../usecases/params/booking_pagination_params.dart';
// import '../usecases/params/cancel_booking_params.dart'; // 🎯 ADDED: Cancel params import
// import '../usecases/params/confirm_cash_receipt_params.dart';
// import '../usecases/params/download_invoice_params.dart';
// import '../usecases/params/update_booking_status_params.dart';

// abstract class BookingRepository {
//   Future<Either<AppError, BookingResponseEntity>> getProviderBookings(
//     BookingPaginationParams params,
//   );

//   Future<Either<AppError, BookingEntity>> updateBookingStatus(
//     UpdateBookingStatusParams params,
//   );

//   Future<Either<AppError, BookingEntity>> confirmCashReceipt(
//     ConfirmCashReceiptParams params,
//   );

//   Future<Either<AppError, BookingEntity>> acceptEmergencyDispatch(
//     String dispatchId,
//   );

//   // 👨‍🔧 ADDED: The missing contract method for cancelling a job
//   Future<Either<AppError, BookingEntity>> cancelBooking(
//     CancelBookingParams params,
//   );

//   Future<Either<AppError, String>> downloadInvoice(
//     DownloadInvoiceParams params,
//   );
// }

import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../entities/booking_entity.dart';
import '../entities/booking_response_entity.dart';
import '../usecases/params/booking_pagination_params.dart';
import '../usecases/params/cancel_booking_params.dart'; // 🎯 ADDED: Cancel params import
import '../usecases/params/confirm_cash_receipt_params.dart';
import '../usecases/params/download_invoice_params.dart';
import '../usecases/params/update_booking_status_params.dart';

abstract class BookingRepository {
  Future<Either<AppError, BookingResponseEntity>> getProviderBookings(
    BookingPaginationParams params,
  );

  // 🎯 ADDED: The contract method for getting single job details
  Future<Either<AppError, BookingEntity>> getJobDetails(String reference);

  Future<Either<AppError, BookingEntity>> updateBookingStatus(
    UpdateBookingStatusParams params,
  );

  Future<Either<AppError, BookingEntity>> confirmCashReceipt(
    ConfirmCashReceiptParams params,
  );

  Future<Either<AppError, BookingEntity>> acceptEmergencyDispatch(
    String dispatchId,
  );

  // 👨‍🔧 ADDED: The missing contract method for cancelling a job
  Future<Either<AppError, BookingEntity>> cancelBooking(
    CancelBookingParams params,
  );

  Future<Either<AppError, String>> downloadInvoice(
    DownloadInvoiceParams params,
  );
}
