import 'package:equatable/equatable.dart';

class LiveEmergencyParams extends Equatable {
  final String dispatchId;
  final String token; // The user's auth token for WebSocket authentication

  const LiveEmergencyParams({required this.dispatchId, required this.token});

  @override
  List<Object?> get props => [dispatchId, token];
}
