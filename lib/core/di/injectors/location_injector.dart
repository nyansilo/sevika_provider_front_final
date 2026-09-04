import 'package:get_it/get_it.dart';

import '../../../features/shared/location/data/datasources/location_remote_data_source.dart';
import '../../../features/shared/location/data/repositories/location_repository_impl.dart';
import '../../../features/shared/location/domain/repositories/location_repository.dart';
import '../../../features/shared/location/domain/usecases/fetch_administrative_boundaries_usecase.dart';
import '../../../features/shared/location/presentation/cubits/location/location_cubit.dart';

void initLocation(GetIt sl) {
  // ---------------------------------------------------------------------------
  // PRESENTATION LAYER (CUBITS / BLOCS)
  // ---------------------------------------------------------------------------
  sl.registerFactory<LocationCubit>(
    () => LocationCubit(fetchAdministrativeBoundariesUseCase: sl()),
  );

  // ---------------------------------------------------------------------------
  // DOMAIN LAYER (USECASES)
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<FetchAdministrativeBoundariesUseCase>(
    () => FetchAdministrativeBoundariesUseCase(sl()),
  );

  // ---------------------------------------------------------------------------
  // DATA LAYER (REPOSITORIES & DATASOURCES)
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<LocationRemoteDataSource>(
    () => LocationRemoteDataSourceImpl(sl()), // Injecting core DioClient
  );
}
