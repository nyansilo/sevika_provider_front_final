import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/base_remote_data_source.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/usecases/params/get_service_categories_params.dart';
import '../models/service_category_response_model.dart';

abstract class ServiceCategoryRemoteDataSource {
  Future<ServiceCategoryResponseModel> fetchServiceCategories(
    GetServiceCategoriesParams params,
  );
}

class ServiceCategoryRemoteDataSourceImpl extends BaseRemoteDataSource
    implements ServiceCategoryRemoteDataSource {
  final DioClient dioClient;

  ServiceCategoryRemoteDataSourceImpl(this.dioClient);

  @override
  Future<ServiceCategoryResponseModel> fetchServiceCategories(
    GetServiceCategoriesParams params,
  ) async {
    final response = await dioClient.get(
      ApiEndpoints.serviceCategories,
      queryParameters: params.toQueryParameters(),
    );

    final dataMap = response.data as Map<String, dynamic>;
    return ServiceCategoryResponseModel.fromJson(dataMap);
  }
}
