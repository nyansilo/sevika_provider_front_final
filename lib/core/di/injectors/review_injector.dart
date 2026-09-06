import 'package:get_it/get_it.dart';

// PROVIDER IMPORTS
import '../../../features/review/data/datasources/provider_review_remote_data_source.dart';
import '../../../features/review/data/repositories/provider_review_repository_impl.dart';
import '../../../features/review/domain/repositories/provider_review_repository.dart';
import '../../../features/review/domain/usecases/reviews_usecase.dart'; // Make sure your usecases are exported here
import '../../../features/review/presentation/cubits/provider_reviews_cubit.dart';

void initReview(GetIt sl) {
  // ===========================================================================
  // 1. DATA SOURCES
  // ===========================================================================
  sl.registerLazySingleton<ProviderReviewRemoteDataSource>(
    () => ProviderReviewRemoteDataSourceImpl(sl()),
  );
  // ❌ Removed the duplicate Data Source registration here

  // ===========================================================================
  // 2. REPOSITORIES
  // ===========================================================================
  sl.registerLazySingleton<ProviderReviewRepository>(
    () => ProviderReviewRepositoryImpl(remoteDataSource: sl()),
  );
  // ❌ Removed the duplicate Repository registration here

  // ===========================================================================
  // 3. USE CASES
  // ===========================================================================
  // Provider Use Cases
  sl.registerLazySingleton(() => GetProviderReviewsUseCase(sl()));
  sl.registerLazySingleton(() => ReplyToReviewUseCase(sl()));

  // ===========================================================================
  // 4. CUBITS (Presentation)
  // ===========================================================================
  // Use registerFactory for Cubits so a fresh instance is provided when a new screen is pushed
  sl.registerFactory<ProviderReviewsCubit>(
    () => ProviderReviewsCubit(
      getReviewsUseCase: sl(),
      replyToReviewUseCase: sl(),
    ),
  );
}
