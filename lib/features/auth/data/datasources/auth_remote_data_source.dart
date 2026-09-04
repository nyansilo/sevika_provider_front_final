// import '../../../../core/network/base_remote_data_source.dart';
// import '../../../../core/network/dio_client.dart';
// import '../../../../core/constants/api_endpoints.dart';
// import '../../domain/usecases/params/change_password_params.dart';
// import '../../domain/usecases/params/complete_social_registration_params.dart';
// import '../../domain/usecases/params/login_params.dart';
// import '../../domain/usecases/params/refresh_token_params.dart';
// import '../../domain/usecases/params/register_params.dart';
// import '../../domain/usecases/params/forgot_password_params.dart';
// import '../../domain/usecases/params/reset_password_params.dart';
// import '../../domain/usecases/params/update_phone_params.dart';
// import '../models/auth_response_model.dart';
// import '../models/social_auth_response_model.dart';
// import '../models/social_login_request_model.dart';

// abstract class AuthRemoteDataSource {
//   Future<AuthResponseModel> login(LoginParams params);
//   Future<AuthResponseModel> register(RegisterParams params);
//   Future<AuthResponseModel> refreshAuthToken(RefreshTokenParams params);
//   Future<void> logout();
//   Future<void> changePassword(ChangePasswordParams params);
//   Future<void> forgotPassword(ForgotPasswordParams params);
//   Future<void> resetPassword(ResetPasswordParams params);

//   // 🚀 Social Flow
//   Future<SocialAuthResponseModel> socialLogin(SocialLoginRequestModel params);
//   Future<SocialAuthResponseModel> completeSocialRegistration(
//     CompleteSocialRegistrationParams params,
//   );

//   Future<AuthResponseModel> updatePhoneNumber(UpdatePhoneParams params);
// }

// class AuthRemoteDataSourceImpl extends BaseRemoteDataSource
//     implements AuthRemoteDataSource {
//   final DioClient dioClient;
//   AuthRemoteDataSourceImpl(this.dioClient);

//   @override
//   Future<AuthResponseModel> login(LoginParams params) async {
//     final response = await dioClient.post(
//       ApiEndpoints.login,
//       data: params.toMap(),
//     );
//     return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
//   }

//   @override
//   Future<AuthResponseModel> register(RegisterParams params) async {
//     final response = await dioClient.post(
//       ApiEndpoints.register,
//       data: params.toMap(),
//     );
//     return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
//   }

//   @override
//   Future<AuthResponseModel> refreshAuthToken(RefreshTokenParams params) async {
//     final response = await dioClient.post(
//       ApiEndpoints.refreshToken,
//       data: params.toMap(),
//     );
//     return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
//   }

//   @override
//   Future<void> logout() async {
//     await dioClient.post(ApiEndpoints.logout);
//   }

//   @override
//   Future<void> changePassword(ChangePasswordParams params) async {
//     await dioClient.post(ApiEndpoints.changePassword, data: params.toMap());
//   }

//   @override
//   Future<void> forgotPassword(ForgotPasswordParams params) async {
//     await dioClient.post(ApiEndpoints.forgotPassword, data: params.toMap());
//   }

//   @override
//   Future<void> resetPassword(ResetPasswordParams params) async {
//     await dioClient.post(ApiEndpoints.resetPassword, data: params.toMap());
//   }

//   @override
//   Future<SocialAuthResponseModel> socialLogin(
//     SocialLoginRequestModel params,
//   ) async {
//     final response = await dioClient.post(
//       ApiEndpoints.socialLogin,
//       data: params.toMap(),
//     );
//     return SocialAuthResponseModel.fromJson(
//       response.data as Map<String, dynamic>,
//     );
//   }

//   @override
//   Future<SocialAuthResponseModel> completeSocialRegistration(
//     CompleteSocialRegistrationParams params,
//   ) async {
//     // 🚀 CLEAN: No try/catch needed! ErrorHandler intercepts the 422 gracefully.
//     final response = await dioClient.post(
//       ApiEndpoints.completeSocialRegistration,
//       data: params.toMap(),
//     );
//     return SocialAuthResponseModel.fromJson(
//       response.data as Map<String, dynamic>,
//     );
//   }

//   @override
//   Future<AuthResponseModel> updatePhoneNumber(UpdatePhoneParams params) async {
//     final response = await dioClient.post(
//       ApiEndpoints.updatePhoneNumber,
//       data: params.toMap(),
//     );
//     return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
//   }
// }

import '../../../../core/network/base_remote_data_source.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../domain/usecases/params/change_password_params.dart';
import '../../domain/usecases/params/complete_social_registration_params.dart';
import '../../domain/usecases/params/login_params.dart';
import '../../domain/usecases/params/refresh_token_params.dart';
import '../../domain/usecases/params/register_params.dart';
import '../../domain/usecases/params/forgot_password_params.dart';
import '../../domain/usecases/params/reset_password_params.dart';
import '../../domain/usecases/params/update_phone_params.dart';
import '../models/auth_response_model.dart';
import '../models/social_auth_response_model.dart';
import '../models/social_login_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login(LoginParams params);
  Future<AuthResponseModel> register(RegisterParams params);
  Future<AuthResponseModel> refreshAuthToken(RefreshTokenParams params);
  Future<void> logout();
  Future<void> changePassword(ChangePasswordParams params);
  Future<void> forgotPassword(ForgotPasswordParams params);
  Future<void> resetPassword(ResetPasswordParams params);

  // 🚀 Social Flow
  Future<SocialAuthResponseModel> socialLogin(SocialLoginRequestModel params);
  Future<SocialAuthResponseModel> completeSocialRegistration(
    CompleteSocialRegistrationParams params,
  );

  Future<AuthResponseModel> updatePhoneNumber(UpdatePhoneParams params);

  // 🎯 NEW: Permanent Account Deletion
  Future<void> deleteAccount();
}

class AuthRemoteDataSourceImpl extends BaseRemoteDataSource
    implements AuthRemoteDataSource {
  final DioClient dioClient;
  AuthRemoteDataSourceImpl(this.dioClient);

  @override
  Future<AuthResponseModel> login(LoginParams params) async {
    final response = await dioClient.post(
      ApiEndpoints.login,
      data: params.toMap(),
    );
    return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<AuthResponseModel> register(RegisterParams params) async {
    final response = await dioClient.post(
      ApiEndpoints.register,
      data: params.toMap(),
    );
    return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<AuthResponseModel> refreshAuthToken(RefreshTokenParams params) async {
    final response = await dioClient.post(
      ApiEndpoints.refreshToken,
      data: params.toMap(),
    );
    return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> logout() async {
    await dioClient.post(ApiEndpoints.logout);
  }

  @override
  Future<void> changePassword(ChangePasswordParams params) async {
    await dioClient.post(ApiEndpoints.changePassword, data: params.toMap());
  }

  @override
  Future<void> forgotPassword(ForgotPasswordParams params) async {
    await dioClient.post(ApiEndpoints.forgotPassword, data: params.toMap());
  }

  @override
  Future<void> resetPassword(ResetPasswordParams params) async {
    await dioClient.post(ApiEndpoints.resetPassword, data: params.toMap());
  }

  @override
  Future<SocialAuthResponseModel> socialLogin(
    SocialLoginRequestModel params,
  ) async {
    final response = await dioClient.post(
      ApiEndpoints.socialLogin,
      data: params.toMap(),
    );
    return SocialAuthResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<SocialAuthResponseModel> completeSocialRegistration(
    CompleteSocialRegistrationParams params,
  ) async {
    // 🚀 CLEAN: No try/catch needed! ErrorHandler intercepts the 422 gracefully.
    final response = await dioClient.post(
      ApiEndpoints.completeSocialRegistration,
      data: params.toMap(),
    );
    return SocialAuthResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<AuthResponseModel> updatePhoneNumber(UpdatePhoneParams params) async {
    final response = await dioClient.post(
      ApiEndpoints.updatePhoneNumber,
      data: params.toMap(),
    );
    return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  // 🎯 NEW: Invokes the secure backend deletion endpoint
  @override
  Future<void> deleteAccount() async {
    await dioClient.delete(ApiEndpoints.deleteAccount);
  }
}
