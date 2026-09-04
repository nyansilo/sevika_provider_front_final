import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/call_entity.dart';
import '../repositories/call_repository.dart';
import 'params/initiate_call_params.dart';

/// 🚀 Initiate Call Use Case
///
/// This class enforces the Single Responsibility Principle (SRP).
/// Its ONLY job is to take the request to start a call, pass it to the repository,
/// and return the secure connection credentials.
///
/// It implements the core `UseCase` interface, ensuring a standardized `call()`
/// method signature across your entire application.
class InitiateCallUseCase implements UseCase<CallEntity, InitiateCallParams> {
  /// The abstract repository contract. Notice it depends on the Interface (`CallRepository`),
  /// NOT the concrete implementation (`CallRepositoryImpl`). This is Dependency Inversion.
  final CallRepository repository;

  /// Injects the required repository contract.
  InitiateCallUseCase(this.repository);

  /// Executes the Use Case.
  ///
  /// Returns an [Either] monad from the `dartz` package.
  /// - [Left]: Contains an [AppError] if the network fails or Laravel returns an error.
  /// - [Right]: Contains the pure [CallEntity] if the token was generated successfully.
  @override
  Future<Either<AppError, CallEntity>> call(InitiateCallParams params) async {
    // 🛡️ Note: If you had offline business rules (e.g., checking if the user has
    // enough wallet balance before allowing the call), that logic would go RIGHT HERE
    // before touching the repository.

    return await repository.initiateCall(params);
  }
}
