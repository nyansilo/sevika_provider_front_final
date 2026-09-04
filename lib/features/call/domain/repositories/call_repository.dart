import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../entities/call_entity.dart';
import '../usecases/params/initiate_call_params.dart';

/// 🤝 Call Repository Contract
///
/// Abstract interface declaring business capabilities for calling.
abstract class CallRepository {
  /// Request secure call credentials from the backend
  Future<Either<AppError, CallEntity>> initiateCall(InitiateCallParams params);
}
