import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/bookings_repository.dart';
import 'params/booking_pagination_params.dart';
import '../entities/booking_response_entity.dart';

class GetProviderBookingsUseCase
    implements UseCase<BookingResponseEntity, BookingPaginationParams> {
  final BookingRepository repository;
  GetProviderBookingsUseCase(this.repository);

  @override
  Future<Either<AppError, BookingResponseEntity>> call(
    BookingPaginationParams params,
  ) async {
    return await repository.getProviderBookings(params);
  }
}
