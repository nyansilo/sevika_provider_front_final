// import 'package:dartz/dartz.dart';

// import '../../../../core/errors/app_error.dart';
// import '../../../../core/errors/error_handler.dart';
// import '../../domain/entities/booking_entity.dart';
// import '../../domain/entities/booking_response_entity.dart';
// import '../../domain/repositories/bookings_repository.dart';
// import '../../domain/usecases/params/update_booking_status_params.dart';
// import '../../domain/usecases/params/confirm_cash_receipt_params.dart';
// import '../../domain/usecases/params/booking_pagination_params.dart';
// import '../../domain/usecases/params/download_invoice_params.dart';
// import '../../domain/usecases/params/cancel_booking_params.dart'; // 🎯 ADDED
// import '../datasources/booking_remote_data_source.dart';

// class BookingRepositoryImpl implements BookingRepository {
//   final BookingRemoteDataSource remoteDataSource;

//   BookingRepositoryImpl({required this.remoteDataSource});

//   @override
//   Future<Either<AppError, BookingResponseEntity>> getProviderBookings(
//     BookingPaginationParams params,
//   ) async {
//     try {
//       final responseModel = await remoteDataSource.fetchProviderBookings(
//         params,
//       );
//       return Right(responseModel);
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, BookingEntity>> updateBookingStatus(
//     UpdateBookingStatusParams params,
//   ) async {
//     try {
//       final model = await remoteDataSource.updateBookingStatus(params);
//       return Right(model.toEntity());
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, BookingEntity>> confirmCashReceipt(
//     ConfirmCashReceiptParams params,
//   ) async {
//     try {
//       final model = await remoteDataSource.confirmCashReceipt(params);
//       return Right(model.toEntity());
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, BookingEntity>> acceptEmergencyDispatch(
//     String dispatchId,
//   ) async {
//     try {
//       final model = await remoteDataSource.acceptEmergencyDispatch(dispatchId);
//       return Right(model.toEntity());
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   // 👨‍🔧 ADDED: Concrete implementation for cancelling a booking
//   @override
//   Future<Either<AppError, BookingEntity>> cancelBooking(
//     CancelBookingParams params,
//   ) async {
//     try {
//       final model = await remoteDataSource.cancelBooking(params);
//       return Right(model.toEntity());
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, String>> downloadInvoice(
//     DownloadInvoiceParams params,
//   ) async {
//     try {
//       final localFilePath = await remoteDataSource.downloadInvoice(params);
//       return Right(localFilePath);
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }
// }

import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_handler.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/booking_response_entity.dart';
import '../../domain/repositories/bookings_repository.dart';
import '../../domain/usecases/params/update_booking_status_params.dart';
import '../../domain/usecases/params/confirm_cash_receipt_params.dart';
import '../../domain/usecases/params/booking_pagination_params.dart';
import '../../domain/usecases/params/download_invoice_params.dart';
import '../../domain/usecases/params/cancel_booking_params.dart'; // 🎯 ADDED
import '../datasources/booking_remote_data_source.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppError, BookingResponseEntity>> getProviderBookings(
    BookingPaginationParams params,
  ) async {
    try {
      final responseModel = await remoteDataSource.fetchProviderBookings(
        params,
      );
      return Right(responseModel);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  // 🎯 ADDED: Implementation for fetching a single job's details
  @override
  Future<Either<AppError, BookingEntity>> getJobDetails(
    String reference,
  ) async {
    try {
      final model = await remoteDataSource.fetchJobDetails(reference);
      return Right(model.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, BookingEntity>> updateBookingStatus(
    UpdateBookingStatusParams params,
  ) async {
    try {
      final model = await remoteDataSource.updateBookingStatus(params);
      return Right(model.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, BookingEntity>> confirmCashReceipt(
    ConfirmCashReceiptParams params,
  ) async {
    try {
      final model = await remoteDataSource.confirmCashReceipt(params);
      return Right(model.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, BookingEntity>> acceptEmergencyDispatch(
    String dispatchId,
  ) async {
    try {
      final model = await remoteDataSource.acceptEmergencyDispatch(dispatchId);
      return Right(model.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  // 👨‍🔧 ADDED: Concrete implementation for cancelling a booking
  @override
  Future<Either<AppError, BookingEntity>> cancelBooking(
    CancelBookingParams params,
  ) async {
    try {
      final model = await remoteDataSource.cancelBooking(params);
      return Right(model.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, String>> downloadInvoice(
    DownloadInvoiceParams params,
  ) async {
    try {
      final localFilePath = await remoteDataSource.downloadInvoice(params);
      return Right(localFilePath);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }
}
