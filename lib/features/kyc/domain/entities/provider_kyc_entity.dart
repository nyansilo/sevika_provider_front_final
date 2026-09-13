// lib/features/kyc/domain/entities/provider_kyc_entity.dart
import 'package:equatable/equatable.dart';

import '../enums/kyc_status.dart';
import '../enums/kyc_tier.dart';

class ProviderKycEntity extends Equatable {
  final KycStatus status;
  final String? maskedNidaNumber;
  final String? rejectionReason;
  final KycTier kycTier;
  final KycStatus proUpgradeStatus;
  final String? proRejectionReason;
  final bool hasPoliceClearance;
  final bool hasTradeCertificate;
  final bool hasBusinessLicense;
  final DateTime? verifiedAt;
  final DateTime? submittedAt;

  const ProviderKycEntity({
    required this.status,
    this.maskedNidaNumber,
    this.rejectionReason,
    required this.kycTier,
    required this.proUpgradeStatus,
    this.proRejectionReason,
    required this.hasPoliceClearance,
    required this.hasTradeCertificate,
    required this.hasBusinessLicense,
    this.verifiedAt,
    this.submittedAt,
  });

  @override
  List<Object?> get props => [
    status,
    maskedNidaNumber,
    kycTier,
    proUpgradeStatus,
    hasPoliceClearance,
    hasTradeCertificate,
    hasBusinessLicense,
  ];
}
