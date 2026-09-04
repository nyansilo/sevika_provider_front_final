enum FaqCategory {
  general,
  payment,
  booking,
  account;

  static FaqCategory fromString(String value) {
    switch (value.toLowerCase()) {
      case 'payment':
      case 'transaction':
      case 'refund':
        return FaqCategory.payment;
      case 'booking':
      case 'service':
      case 'order':
        return FaqCategory.booking;
      case 'account':
      case 'profile':
      case 'security':
        return FaqCategory.account;
      case 'general':
      default:
        return FaqCategory.general;
    }
  }

  /// Human-readable labels for category filter tabs or chips in the UI
  String get displayName {
    switch (this) {
      case FaqCategory.general:
        return 'General';
      case FaqCategory.payment:
        return 'Payments & Refunds';
      case FaqCategory.booking:
        return 'Bookings & Orders';
      case FaqCategory.account:
        return 'Account & Security';
    }
  }
}
