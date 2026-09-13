// lib/features/kyc/data/datasources/provider_kyc_remote_datasource.dart
import 'package:dio/dio.dart';

import '../../../../core/network/base_remote_data_source.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/usecases/params/submit_basic_kyc_params.dart';
import '../../domain/usecases/params/upgrade_to_pro_params.dart';
import '../models/provider_kyc_model.dart';

abstract class ProviderKycRemoteDataSource {
  Future<ProviderKycModel> fetchKycStatus();
  Future<ProviderKycModel> submitBasicKyc(SubmitBasicKycParams params);
  Future<ProviderKycModel> upgradeToPro(UpgradeToProParams params);
}

class ProviderKycRemoteDataSourceImpl extends BaseRemoteDataSource
    implements ProviderKycRemoteDataSource {
  final DioClient dioClient;

  ProviderKycRemoteDataSourceImpl(this.dioClient);

  @override
  Future<ProviderKycModel> fetchKycStatus() async {
    final response = await dioClient.get('/provider/kyc/status');
    return ProviderKycModel.fromJson(response.data['data']);
  }

  @override
  Future<ProviderKycModel> submitBasicKyc(SubmitBasicKycParams params) async {
    // Uses formData to match Laravel's backend expectation.
    // Laravel's prepareForValidation() will translate these camelCase keys to snake_case.
    final formData = FormData.fromMap({
      "nidaNumber": params.nidaNumber,
      "idFront": await MultipartFile.fromFile(params.idFrontPath),
      "selfie": await MultipartFile.fromFile(params.selfiePath),
    });

    final response = await dioClient.post(
      '/provider/kyc/submit',
      data: formData,
    );
    return ProviderKycModel.fromJson(response.data['data']);
  }

  @override
  Future<ProviderKycModel> upgradeToPro(UpgradeToProParams params) async {
    final Map<String, dynamic> mapData = {
      "businessLicense": await MultipartFile.fromFile(
        params.businessLicensePath,
      ),
    };

    if (params.tradeCertificatePath != null) {
      mapData["tradeCertificate"] = await MultipartFile.fromFile(
        params.tradeCertificatePath!,
      );
    }
    if (params.policeClearancePath != null) {
      mapData["policeClearance"] = await MultipartFile.fromFile(
        params.policeClearancePath!,
      );
    }

    final formData = FormData.fromMap(mapData);

    final response = await dioClient.post(
      '/provider/kyc/upgrade-to-pro',
      data: formData,
    );
    return ProviderKycModel.fromJson(response.data['data']);
  }
}
