import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../entities/customer_address_entity.dart';
import '../usecases/params/address_payload_params.dart';

abstract class CustomerAddressRepository {
  Future<Either<AppError, List<CustomerAddressEntity>>> getCustomerAddresses();
  Future<Either<AppError, CustomerAddressEntity>> getAddressDetails(
    String addressId,
  );
  Future<Either<AppError, CustomerAddressEntity>> addAddress(
    AddressPayloadParams params,
  );
  Future<Either<AppError, CustomerAddressEntity>> updateAddress({
    required String addressId,
    required AddressPayloadParams params,
  });
  Future<Either<AppError, Unit>> deleteAddress(String addressId);
}
