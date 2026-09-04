import '../../domain/entities/chat_room_recipient_entity.dart';

class ChatRoomRecipientModel extends ChatRoomRecipientEntity {
  const ChatRoomRecipientModel({
    required super.id,
    required super.role,
    required super.fullName,
    required super.avatarUrl,
    super.businessName,
    super.phoneNumber,
  });

  factory ChatRoomRecipientModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomRecipientModel(
      id: json['id']?.toString() ?? '',
      role: json['role']?.toString() ?? 'user',
      fullName:
          json['fullName']?.toString() ?? json['full_name']?.toString() ?? '',
      avatarUrl:
          json['avatarUrl']?.toString() ?? json['avatar_url']?.toString() ?? '',
      businessName:
          json['businessName']?.toString() ?? json['business_name']?.toString(),
      phoneNumber:
          json['phoneNumber']?.toString() ?? json['phone_number']?.toString(),
    );
  }
}
