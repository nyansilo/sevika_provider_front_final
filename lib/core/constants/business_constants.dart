/// Centralized Business Rules and Operations Engine for the Home Services & Wallet Platform.
///
/// Contains strict constraints, threshold limits, tax ratios, and administrative
/// fallback parameters. All calculations across the payment and checkout flows
/// must bind directly to these metrics.
class BusinessConstants {
  const BusinessConstants._(); // Prevents instantiation

  /// ==========================================
  /// 1. DIGITAL WALLET TRANSACTION BOUNDARIES (TZS)
  /// ==========================================

  /// The minimum allowed amount for a single mobile money mobile checkout (STK Push).
  static const double minTopUpAmount = 1000.0;

  /// The absolute maximum wallet capacity allowed for standard unverified accounts.
  static const double maxUnverifiedWalletBalance = 1000000.0;

  /// The absolute maximum wallet capacity allowed for fully verified (NIDA-checked) accounts.
  static const double maxVerifiedWalletBalance = 5000000.0;

  /// The lowest amount a service provider or user can withdraw out of their wallet.
  static const double minWithdrawalAmount = 2000.0;

  /// Fixed systemic processing fee charged per manual bank or mobile outbound transfer.
  static const double withdrawalTransferFee = 500.0;

  /// ==========================================
  /// 2. REVENUE, FEES & TAXATION ENGINE
  /// ==========================================

  /// Base platform commission percentage deducted from a Service Provider's gross job earnings.
  /// 0.15 represents a flat 15% commission rate.
  static const double platformCommissionRate = 0.15;

  /// Fixed administrative booking processing fee appended to the client's final bill.
  static const double platformBookingFee = 1500.0;

  /// Standard statutory Value Added Tax rate (Tanzania TRA standard is 18%).
  static const double statutoryVatRate = 0.18;

  /// ==========================================
  /// 3. OPERATIONAL DISPATCH & BOOKING BOUNDARIES
  /// ==========================================

  /// The default search radius threshold (in kilometers) for dispatching nearby providers.
  static const double maxProviderDispatchRadiusKm = 15.0;

  /// Minimum time window required between the current time and a scheduled booking.
  static const Duration minBookingLeadTime = Duration(hours: 2);

  /// Grace period during which a client can cancel an active booking without penalty.
  static const Duration freeCancellationWindow = Duration(minutes: 30);

  /// The standard penalty percentage applied if a cancellation occurs past the grace window.
  static const double lateCancellationPenaltyRate = 0.10;

  /// Absolute maximum number of active, incomplete bookings a client can hold concurrently.
  static const int maxConcurrentActiveBookings = 3;

  /// ==========================================
  /// 4. PROVIDER RATING & QUALITY ASSURANCE
  /// ==========================================

  /// Minimum average star rating a provider must maintain to avoid automatic system suspension.
  static const double minAcceptableProviderRating = 3.5;

  /// Number of completed jobs required by a new provider before performance rules apply.
  static const int gracePeriodJobCount = 5;

  /// ==========================================
  /// 5. ADMINISTRATIVE ESCALATION & SUPPORT FALLBACKS
  /// ==========================================
  static const String supportEmail = 'support@homeservices.co.tz';
  static const String supportPhone =
      '+255222160511'; // Head office landline routing
  static const String supportWhatsApp =
      'https://wa.me/255700000000'; // Direct click-to-chat link

  /// Fallback localization anchor point if user device GPS coordinates fail to resolve.
  /// Anchored near the Dar es Salaam city center.
  static const double fallbackLatitude = -6.8161;
  static const double fallbackLongitude = 39.2804;
}
