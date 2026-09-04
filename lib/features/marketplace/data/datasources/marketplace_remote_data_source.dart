import '../../../../core/network/base_remote_data_source.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../domain/usecases/params/marketplace_pagination_params.dart';
import '../../domain/usecases/params/place_bid_params.dart';
import '../models/open_job_request_model.dart';

abstract class MarketplaceRemoteDataSource {
  Future<List<OpenJobRequestModel>> exploreOpenJobs(
    MarketplacePaginationParams params,
  );
  Future<void> placeBid(PlaceBidParams params);
}

class MarketplaceRemoteDataSourceImpl extends BaseRemoteDataSource
    implements MarketplaceRemoteDataSource {
  final DioClient dioClient;
  MarketplaceRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<OpenJobRequestModel>> exploreOpenJobs(
    MarketplacePaginationParams params,
  ) async {
    final response = await dioClient.get(
      ApiEndpoints.providerOpenJobs, // Assume '/provider/jobs'
      queryParameters: params.toQueryParameters(),
    );

    // 🎯 GLOBAL PARSER: Safely extract 'jobs' array from the nested 'data' container
    final Map<String, dynamic> dataContainer = response.data['data'] ?? {};
    final List<Map<String, dynamic>> extractedList = extractDataList(
      dataContainer,
      customKey: 'jobs',
    );

    return extractedList.map((e) => OpenJobRequestModel.fromJson(e)).toList();
  }

  @override
  Future<void> placeBid(PlaceBidParams params) async {
    await dioClient.post(
      ApiEndpoints.providerPlaceBid,
      data: params.toJson(),
    ); // Assume '/provider/jobs/bids'
  }
}
