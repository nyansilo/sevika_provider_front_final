import 'package:get_it/get_it.dart';

import '../../../features/profile/data/datasources/profile_remote_data_source.dart.dart';
import '../../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../../features/profile/domain/repositories/profile_repository.dart';
import '../../../features/profile/domain/usecases/get_profile_use_case.dart';
import '../../../features/profile/domain/usecases/update_profile_use_case.dart';
import '../../../features/profile/presentation/cubits/profile/profile_cubit.dart';

void initProfile(GetIt sl) {
  // 🎯 Domain Layer (Use Cases)
  sl.registerLazySingleton<GetProfileUseCase>(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(sl()),
  );

  // 📂 Data Layer (Repositories)
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: sl()),
  );

  // 📡 Data Layer (Data Sources)
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl()), // Automatically injects DioClient
  );

  // 🎨 Presentation Layer (Cubits)
  sl.registerFactory<ProfileCubit>(
    () => ProfileCubit(getProfileUseCase: sl(), updateProfileUseCase: sl()),
  );
}
