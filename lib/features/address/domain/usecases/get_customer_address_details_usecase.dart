// // domain/usecases/get_address_details_usecase.dart
// import 'package:dartz/dartz.dart';
// import '../../../../core/errors/app_error.dart';
// import '../entities/customer_address_entity.dart';
// import '../repositories/customer_address_repository.dart';

// class GetACustomerAddressDetailsUseCase {
//   final CustomerAddressRepository repository;

//   GetACustomerAddressDetailsUseCase(this.repository);

//   Future<Either<AppError, CustomerAddressEntity>> call(String addressId) async {
//     return await repository.getAddressDetails(addressId);
//   }
// }

import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/customer_address_entity.dart';
import '../repositories/customer_address_repository.dart';

class GetACustomerAddressDetailsUseCase
    implements UseCase<CustomerAddressEntity, String> {
  final CustomerAddressRepository repository;

  GetACustomerAddressDetailsUseCase(this.repository);

  @override
  Future<Either<AppError, CustomerAddressEntity>> call(String addressId) async {
    return await repository.getAddressDetails(addressId);
  }
}
