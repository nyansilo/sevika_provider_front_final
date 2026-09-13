// lib/features/kyc/domain/enums/kyc_status.dart
enum KycStatus {
  unsubmitted,
  pending,
  inReview,
  approved,
  rejected,
  unknown;

  static KycStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'unsubmitted':
        return KycStatus.unsubmitted;
      case 'pending':
        return KycStatus.pending;
      case 'in_review':
        return KycStatus.inReview;
      case 'approved':
        return KycStatus.approved;
      case 'rejected':
        return KycStatus.rejected;
      default:
        return KycStatus.unknown;
    }
  }
}
