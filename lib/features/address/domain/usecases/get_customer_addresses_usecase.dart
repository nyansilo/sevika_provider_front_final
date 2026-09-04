// // domain/usecases/get_customer_addresses_usecase.dart
// import 'package:dartz/dartz.dart';
// import '../../../../core/errors/app_error.dart';
// import '../entities/customer_address_entity.dart';
// import '../repositories/customer_address_repository.dart';

// class GetCustomerAddressesUseCase {
//   final CustomerAddressRepository repository;

//   GetCustomerAddressesUseCase(this.repository);

//   Future<Either<AppError, List<CustomerAddressEntity>>> call() async {
//     return await repository.getCustomerAddresses();
//   }
// }

import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/customer_address_entity.dart';
import '../repositories/customer_address_repository.dart';

class GetCustomerAddressesUseCase
    implements UseCase<List<CustomerAddressEntity>, NoParams> {
  final CustomerAddressRepository repository;

  GetCustomerAddressesUseCase(this.repository);

  @override
  Future<Either<AppError, List<CustomerAddressEntity>>> call(
    NoParams params,
  ) async {
    return await repository.getCustomerAddresses();
  }
}
