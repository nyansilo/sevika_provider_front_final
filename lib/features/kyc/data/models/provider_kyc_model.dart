// lib/features/kyc/data/models/provider_kyc_model.dart
import '../../domain/entities/provider_kyc_entity.dart';
import '../../domain/enums/kyc_status.dart';
import '../../domain/enums/kyc_tier.dart';

class ProviderKycModel extends ProviderKycEntity {
  const ProviderKycModel({
    required super.status,
    super.maskedNidaNumber,
    super.rejectionReason,
    required super.kycTier,
    required super.proUpgradeStatus,
    super.proRejectionReason,
    required super.hasPoliceClearance,
    required super.hasTradeCertificate,
    required super.hasBusinessLicense,
    super.verifiedAt,
    super.submittedAt,
  });

  factory ProviderKycModel.fromJson(Map<String, dynamic> json) {
    return ProviderKycModel(
      status: KycStatus.fromString(json['status'] ?? 'unsubmitted'),
      maskedNidaNumber: json['maskedNidaNumber'],
      rejectionReason: json['rejectionReason'],
      kycTier: KycTier.fromString(json['kycTier'] ?? 'unverified'),
      proUpgradeStatus: KycStatus.fromString(
        json['proUpgradeStatus'] ?? 'unsubmitted',
      ),
      proRejectionReason: json['proRejectionReason'],
      hasPoliceClearance: json['hasPoliceClearance'] ?? false,
      hasTradeCertificate: json['hasTradeCertificate'] ?? false,
      hasBusinessLicense: json['hasBusinessLicense'] ?? false,
      verifiedAt: json['verifiedAt'] != null
          ? DateTime.tryParse(json['verifiedAt'])
          : null,
      submittedAt: json['submittedAt'] != null
          ? DateTime.tryParse(json['submittedAt'])
          : null,
    );
  }

  ProviderKycEntity toEntity() => this;
}
