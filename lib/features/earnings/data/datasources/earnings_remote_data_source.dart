import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/base_remote_data_source.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/usecases/params/pagination_params.dart';
import '../models/earning_model.dart';
import '../models/earning_response_model.dart';

abstract class EarningsRemoteDataSource {
  Future<EarningsResponseModel> fetchEarnings(PaginationParams params);
  Future<EarningModel> fetchSinglePayout(
    String paymentId,
  ); // 🎯 Single Payout fetch
}

class EarningsRemoteDataSourceImpl extends BaseRemoteDataSource
    implements EarningsRemoteDataSource {
  final DioClient dioClient;
  EarningsRemoteDataSourceImpl(this.dioClient);

  @override
  Future<EarningsResponseModel> fetchEarnings(PaginationParams params) async {
    final response = await dioClient.get(
      '${ApiEndpoints.baseUrl}/provider/earnings',
      queryParameters: params.toQueryParameters(),
    );
    // 🧠 Utilizing global safe array extraction for the root 'ledger' array!
    final rawLedger = extractDataList(response.data, customKey: 'ledger');
    return EarningsResponseModel.fromJson(response.data, rawLedger);
  }

  @override
  Future<EarningModel> fetchSinglePayout(String paymentId) async {
    final response = await dioClient.get(
      '${ApiEndpoints.baseUrl}/provider/earnings/$paymentId',
    );
    // Maps standard Laravel root "data" object wrapper
    return EarningModel.fromJson(response.data['data']);
  }
}
