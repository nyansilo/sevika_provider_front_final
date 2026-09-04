import '../../../../../core/constants/api_endpoints.dart';
import '../../../../../core/network/base_remote_data_source.dart';
import '../../../../../core/network/dio_client.dart';
import '../model/location_boundaries_response_model.dart';

abstract class LocationRemoteDataSource {
  Future<LocationBoundariesResponseModel> fetchAdministrativeBoundaries();
}

class LocationRemoteDataSourceImpl extends BaseRemoteDataSource
    implements LocationRemoteDataSource {
  final DioClient dioClient;

  LocationRemoteDataSourceImpl(this.dioClient);

  @override
  Future<LocationBoundariesResponseModel>
  fetchAdministrativeBoundaries() async {
    // 🎯 Uses your newly made public route location
    final response = await dioClient.get(ApiEndpoints.locationsBoundaries);

    final dataMap = response.data as Map<String, dynamic>;
    return LocationBoundariesResponseModel.fromJson(dataMap);
  }
}
