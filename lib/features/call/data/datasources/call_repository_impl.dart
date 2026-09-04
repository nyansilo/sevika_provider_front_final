import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_handler.dart';
import '../../domain/entities/call_entity.dart';
import '../../domain/repositories/call_repository.dart';
import '../../domain/usecases/params/initiate_call_params.dart';
import '../datasources/call_remote_data_source.dart';

/// 🌉 Repository Implementation
///
/// Bridges the Data and Domain layers. Intercepts exceptions from Dio
/// and maps them cleanly into `Either` Left (AppError) or Right (Entity).
class CallRepositoryImpl implements CallRepository {
  final CallRemoteDataSource remoteDataSource;

  CallRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppError, CallEntity>> initiateCall(
    InitiateCallParams params,
  ) async {
    try {
      final responseModel = await remoteDataSource.initiateCall(params);
      return Right(responseModel.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }
}
