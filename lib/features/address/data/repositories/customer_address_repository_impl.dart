// data/repositories/customer_address_repository_impl.dart
// import 'package:dartz/dartz.dart';
// import '../../../../core/errors/app_error.dart';
// import '../../../../core/errors/error_handler.dart';
// import '../../domain/entities/customer_address_entity.dart';
// import '../../domain/repositories/customer_address_repository.dart';
// import '../../domain/usecases/params/address_payload_params.dart';
// import '../datasources/customer_address_remote_data_source.dart';

// class CustomerAddressRepositoryImpl implements CustomerAddressRepository {
//   final CustomerAddressRemoteDataSource remoteDataSource;

//   CustomerAddressRepositoryImpl({required this.remoteDataSource});

//   @override
//   Future<Either<AppError, List<CustomerAddressEntity>>>
//   getCustomerAddresses() async {
//     try {
//       final responseModel = await remoteDataSource.fetchAddresses();
//       return Right(responseModel.toEntityList());
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, CustomerAddressEntity>> getAddressDetails(
//     String addressId,
//   ) async {
//     try {
//       final model = await remoteDataSource.fetchAddressDetails(addressId);
//       return Right(model.toEntity());
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, CustomerAddressEntity>> addAddress(
//     AddressPayloadParams params,
//   ) async {
//     try {
//       final model = await remoteDataSource.addAddress(params);
//       return Right(model.toEntity());
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, CustomerAddressEntity>> updateAddress({
//     required String addressId,
//     required AddressPayloadParams params,
//   }) async {
//     try {
//       final model = await remoteDataSource.updateAddress(addressId, params);
//       return Right(model.toEntity());
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }

//   @override
//   Future<Either<AppError, Unit>> deleteAddress(String addressId) async {
//     try {
//       await remoteDataSource.deleteAddress(addressId);
//       return const Right(unit);
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }
// }

import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_handler.dart';
import '../../domain/entities/customer_address_entity.dart';
import '../../domain/repositories/customer_address_repository.dart';
import '../../domain/usecases/params/address_payload_params.dart';
import '../datasources/customer_address_remote_data_source.dart';

class CustomerAddressRepositoryImpl implements CustomerAddressRepository {
  final CustomerAddressRemoteDataSource remoteDataSource;

  CustomerAddressRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppError, List<CustomerAddressEntity>>>
  getCustomerAddresses() async {
    try {
      final responseModel = await remoteDataSource.fetchAddresses();
      final entities = responseModel.addresses
          .map((model) => model.toEntity())
          .toList();
      return Right(entities);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, CustomerAddressEntity>> getAddressDetails(
    String addressId,
  ) async {
    try {
      final model = await remoteDataSource.fetchAddressDetails(addressId);
      return Right(model.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, CustomerAddressEntity>> addAddress(
    AddressPayloadParams params,
  ) async {
    try {
      final model = await remoteDataSource.addAddress(params);
      return Right(model.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, CustomerAddressEntity>> updateAddress({
    required String addressId,
    required AddressPayloadParams params,
  }) async {
    try {
      final model = await remoteDataSource.updateAddress(addressId, params);
      return Right(model.toEntity());
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, Unit>> deleteAddress(String addressId) async {
    try {
      await remoteDataSource.deleteAddress(addressId);
      return const Right(unit);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }
}
