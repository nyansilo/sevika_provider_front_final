import 'package:equatable/equatable.dart';

class EmergencyClaimEntity extends Equatable {
  final String dispatchId;
  final String status;
  final String message;

  const EmergencyClaimEntity({
    required this.dispatchId,
    required this.status,
    required this.message,
  });

  @override
  List<Object?> get props => [dispatchId, status, message];
}
