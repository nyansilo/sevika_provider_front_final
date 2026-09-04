import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/base_remote_data_source.dart';
import '../../domain/usecases/params/initiate_call_params.dart';
import '../models/call_model.dart';

abstract class CallRemoteDataSource {
  Future<CallModel> initiateCall(InitiateCallParams params);
}

class CallRemoteDataSourceImpl extends BaseRemoteDataSource
    implements CallRemoteDataSource {
  final DioClient dioClient;

  CallRemoteDataSourceImpl(this.dioClient);

  @override
  Future<CallModel> initiateCall(InitiateCallParams params) async {
    final response = await dioClient.post(
      ApiEndpoints.initiateCall,
      data: params.toJson(),
    );

    final data = (response.data['data'] as Map<String, dynamic>?) ?? {};
    return CallModel.fromJson(data);
  }
}
