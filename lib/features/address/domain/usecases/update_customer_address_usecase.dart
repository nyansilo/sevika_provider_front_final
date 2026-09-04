// domain/usecases/update_customer_address_usecase.dart
// import 'package:dartz/dartz.dart';
// import '../../../../core/errors/app_error.dart';
// import '../entities/customer_address_entity.dart';
// import '../repositories/customer_address_repository.dart';
// import 'params/address_payload_params.dart';

// class UpdateCustomerAddressUseCase {
//   final CustomerAddressRepository repository;

//   UpdateCustomerAddressUseCase(this.repository);

//   Future<Either<AppError, CustomerAddressEntity>> call({
//     required String addressId,
//     required AddressPayloadParams params,
//   }) async {
//     return await repository.updateAddress(addressId: addressId, params: params);
//   }
// }

import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../entities/customer_address_entity.dart';
import '../repositories/customer_address_repository.dart';
import 'params/address_payload_params.dart';

class UpdateCustomerAddressParams {
  final String addressId;
  final AddressPayloadParams params;

  const UpdateCustomerAddressParams({
    required this.addressId,
    required this.params,
  });
}

class UpdateCustomerAddressUseCase {
  final CustomerAddressRepository repository;

  UpdateCustomerAddressUseCase(this.repository);

  Future<Either<AppError, CustomerAddressEntity>> call(
    UpdateCustomerAddressParams params,
  ) async {
    return await repository.updateAddress(
      addressId: params.addressId,
      params: params.params,
    );
  }
}
