// domain/usecases/delete_customer_address_usecase.dart
// import 'package:dartz/dartz.dart';
// import '../../../../core/errors/app_error.dart';
// import '../repositories/customer_address_repository.dart';

// class DeleteCustomerAddressUseCase {
//   final CustomerAddressRepository repository;

//   DeleteCustomerAddressUseCase(this.repository);

//   Future<Either<AppError, Unit>> call(String addressId) async {
//     return await repository.deleteAddress(addressId);
//   }
// }

import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/customer_address_repository.dart';

class DeleteCustomerAddressUseCase implements UseCase<Unit, String> {
  final CustomerAddressRepository repository;

  DeleteCustomerAddressUseCase(this.repository);

  @override
  Future<Either<AppError, Unit>> call(String addressId) async {
    return await repository.deleteAddress(addressId);
  }
}
