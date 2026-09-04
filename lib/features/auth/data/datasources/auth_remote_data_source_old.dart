// import 'package:dio/dio.dart';
// import 'package:sevika/core/constants/api_endpoints.dart';
// import '../../../../core/network/dio_client.dart';
// import '../../domain/usecases/params/change_password_params.dart';
// import '../../domain/usecases/params/login_params.dart';
// import '../../domain/usecases/params/refresh_token_params.dart';
// import '../../domain/usecases/params/register_params.dart';
// import '../../domain/usecases/params/update_profile_params.dart';
// import '../models/auth_response_model.dart';
// import '../models/user_model.dart';

// abstract class AuthRemoteDataSourceOld {
//   Future<AuthResponseModel> login(LoginParams params);
//   Future<AuthResponseModel> register(RegisterParams params);
//   Future<UserModel> fetchUserProfile();
//   Future<UserModel> updateUserProfile(UpdateProfileParams params);
//   Future<AuthResponseModel> refreshAuthToken(RefreshTokenParams params);
//   Future<void> logout();
//   Future<void> changePassword(ChangePasswordParams params);
// }

// class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
//   final DioClient dioClient;

//   AuthRemoteDataSourceImpl(this.dioClient);

//   @override
//   Future<AuthResponseModel> login(LoginParams params) async {
//     final response = await dioClient.post(
//       ApiEndpoints.login,
//       data: params.toMap(),
//     );
//     final dataMap = response.data as Map<String, dynamic>;
//     return AuthResponseModel.fromJson(dataMap);
//   }

//   @override
//   Future<AuthResponseModel> register(RegisterParams params) async {
//     final response = await dioClient.post(
//       ApiEndpoints.register,
//       data: params.toMap(),
//     );
//     final dataMap = response.data as Map<String, dynamic>;
//     return AuthResponseModel.fromJson(dataMap);
//   }

//   @override
//   Future<UserModel> fetchUserProfile() async {
//     final response = await dioClient.get(ApiEndpoints.me);
//     final responseMap = response.data as Map<String, dynamic>;
//     return UserModel.fromJson(_extractUserData(responseMap));
//   }

//   @override
//   Future<UserModel> updateUserProfile(UpdateProfileParams params) async {
//     // 🚀 THE FIX: Use standard string payloads for form-data spoofing mapping
//     final Map<String, dynamic> payload = {
//       '_method': 'PUT', // Explicit method override indicator flag
//       'firstName': params.firstName,
//       'lastName': params.lastName,
//       'phoneNumber': params.phoneNumber,
//     };

//     if (params.imageFile != null) {
//       final String fileName = params.imageFile!.path.split('/').last;

//       payload['profileImage'] = await MultipartFile.fromFile(
//         params.imageFile!.path,
//         filename: fileName,
//       );
//     }

//     // Generate the MultiPart form payload context package safely
//     final formData = FormData.fromMap(payload);

//     final response = await dioClient.post(
//       ApiEndpoints
//           .profile, // ⚠️ Ensure this does NOT have a trailing slash at the end
//       data: formData,
//       options: Options(
//         contentType: Headers.multipartFormDataContentType,
//         headers: {
//           'Accept':
//               'application/json', // Forces Laravel to return JSON validation errors instead of HTML redirects
//           'X-HTTP-Method-Override': 'PUT',
//         },
//       ),
//     );

//     final responseMap = response.data as Map<String, dynamic>;
//     return UserModel.fromJson(_extractUserData(responseMap));
//   }

//   @override
//   Future<AuthResponseModel> refreshAuthToken(RefreshTokenParams params) async {
//     final response = await dioClient.post(
//       ApiEndpoints.refreshToken,
//       data: params.toMap(),
//       options: Options(extra: {'isRetry': true}),
//     );

//     final dataMap = response.data as Map<String, dynamic>;
//     return AuthResponseModel.fromJson(dataMap);
//   }

//   @override
//   Future<void> logout() async {
//     await dioClient.post(ApiEndpoints.logout);
//   }

//   /// Change Password
//   @override
//   Future<void> changePassword(ChangePasswordParams params) async {
//     await dioClient.post(ApiEndpoints.changePassword, data: params.toMap());
//   }

//   /// 🧠 Reusable helper to safely drill into the data envelope consistently
//   Map<String, dynamic> _extractUserData(Map<String, dynamic> responseMap) {
//     // Scenario A: Enveloped inside standard framework API packet {"success": true, "data": {...}}
//     if (responseMap['data'] is Map<String, dynamic>) {
//       final data = responseMap['data'] as Map<String, dynamic>;

//       if (data['user'] is Map<String, dynamic>) {
//         return data['user'] as Map<String, dynamic>;
//       }
//       return data;
//     }

//     // Scenario B: Flat fallback block featuring a straight parent user identifier context
//     if (responseMap['user'] is Map<String, dynamic>) {
//       return responseMap['user'] as Map<String, dynamic>;
//     }

//     return responseMap;
//   }
// }
