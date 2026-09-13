import 'package:get_it/get_it.dart';

import '../../../features/service_catalog/data/datasources/provider_service_remote_datasource.dart';
import '../../../features/service_catalog/data/repositories/provider_service_repository_impl.dart';
import '../../../features/service_catalog/domain/repositories/provider_service_repository.dart';
import '../../../features/service_catalog/domain/usecases/delete_service_offering_usecase.dart';
import '../../../features/service_catalog/domain/usecases/get_provider_catalog_usecase.dart';
import '../../../features/service_catalog/domain/usecases/propose_service_usecase.dart';
import '../../../features/service_catalog/domain/usecases/update_service_offering_usecase.dart';
import '../../../features/service_catalog/presentation/cubits/provider_service_cubit.dart';

void initServiceCatalog(GetIt sl) {
  // ===========================================================================
  // 1. DATA SOURCES (API Connections)
  // ===========================================================================
  sl.registerLazySingleton<ProviderServiceRemoteDataSource>(
    () => ProviderServiceRemoteDataSourceImpl(sl()),
  );

  // ===========================================================================
  // 2. REPOSITORIES (Domain/Data bridge)
  // ===========================================================================
  sl.registerLazySingleton<ProviderServiceRepository>(
    () => ProviderServiceRepositoryImpl(remoteDataSource: sl()),
  );

  // ===========================================================================
  // 3. USE CASES (Business Logic)
  // ===========================================================================
  sl.registerLazySingleton(() => GetProviderCatalogUseCase(sl()));
  sl.registerLazySingleton(() => ProposeServiceUseCase(sl()));
  sl.registerLazySingleton(() => UpdateServiceOfferingUseCase(sl()));
  sl.registerLazySingleton(() => DeleteServiceOfferingUseCase(sl()));

  // ===========================================================================
  // 4. PRESENTATION (Cubits)
  // ===========================================================================
  // We use registerFactory for Cubits so that the UI can spin up a fresh instance when needed
  sl.registerFactory(
    () => ProviderServiceCubit(
      getCatalogUseCase: sl(),
      proposeServiceUseCase: sl(),
      updateOfferingUseCase: sl(),
      deleteOfferingUseCase: sl(),
    ),
  );
}
