enum ServiceStatus {
  pending,
  approved,
  rejected,
  unknown;

  static ServiceStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return ServiceStatus.pending;
      case 'approved':
        return ServiceStatus.approved;
      case 'rejected':
        return ServiceStatus.rejected;
      default:
        return ServiceStatus.unknown;
    }
  }

  String toJson() => name;
}
