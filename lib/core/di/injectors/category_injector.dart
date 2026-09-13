import 'package:get_it/get_it.dart';

import '../../../features/categories/data/datasources/service_category_remote_data_source.dart';
import '../../../features/categories/data/repositories/service_category_repository_impl.dart';
import '../../../features/categories/domain/repositories/service_category_repository.dart';
import '../../../features/categories/domain/usecases/get_service_categories_usecase.dart';
import '../../../features/categories/presentation/cubits/service_category_cubit.dart';

void initCategory(GetIt sl) {
  // Data Sources
  sl.registerLazySingleton<ServiceCategoryRemoteDataSource>(
    () => ServiceCategoryRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<ServiceCategoryRepository>(
    () => ServiceCategoryRepositoryImpl(remoteDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetServiceCategoriesUseCase(sl()));

  // Cubits
  sl.registerFactory(
    () => ServiceCategoryCubit(getServiceCategoriesUseCase: sl()),
  );
}
