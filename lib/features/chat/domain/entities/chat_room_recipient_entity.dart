import 'package:equatable/equatable.dart';

class ChatRoomRecipientEntity extends Equatable {
  final String id;
  final String role;
  final String fullName;
  final String avatarUrl;
  final String? businessName;
  final String? phoneNumber;

  const ChatRoomRecipientEntity({
    required this.id,
    required this.role,
    required this.fullName,
    required this.avatarUrl,
    this.businessName,
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [
    id,
    role,
    fullName,
    avatarUrl,
    businessName,
    phoneNumber,
  ];
}
