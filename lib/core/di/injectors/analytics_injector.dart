import 'package:get_it/get_it.dart';

import '../../../features/analytics/data/datasources/provider_analytics_remote_data_source.dart';
import '../../../features/analytics/data/repositories/provider_analytics_repository_impl.dart';
import '../../../features/analytics/domain/repositories/provider_analytics_repository.dart';
import '../../../features/analytics/domain/usecases/get_provider_analytics_usecase.dart';
import '../../../features/analytics/presentation/cubits/analytics_cubit.dart';

void initAnalytics(GetIt sl) {
  // ===========================================================================
  // 1. DATA SOURCES
  // ===========================================================================
  sl.registerLazySingleton<ProviderAnalyticsRemoteDataSource>(
    () => ProviderAnalyticsRemoteDataSourceImpl(sl()),
  );

  // ===========================================================================
  // 2. REPOSITORIES
  // ===========================================================================
  sl.registerLazySingleton<ProviderAnalyticsRepository>(
    () => ProviderAnalyticsRepositoryImpl(remoteDataSource: sl()),
  );

  // ===========================================================================
  // 3. USE CASES
  // ===========================================================================
  sl.registerLazySingleton<GetProviderAnalyticsUseCase>(
    () => GetProviderAnalyticsUseCase(sl()),
  );

  // ===========================================================================
  // 4. CUBITS (Presentation)
  // Registered as a Factory so a fresh state is created every time the screen opens
  // ===========================================================================
  sl.registerFactory<AnalyticsCubit>(
    () => AnalyticsCubit(getAnalyticsUseCase: sl()),
  );
}
