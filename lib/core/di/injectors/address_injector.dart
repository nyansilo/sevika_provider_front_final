import 'package:get_it/get_it.dart';
import '../../../features/address/data/datasources/customer_address_remote_data_source.dart';
import '../../../features/address/data/repositories/customer_address_repository_impl.dart';
import '../../../features/address/domain/repositories/customer_address_repository.dart';
import '../../../features/address/domain/usecases/get_customer_addresses_usecase.dart';
import '../../../features/address/domain/usecases/add_customer_address_usecase.dart';
import '../../../features/address/domain/usecases/update_customer_address_usecase.dart';
import '../../../features/address/domain/usecases/delete_customer_address_usecase.dart';
import '../../../features/address/presentation/cubits/customer_address/customer_address_cubit.dart';

void initAddress(GetIt sl) {
  // Data Source
  sl.registerLazySingleton<CustomerAddressRemoteDataSource>(
    () => CustomerAddressRemoteDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<CustomerAddressRepository>(
    () => CustomerAddressRepositoryImpl(remoteDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetCustomerAddressesUseCase(sl()));
  sl.registerLazySingleton(() => AddCustomerAddressUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCustomerAddressUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCustomerAddressUseCase(sl()));

  // Cubit
  sl.registerFactory(
    () => CustomerAddressCubit(
      getAddressesUseCase: sl(),
      addAddressUseCase: sl(),
      updateAddressUseCase: sl(),
      deleteAddressUseCase: sl(),
    ),
  );
}
