import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/bookings_repository.dart';
import 'params/update_booking_status_params.dart';
import '../entities/booking_entity.dart';

class UpdateBookingStatusUseCase
    implements UseCase<BookingEntity, UpdateBookingStatusParams> {
  final BookingRepository repository;
  UpdateBookingStatusUseCase(this.repository);

  @override
  Future<Either<AppError, BookingEntity>> call(
    UpdateBookingStatusParams params,
  ) async {
    return await repository.updateBookingStatus(params);
  }
}
