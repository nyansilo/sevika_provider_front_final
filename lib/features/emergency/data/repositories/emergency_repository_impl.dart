import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../booking/domain/entities/booking_entity.dart';
import '../../domain/entities/emergency_claim_entity.dart';
import '../../domain/repositories/emergency_repository.dart';
import '../../domain/usecases/params/accept_emergency_params.dart';
import '../../domain/usecases/params/live_emergency_params.dart';
import '../datasources/emergency_remote_data_source.dart';
import '../datasources/emergency_websocket_source.dart';

class EmergencyRepositoryImpl implements EmergencyRepository {
  final EmergencyRemoteDataSource remoteDataSource;
  final EmergencyWebSocketSource webSocketSource; // 🔌 Added WS Source

  EmergencyRepositoryImpl({
    required this.remoteDataSource,
    required this.webSocketSource,
  });

  @override
  Future<Either<AppError, BookingEntity>> acceptEmergency(
    AcceptEmergencyParams params,
  ) async {
    try {
      final model = await remoteDataSource.acceptEmergency(params);
      return Right(model.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Stream<EmergencyClaimEntity> listenToLiveEmergency(
    LiveEmergencyParams params,
  ) {
    // Maps the Stream of Models to a Stream of Entities
    return webSocketSource
        .listenToEmergencyDispatch(params)
        .map((model) => model.toEntity());
  }

  @override
  Future<Either<AppError, void>> disconnectLiveEmergency() async {
    try {
      webSocketSource.disconnect();
      return const Right(null);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }
}
