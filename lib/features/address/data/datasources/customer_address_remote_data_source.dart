import '../../../../core/network/dio_client.dart';
import '../models/customer_address_response_model.dart';
import '../models/customer_address_model.dart';
import '../../domain/usecases/params/address_payload_params.dart';

abstract class CustomerAddressRemoteDataSource {
  Future<CustomerAddressResponseModel> fetchAddresses();
  Future<CustomerAddressModel> fetchAddressDetails(String addressId);
  Future<CustomerAddressModel> addAddress(AddressPayloadParams params);
  Future<CustomerAddressModel> updateAddress(
    String addressId,
    AddressPayloadParams params,
  );
  Future<void> deleteAddress(String addressId);
}

class CustomerAddressRemoteDataSourceImpl
    implements CustomerAddressRemoteDataSource {
  final DioClient dioClient;

  CustomerAddressRemoteDataSourceImpl(this.dioClient);

  @override
  Future<CustomerAddressResponseModel> fetchAddresses() async {
    final response = await dioClient.get('/customer/addresses');
    final dataMap = response.data as Map<String, dynamic>;
    return CustomerAddressResponseModel.fromJson(dataMap);
  }

  @override
  Future<CustomerAddressModel> fetchAddressDetails(String addressId) async {
    final response = await dioClient.get('/customer/addresses/$addressId');
    final dataMap = response.data as Map<String, dynamic>;
    final targetData = (dataMap['data'] is Map<String, dynamic>)
        ? dataMap['data'] as Map<String, dynamic>
        : dataMap;
    return CustomerAddressModel.fromJson(targetData);
  }

  @override
  Future<CustomerAddressModel> addAddress(AddressPayloadParams params) async {
    final response = await dioClient.post(
      '/customer/addresses',
      data: params.toJson(),
    );
    final dataMap = response.data as Map<String, dynamic>;
    final targetData = (dataMap['data'] is Map<String, dynamic>)
        ? dataMap['data'] as Map<String, dynamic>
        : dataMap;
    return CustomerAddressModel.fromJson(targetData);
  }

  @override
  Future<CustomerAddressModel> updateAddress(
    String addressId,
    AddressPayloadParams params,
  ) async {
    final response = await dioClient.put(
      '/customer/addresses/$addressId',
      data: params.toJson(),
    );
    final dataMap = response.data as Map<String, dynamic>;
    final targetData = (dataMap['data'] is Map<String, dynamic>)
        ? dataMap['data'] as Map<String, dynamic>
        : dataMap;
    return CustomerAddressModel.fromJson(targetData);
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    await dioClient.delete('/customer/addresses/$addressId');
  }
}
