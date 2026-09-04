import 'package:get_it/get_it.dart';

import '../../../features/emergency/data/datasources/emergency_remote_data_source.dart';
import '../../../features/emergency/data/datasources/emergency_websocket_source.dart';
import '../../../features/emergency/data/repositories/emergency_repository_impl.dart';
import '../../../features/emergency/domain/repositories/emergency_repository.dart';
import '../../../features/emergency/domain/usecases/accept_emergency_usecase.dart';
import '../../../features/emergency/domain/usecases/listen_live_emergency_usecase.dart';
import '../../../features/emergency/domain/usecases/disconnect_live_emergency_usecase.dart';
import '../../../features/emergency/presentation/cubits/accept_emergency_cubit.dart';

void initEmergency(GetIt sl) {
  // Data Sources
  sl.registerLazySingleton<EmergencyRemoteDataSource>(
    () => EmergencyRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<EmergencyWebSocketSource>(
    () => EmergencyWebSocketSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<EmergencyRepository>(
    () =>
        EmergencyRepositoryImpl(remoteDataSource: sl(), webSocketSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => AcceptEmergencyUseCase(sl()));
  sl.registerLazySingleton(() => ListenLiveEmergencyUseCase(sl()));
  sl.registerLazySingleton(() => DisconnectLiveEmergencyUseCase(sl()));

  // Cubits
  sl.registerFactory(() => AcceptEmergencyCubit(useCase: sl()));
}
