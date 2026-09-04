// domain/usecases/add_customer_address_usecase.dart
// import 'package:dartz/dartz.dart';
// import '../../../../core/errors/app_error.dart';
// import '../entities/customer_address_entity.dart';
// import '../repositories/customer_address_repository.dart';
// import 'params/address_payload_params.dart';

// class AddCustomerAddressUseCase {
//   final CustomerAddressRepository repository;

//   AddCustomerAddressUseCase(this.repository);

//   Future<Either<AppError, CustomerAddressEntity>> call(
//     AddressPayloadParams params,
//   ) async {
//     return await repository.addAddress(params);
//   }
// }

import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/customer_address_entity.dart';
import '../repositories/customer_address_repository.dart';
import 'params/address_payload_params.dart';

class AddCustomerAddressUseCase
    implements UseCase<CustomerAddressEntity, AddressPayloadParams> {
  final CustomerAddressRepository repository;

  AddCustomerAddressUseCase(this.repository);

  @override
  Future<Either<AppError, CustomerAddressEntity>> call(
    AddressPayloadParams params,
  ) async {
    return await repository.addAddress(params);
  }
}
