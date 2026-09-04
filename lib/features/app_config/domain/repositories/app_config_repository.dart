import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../entities/app_config_entity.dart';

abstract class AppConfigRepository {
  Future<Either<AppError, AppConfigEntity>> getAppConfig();
}
