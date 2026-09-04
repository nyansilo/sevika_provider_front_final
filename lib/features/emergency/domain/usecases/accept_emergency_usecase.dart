import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../booking/domain/entities/booking_entity.dart';
import '../repositories/emergency_repository.dart';
import 'params/accept_emergency_params.dart';

class AcceptEmergencyUseCase
    implements UseCase<BookingEntity, AcceptEmergencyParams> {
  final EmergencyRepository repository;
  AcceptEmergencyUseCase(this.repository);

  @override
  Future<Either<AppError, BookingEntity>> call(
    AcceptEmergencyParams params,
  ) async {
    return await repository.acceptEmergency(params);
  }
}
