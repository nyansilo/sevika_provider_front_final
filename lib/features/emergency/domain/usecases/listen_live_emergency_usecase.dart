import '../entities/emergency_claim_entity.dart';
import '../repositories/emergency_repository.dart';
import 'params/live_emergency_params.dart';

class ListenLiveEmergencyUseCase {
  final EmergencyRepository repository;

  ListenLiveEmergencyUseCase(this.repository);

  Stream<EmergencyClaimEntity> call(LiveEmergencyParams params) {
    return repository.listenToLiveEmergency(params);
  }
}
