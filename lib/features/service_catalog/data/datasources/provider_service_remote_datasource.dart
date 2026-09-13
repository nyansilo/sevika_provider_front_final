import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/base_remote_data_source.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/usecases/params/catalog_pagination_params.dart';
import '../../domain/usecases/params/propose_service_params.dart';
import '../../domain/usecases/params/update_offering_params.dart';
import '../models/provider_catalog_response_model.dart';
import '../models/provider_service_model.dart';

abstract class ProviderServiceRemoteDataSource {
  Future<ProviderCatalogResponseModel> fetchCatalog(
    CatalogPaginationParams params,
  );
  Future<ProviderServiceModel> proposeService(ProposeServiceParams params);
  Future<ProviderServiceModel> updateOffering(UpdateOfferingParams params);
  Future<String> deleteOffering(String serviceId);
}

class ProviderServiceRemoteDataSourceImpl extends BaseRemoteDataSource
    implements ProviderServiceRemoteDataSource {
  final DioClient dioClient;

  ProviderServiceRemoteDataSourceImpl(this.dioClient);

  @override
  Future<ProviderCatalogResponseModel> fetchCatalog(
    CatalogPaginationParams params,
  ) async {
    final response = await dioClient.get(
      '${ApiEndpoints.baseUrl}/provider/services',
      queryParameters: params.toQueryParameters(),
    );
    return ProviderCatalogResponseModel.fromJson(response.data);
  }

  @override
  Future<ProviderServiceModel> proposeService(
    ProposeServiceParams params,
  ) async {
    final response = await dioClient.post(
      '${ApiEndpoints.baseUrl}/provider/services/propose',
      data: params.toJson(),
    );
    return ProviderServiceModel.fromJson(response.data['data']);
  }

  @override
  Future<ProviderServiceModel> updateOffering(
    UpdateOfferingParams params,
  ) async {
    final response = await dioClient.put(
      '${ApiEndpoints.baseUrl}/provider/services/update/${params.serviceId}',
      data: params.toJson(),
    );
    return ProviderServiceModel.fromJson(response.data['data']);
  }

  @override
  Future<String> deleteOffering(String serviceId) async {
    final response = await dioClient.delete(
      '${ApiEndpoints.baseUrl}/provider/services/delete/$serviceId',
    );
    return response.data['message'];
  }
}
