import 'package:get_it/get_it.dart';

import '../../../features/marketplace/data/datasources/marketplace_remote_data_source.dart';
import '../../../features/marketplace/data/repositories/marketplace_repository_impl.dart';
import '../../../features/marketplace/domain/repositories/marketplace_repository.dart';
import '../../../features/marketplace/domain/usecases/explore_open_jobs_usecase.dart';
import '../../../features/marketplace/domain/usecases/place_bid_usecase.dart';
import '../../../features/marketplace/presentation/cubits/explore_jobs_cubit.dart';
import '../../../features/marketplace/presentation/cubits/place_bid_cubit.dart';

void initMarketplace(GetIt sl) {
  // ---------------------------------------------------------------------------
  // 1. DATA SOURCES
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<MarketplaceRemoteDataSource>(
    () => MarketplaceRemoteDataSourceImpl(sl()),
  );

  // ---------------------------------------------------------------------------
  // 2. REPOSITORIES
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<MarketplaceRepository>(
    () => MarketplaceRepositoryImpl(remoteDataSource: sl()),
  );

  // ---------------------------------------------------------------------------
  // 3. USE CASES
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton(() => ExploreOpenJobsUseCase(sl()));
  sl.registerLazySingleton(() => PlaceBidUseCase(sl()));

  // ---------------------------------------------------------------------------
  // 4. PRESENTATION (CUBITS)
  // ---------------------------------------------------------------------------
  sl.registerFactory(() => ExploreJobsCubit(useCase: sl()));
  sl.registerFactory(() => PlaceBidCubit(useCase: sl()));
}
