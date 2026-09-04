import 'package:dio/dio.dart'; // 🚀 Added for FormData and MultipartFile integration

// 🎯 Aligned with core file path location structure
import '../../../../core/network/base_remote_data_source.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../domain/usecases/params/update_profile_params.dart';
import '../models/user_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfileModel> fetchUserProfile();
  Future<UserProfileModel> updateUserProfile(UpdateProfileParams params);
}

class ProfileRemoteDataSourceImpl extends BaseRemoteDataSource
    implements ProfileRemoteDataSource {
  final DioClient dioClient;

  ProfileRemoteDataSourceImpl(this.dioClient);

  @override
  Future<UserProfileModel> fetchUserProfile() async {
    final response = await dioClient.get(ApiEndpoints.profile);
    return UserProfileModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<UserProfileModel> updateUserProfile(UpdateProfileParams params) async {
    // 🚀 FORM-DATA SPOOFING PAYLOAD MAP: Prepare fields matching your Laravel array schema requirements
    final Map<String, dynamic> payload = {
      '_method': 'PUT', // Explicit method override indicator flag required for Laravel multi-part requests
      'firstName': params.firstName,
      'lastName': params.lastName,
      'phoneNumber': params.phoneNumber,
      'defaultAddress': params.defaultAddress,
      'city': params.city,
      if (params.alternativePhone != null)
        'alternativePhone': params.alternativePhone,
    };

    // Append file asset package to payload dynamically if an image exists
    if (params.imageFile != null) {
      final String fileName = params.imageFile!.path.split('/').last;

      payload['profileImage'] = await MultipartFile.fromFile(
        params.imageFile!.path,
        filename: fileName,
      );
    }

    // Convert payload to native multi-part form structure safely
    final formData = FormData.fromMap(payload);

    // Execute via POST while specifying PUT headers to satisfy underlying application architecture lines
    final response = await dioClient.post(
      ApiEndpoints.updateProfile, // ⚠️ Ensure this does NOT feature a trailing slash at the end string
      data: formData,
      options: Options(
        contentType: Headers.multipartFormDataContentType,
        headers: {
          'Accept': 'application/json', // Forces Laravel to return elegant validation error arrays instead of web HTML stacktrace screens
          'X-HTTP-Method-Override': 'PUT',
        },
      ),
    );

    return UserProfileModel.fromJson(response.data as Map<String, dynamic>);
  }
}
