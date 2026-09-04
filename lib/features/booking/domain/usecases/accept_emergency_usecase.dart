import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/bookings_repository.dart';
import '../entities/booking_entity.dart';

class AcceptEmergencyUseCase implements UseCase<BookingEntity, String> {
  final BookingRepository repository;
  AcceptEmergencyUseCase(this.repository);

  @override
  Future<Either<AppError, BookingEntity>> call(String dispatchId) async {
    return await repository.acceptEmergencyDispatch(dispatchId);
  }
}
