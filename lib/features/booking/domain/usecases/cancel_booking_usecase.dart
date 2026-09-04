import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/booking_entity.dart';
import '../repositories/bookings_repository.dart';
import 'params/cancel_booking_params.dart';

/// 👨‍🔧 CANCEL BOOKING USE CASE (PROVIDER)
///
/// Allows a Provider to safely back out of a pending or accepted job
/// if they have an emergency or schedule conflict.
class CancelBookingUseCase
    implements UseCase<BookingEntity, CancelBookingParams> {
  final BookingRepository repository;

  CancelBookingUseCase(this.repository);

  @override
  Future<Either<AppError, BookingEntity>> call(
    CancelBookingParams params,
  ) async {
    return await repository.cancelBooking(params);
  }
}
