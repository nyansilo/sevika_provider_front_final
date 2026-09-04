import 'package:equatable/equatable.dart';

import '../../entities/chat_message_type.dart';

class SendLocationMessageParams extends Equatable {
  final String roomId;
  final double latitude;
  final double longitude;
  final String label;

  const SendLocationMessageParams({
    required this.roomId,
    required this.latitude,
    required this.longitude,
    required this.label,
  });

  Map<String, dynamic> toJson() => {
    'type': ChatMessageType.location.name,
    'metadata': {'latitude': latitude, 'longitude': longitude, 'label': label},
  };

  @override
  List<Object?> get props => [roomId, latitude, longitude, label];
}
