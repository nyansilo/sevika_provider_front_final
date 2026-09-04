import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_handler.dart';
import '../../domain/repositories/app_config_repository.dart';
import '../../domain/entities/app_config_entity.dart'; // ⬅️ Updated import
import '../datasources/app_config_remote_data_source.dart';

class AppConfigRepositoryImpl implements AppConfigRepository {
  final AppConfigRemoteDataSource remoteDataSource;

  AppConfigRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppError, AppConfigEntity>> getAppConfig() async {
    try {
      final model = await remoteDataSource.fetchAppConfig();
      return Right(model.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }
}
