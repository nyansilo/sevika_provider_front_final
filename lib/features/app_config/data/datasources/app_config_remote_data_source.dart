import 'dart:io';
import '../../../../core/network/base_remote_data_source.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../models/app_config_model.dart.dart';

abstract class AppConfigRemoteDataSource {
  Future<AppConfigModel> fetchAppConfig(); // ⬅️ Updated signature
}

class AppConfigRemoteDataSourceImpl extends BaseRemoteDataSource
    implements AppConfigRemoteDataSource {
  final DioClient dioClient;

  AppConfigRemoteDataSourceImpl(this.dioClient);

  @override
  Future<AppConfigModel> fetchAppConfig() async {
    // 🎯 Note: Ensure ApiEndpoints.appVersions is updated to your new config route if it changed in Laravel!
    final response = await dioClient.get(ApiEndpoints.appVersions);

    final Map<String, dynamic> responseData =
        response.data['data'] as Map<String, dynamic>;

    // 🎯 Dynamically route Android vs iOS JSON payload based on hardware
    final String platformKey = Platform.isIOS ? 'ios' : 'android';
    final Map<String, dynamic> platformData = responseData[platformKey];

    return AppConfigModel.fromJson(platformData);
  }
}
