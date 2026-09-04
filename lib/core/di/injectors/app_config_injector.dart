import 'package:get_it/get_it.dart';

import '../../../features/app_config/data/datasources/app_config_remote_data_source.dart';
import '../../../features/app_config/data/repositories/app_config_repository_impl.dart';
import '../../../features/app_config/data/repositories/local_app_info_repository_impl.dart';
import '../../../features/app_config/domain/repositories/app_config_repository.dart';
import '../../../features/app_config/domain/repositories/local_app_info_repository.dart';
import '../../../features/app_config/domain/usecases/check_app_version_use_case.dart';
import '../../../features/app_config/presentation/cubit/app_config_cubit.dart';

void initAppConfig(GetIt sl) {
  // Data Sources
  sl.registerLazySingleton<AppConfigRemoteDataSource>(
    () => AppConfigRemoteDataSourceImpl(sl()), // Injects DioClient
  );

  // Repositories
  sl.registerLazySingleton<LocalAppInfoRepository>(
    () => LocalAppInfoRepositoryImpl(),
  );

  sl.registerLazySingleton<AppConfigRepository>(
    () => AppConfigRepositoryImpl(remoteDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton<CheckAppVersionUseCase>(
    () => CheckAppVersionUseCase(remoteRepository: sl(), localRepository: sl()),
  );

  // Cubits (Factory because we usually want a fresh instance when a screen loads)
  sl.registerFactory<AppConfigCubit>(
    () => AppConfigCubit(checkAppVersionUseCase: sl()),
  );
}
