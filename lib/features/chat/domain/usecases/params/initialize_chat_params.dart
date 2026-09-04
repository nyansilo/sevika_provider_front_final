import 'package:equatable/equatable.dart';

class InitializeChatParams extends Equatable {
  final String recipientId;
  final String bookingId;

  const InitializeChatParams({
    required this.recipientId,
    required this.bookingId,
  });

  Map<String, dynamic> toJson() => {
    'recipientId': recipientId,
    'bookingId': bookingId,
  };

  @override
  List<Object?> get props => [recipientId, bookingId];
}
