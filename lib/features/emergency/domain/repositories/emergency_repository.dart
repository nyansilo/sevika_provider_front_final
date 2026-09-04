import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../booking/domain/entities/booking_entity.dart';
import '../entities/emergency_claim_entity.dart';
import '../usecases/params/accept_emergency_params.dart';
import '../usecases/params/live_emergency_params.dart';

abstract class EmergencyRepository {
  Future<Either<AppError, BookingEntity>> acceptEmergency(
    AcceptEmergencyParams params,
  );

  // 🔌 WebSocket Contracts
  Stream<EmergencyClaimEntity> listenToLiveEmergency(
    LiveEmergencyParams params,
  );
  Future<Either<AppError, void>> disconnectLiveEmergency();
}
