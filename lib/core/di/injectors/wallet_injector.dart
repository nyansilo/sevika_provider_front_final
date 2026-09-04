import 'package:get_it/get_it.dart';

import '../../../features/wallet/data/datasources/wallet_remote_data_source.dart';
import '../../../features/wallet/data/repositories/wallet_repository_impl.dart';
import '../../../features/wallet/domain/repositories/wallet_repository.dart';
import '../../../features/wallet/domain/usecases/wallet_usecases.dart'; // Ensure UseCases are exported here or import individually
import '../../../features/wallet/presentation/cubits/wallet_cubit.dart';
import '../../../features/wallet/presentation/cubits/wallet_transactions_cubit.dart';
import '../../../features/wallet/presentation/cubits/withdrawal_cubit.dart';

void initWallet(GetIt sl) {
  // ---------------------------------------------------------------------------
  // 1. DATA SOURCES
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(sl()),
  );

  // ---------------------------------------------------------------------------
  // 2. REPOSITORIES
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(remoteDataSource: sl()),
  );

  // ---------------------------------------------------------------------------
  // 3. USE CASES
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton(() => GetWalletBalanceUseCase(sl()));
  sl.registerLazySingleton(() => GetWalletTransactionsUseCase(sl()));
  sl.registerLazySingleton(() => RequestWithdrawalUseCase(sl()));

  // ---------------------------------------------------------------------------
  // 4. PRESENTATION / CUBITS
  // ---------------------------------------------------------------------------
  sl.registerFactory(() => WalletCubit(sl()));
  sl.registerFactory(() => WalletTransactionsCubit(sl()));
  sl.registerFactory(() => WithdrawalCubit(sl()));
}
