import 'package:get_it/get_it.dart';

import '../../../features/earnings/data/datasources/earnings_remote_data_source.dart';
import '../../../features/earnings/data/repositories/earnings_repository_impl.dart';
import '../../../features/earnings/domain/repositories/earnings_repository.dart';
import '../../../features/earnings/domain/usecases/earnings_usecases.dart'; // Ensure UseCases are exported here or import individually
import '../../../features/earnings/presentation/cubits/earnings_cubit.dart';
import '../../../features/earnings/presentation/cubits/single_payout_cubit.dart';

void initEarnings(GetIt sl) {
  // ---------------------------------------------------------------------------
  // 1. DATA SOURCES
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<EarningsRemoteDataSource>(
    () => EarningsRemoteDataSourceImpl(sl()),
  );

  // ---------------------------------------------------------------------------
  // 2. REPOSITORIES
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<EarningsRepository>(
    () => EarningsRepositoryImpl(remoteDataSource: sl()),
  );

  // ---------------------------------------------------------------------------
  // 3. USE CASES
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton(() => GetEarningsUseCase(sl()));
  sl.registerLazySingleton(() => GetSinglePayoutUseCase(sl()));

  // ---------------------------------------------------------------------------
  // 4. PRESENTATION / CUBITS
  // ---------------------------------------------------------------------------
  sl.registerFactory(() => EarningsCubit(sl()));
  sl.registerFactory(() => SinglePayoutCubit(sl()));
}
