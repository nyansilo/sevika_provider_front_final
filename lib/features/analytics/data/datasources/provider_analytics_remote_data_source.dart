// lib/features/analytics/data/datasources/provider_analytics_remote_data_source.dart
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/base_remote_data_source.dart';
import '../../domain/usecases/params/get_provider_analytics_params.dart';
import '../models/provider_analytics_model.dart';

abstract class ProviderAnalyticsRemoteDataSource {
  Future<ProviderAnalyticsModel> fetchAnalytics(
    GetProviderAnalyticsParams params,
  );
}

class ProviderAnalyticsRemoteDataSourceImpl extends BaseRemoteDataSource
    implements ProviderAnalyticsRemoteDataSource {
  final DioClient dioClient;

  ProviderAnalyticsRemoteDataSourceImpl(this.dioClient);

  @override
  Future<ProviderAnalyticsModel> fetchAnalytics(
    GetProviderAnalyticsParams params,
  ) async {
    final response = await dioClient.get(
      '/provider/analytics',
      queryParameters: params.toQueryParameters(),
    );

    final responseData = response.data as Map<String, dynamic>;

    // Safely un-nest if wrapped in Laravel's standard data wrapper
    final Map<String, dynamic> innerData =
        responseData['data'] is Map<String, dynamic>
        ? responseData['data']
        : responseData;

    return ProviderAnalyticsModel.fromJson(innerData);
  }
}
