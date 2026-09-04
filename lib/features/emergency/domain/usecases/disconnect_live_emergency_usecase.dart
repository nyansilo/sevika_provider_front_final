import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/emergency_repository.dart';

class DisconnectLiveEmergencyUseCase implements UseCase<void, NoParams> {
  final EmergencyRepository repository;

  DisconnectLiveEmergencyUseCase(this.repository);

  @override
  Future<Either<AppError, void>> call(NoParams params) async {
    return await repository.disconnectLiveEmergency();
  }
}
