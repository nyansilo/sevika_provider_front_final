import '../../domain/entities/emergency_claim_entity.dart';

class EmergencyClaimModel extends EmergencyClaimEntity {
  const EmergencyClaimModel({
    required super.dispatchId,
    required super.status,
    required super.message,
  });

  EmergencyClaimEntity toEntity() => this;

  factory EmergencyClaimModel.fromJson(Map<String, dynamic> json) {
    return EmergencyClaimModel(
      dispatchId: json['dispatchId']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      message:
          json['message']?.toString() ??
          'This emergency was claimed by another provider.',
    );
  }
}
