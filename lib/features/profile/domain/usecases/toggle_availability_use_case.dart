import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/profile_repository.dart';

/// 🚀 USE CASE: Isolates the business logic for going online/offline.
class ToggleAvailabilityUseCase
    implements UseCase<bool, ToggleAvailabilityParams> {
  final ProfileRepository repository;

  ToggleAvailabilityUseCase(this.repository);

  @override
  Future<Either<AppError, bool>> call(ToggleAvailabilityParams params) async {
    return await repository.toggleAvailability(isOnline: params.isOnline);
  }
}

class ToggleAvailabilityParams extends Equatable {
  final bool isOnline;

  const ToggleAvailabilityParams({required this.isOnline});

  @override
  List<Object?> get props => [isOnline];
}
