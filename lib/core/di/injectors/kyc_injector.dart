import 'package:get_it/get_it.dart';

import '../../../features/kyc/data/datasources/provider_kyc_remote_datasource.dart';
import '../../../features/kyc/data/repositories/provider_kyc_repository_impl.dart';
import '../../../features/kyc/domain/repositories/provider_kyc_repository.dart';
import '../../../features/kyc/domain/usecases/get_kyc_status_usecase.dart';
import '../../../features/kyc/domain/usecases/submit_basic_kyc_usecase.dart';
import '../../../features/kyc/domain/usecases/upgrade_to_pro_usecase.dart';
import '../../../features/kyc/presentation/cubits/provider_kyc_cubit.dart';

/// 🛡️ KYC Dependency Injection Setup
void initKyc(GetIt sl) {
  // ===========================================================================
  // 1. PRESENTATION LAYER (Cubits/Blocs)
  // Registered as Factory so a fresh instance is created every time the
  // Provider opens the KYC Dashboard. (State is preserved automatically
  // via route arguments to sub-screens).
  // ===========================================================================
  sl.registerFactory<ProviderKycCubit>(
    () => ProviderKycCubit(
      getKycStatusUseCase: sl(),
      submitBasicKycUseCase: sl(),
      upgradeToProUseCase: sl(),
    ),
  );

  // ===========================================================================
  // 2. DOMAIN LAYER (Use Cases)
  // ===========================================================================
  sl.registerLazySingleton<GetKycStatusUseCase>(
    () => GetKycStatusUseCase(sl()),
  );

  sl.registerLazySingleton<SubmitBasicKycUseCase>(
    () => SubmitBasicKycUseCase(sl()),
  );

  sl.registerLazySingleton<UpgradeToProUseCase>(
    () => UpgradeToProUseCase(sl()),
  );

  // ===========================================================================
  // 3. DATA LAYER (Repositories)
  // ===========================================================================
  sl.registerLazySingleton<ProviderKycRepository>(
    () => ProviderKycRepositoryImpl(remoteDataSource: sl()),
  );

  // ===========================================================================
  // 4. NETWORK LAYER (Remote Data Sources)
  // ===========================================================================
  sl.registerLazySingleton<ProviderKycRemoteDataSource>(
    () => ProviderKycRemoteDataSourceImpl(sl()),
  );
}
