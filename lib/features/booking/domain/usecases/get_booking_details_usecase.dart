import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/booking_entity.dart';
import '../repositories/bookings_repository.dart';

class GetBookingDetailsUseCase implements UseCase<BookingEntity, String> {
  final BookingRepository repository;

  GetBookingDetailsUseCase(this.repository);

  @override
  Future<Either<AppError, BookingEntity>> call(String params) async {
    // params represents the bookingReference (e.g. SOS-M63FZZ)
    return await repository.getJobDetails(params);
  }
}
