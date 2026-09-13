// lib/features/kyc/domain/enums/kyc_tier.dart
enum KycTier {
  unverified,
  basic,
  professional,
  unknown;

  static KycTier fromString(String tier) {
    switch (tier.toLowerCase()) {
      case 'unverified':
        return KycTier.unverified;
      case 'basic':
        return KycTier.basic;
      case 'professional':
        return KycTier.professional;
      default:
        return KycTier.unknown;
    }
  }
}
