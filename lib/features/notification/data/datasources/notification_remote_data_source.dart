import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/base_remote_data_source.dart';
import '../../domain/usecases/params/toggle_notification_params.dart';
import '../../domain/usecases/params/update_fcm_token_params.dart';
import '../models/notification_response_model.dart';
import '../../domain/usecases/params/get_notifications_params.dart';

abstract class NotificationRemoteDataSource {
  Future<NotificationResponseModel> fetchNotifications(
    GetNotificationsParams params,
  );
  Future<void> markAsRead(String id);
  Future<void> markAllAsRead();
  Future<void> deleteNotification(String id);
  Future<void> clearAllNotifications();

  Future<void> updateFcmToken(UpdateFcmTokenParams params);

  Future<void> toggleNotificationPreference(ToggleNotificationParams params);
}

class NotificationRemoteDataSourceImpl extends BaseRemoteDataSource
    implements NotificationRemoteDataSource {
  final DioClient dioClient;

  NotificationRemoteDataSourceImpl(this.dioClient);

  @override
  Future<NotificationResponseModel> fetchNotifications(
    GetNotificationsParams params,
  ) async {
    final response = await dioClient.get(
      //'/customer/notifications',
      ApiEndpoints.providerNotifications,
      queryParameters: params.toQueryParameters(),
    );
    return NotificationResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<void> markAsRead(String id) async {
    await dioClient.patch('${ApiEndpoints.providerNotifications}/$id/read');
  }

  @override
  Future<void> markAllAsRead() async {
    await dioClient.patch(
      '${ApiEndpoints.providerNotifications}/read',
      //'/customer/notifications/read',
    );
  }

  @override
  Future<void> deleteNotification(String id) async {
    await dioClient.delete(
      '${ApiEndpoints.providerNotifications}/$id',
      //'/customer/notifications/$id'
    );
  }

  @override
  Future<void> clearAllNotifications() async {
    await dioClient.delete(
      //'/customer/notifications',
      ApiEndpoints.providerNotifications,
    );
  }

  @override
  Future<void> updateFcmToken(UpdateFcmTokenParams params) async {
    await dioClient.post(
      ApiEndpoints.updateFcmToken, // e.g., '/customer/fcm-token'
      data: params
          .toJson(), // 🎯 The JSON map comes directly from the params object!
    );
  }

  @override
  Future<void> toggleNotificationPreference(
    ToggleNotificationParams params,
  ) async {
    await dioClient.patch(
      '${ApiEndpoints.providerNotifications}/preferences',
      data: params.toJson(),
    );
  }
}
