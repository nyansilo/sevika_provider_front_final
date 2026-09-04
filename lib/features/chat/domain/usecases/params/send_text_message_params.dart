import 'package:equatable/equatable.dart';

import '../../entities/chat_message_type.dart';

class SendTextMessageParams extends Equatable {
  final String roomId;
  final String text;

  const SendTextMessageParams({required this.roomId, required this.text});

  Map<String, dynamic> toJson() => {
    'type': ChatMessageType.text.name,
    'body': text,
  };

  @override
  List<Object?> get props => [roomId, text];
}
