import 'package:get_it/get_it.dart';

// 📦 Data Sources
import '../../../features/call/data/datasources/call_remote_data_source.dart';

// 🤝 Repositories
import '../../../features/call/data/datasources/call_repository_impl.dart';
import '../../../features/call/domain/repositories/call_repository.dart';

// 🚀 Use Cases
import '../../../features/call/domain/usecases/initiate_call_use_case.dart';

// 🧠 Presentation / Cubits
import '../../../features/call/presentation/cubit/call_cubit.dart';

/// 📞 Initializes all dependencies for the Call Feature.
///
/// Registers the Remote Data Source, Repository, Use Cases, and the Cubit
/// into the GetIt service locator.
void initCall(GetIt sl) {
  // ---------------------------------------------------------------------------
  // 1. DATA SOURCES
  // ---------------------------------------------------------------------------
  // Injects the global DioClient into the CallRemoteDataSource
  sl.registerLazySingleton<CallRemoteDataSource>(
    () => CallRemoteDataSourceImpl(sl()),
  );

  // ---------------------------------------------------------------------------
  // 2. REPOSITORIES
  // ---------------------------------------------------------------------------
  // Injects the Remote Data Source into the Repository Implementation.
  // Note: We bind the concrete implementation to the abstract interface contract.
  sl.registerLazySingleton<CallRepository>(
    () => CallRepositoryImpl(remoteDataSource: sl()),
  );

  // ---------------------------------------------------------------------------
  // 3. USE CASES
  // ---------------------------------------------------------------------------
  // Injects the Repository into the Use Cases
  sl.registerLazySingleton(() => InitiateCallUseCase(sl()));

  // ---------------------------------------------------------------------------
  // 4. PRESENTATION (CUBITS)
  // ---------------------------------------------------------------------------
  // ⚠️ Always register Cubits as Factories.
  // This ensures a fresh instance is created every time a new screen requires it,
  // preventing stale state bugs when navigating between different calls.
  sl.registerFactory(() => CallCubit(initiateCallUseCase: sl()));
}
