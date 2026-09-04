import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/base_remote_data_source.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/usecases/params/get_chat_rooms_params.dart';
import '../../domain/usecases/params/initialize_chat_params.dart';
import '../../domain/usecases/params/get_message_stream_params.dart';
import '../../domain/usecases/params/send_text_message_params.dart';
import '../../domain/usecases/params/send_location_message_params.dart';
import '../models/chat_room_model.dart';
import '../models/chat_message_model.dart';

abstract class ChatRemoteDataSource {
  Future<Map<String, dynamic>> getRooms(GetChatRoomsParams params);
  Future<ChatRoomModel> initializeRoom(InitializeChatParams params);
  Future<Map<String, dynamic>> getMessageStream(GetMessageStreamParams params);
  Future<ChatMessageModel> sendTextMessage(SendTextMessageParams params);
  Future<ChatMessageModel> sendLocationMessage(
    SendLocationMessageParams params,
  );
  Future<void> syncReadState(String roomId);
}

class ChatRemoteDataSourceImpl extends BaseRemoteDataSource
    implements ChatRemoteDataSource {
  final DioClient dioClient;

  ChatRemoteDataSourceImpl(this.dioClient);

  @override
  Future<Map<String, dynamic>> getRooms(GetChatRoomsParams params) async {
    final response = await dioClient.get(
      ApiEndpoints.chatRooms,
      queryParameters: params.toQueryParameters(),
    );
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<ChatRoomModel> initializeRoom(InitializeChatParams params) async {
    final response = await dioClient.post(
      '${ApiEndpoints.chatRooms}/initialize',
      data: params.toJson(),
    );
    final responseMap = response.data as Map<String, dynamic>;
    return ChatRoomModel.fromJson(responseMap['data'] as Map<String, dynamic>);
  }

  @override
  Future<Map<String, dynamic>> getMessageStream(
    GetMessageStreamParams params,
  ) async {
    final response = await dioClient.get(
      '${ApiEndpoints.chatRooms}/${params.roomId}',
      queryParameters: params.toQueryParameters(),
    );
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<ChatMessageModel> sendTextMessage(SendTextMessageParams params) async {
    final response = await dioClient.post(
      '${ApiEndpoints.chatRooms}/${params.roomId}/messages',
      data: params.toJson(),
    );
    final responseMap = response.data as Map<String, dynamic>;
    return ChatMessageModel.fromJson(
      responseMap['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<ChatMessageModel> sendLocationMessage(
    SendLocationMessageParams params,
  ) async {
    final response = await dioClient.post(
      '${ApiEndpoints.chatRooms}/${params.roomId}/messages',
      data: params.toJson(),
    );
    final responseMap = response.data as Map<String, dynamic>;
    return ChatMessageModel.fromJson(
      responseMap['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<void> syncReadState(String roomId) async {
    await dioClient.patch('${ApiEndpoints.chatRooms}/$roomId/read');
  }
}
