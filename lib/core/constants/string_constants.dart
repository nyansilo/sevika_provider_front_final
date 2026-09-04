/// Centralized System-Facing String Registry for the Ecosystem.
///
/// Contains immutable keys, identifiers, database names, event tokens, and
/// gateway protocols. User-facing display strings are intentionally omitted
/// here to prevent architectural localization blockades.
class StringConstants {
  const StringConstants._(); // Prevents instantiation

  /// ==========================================
  /// 1. APPLICATION ENVIRONMENT IDENTITY
  /// ==========================================
  static const String appName = 'Ecosystem Home Hub';
  static const String companyName = 'Home Services Tech Ltd';
  static const String androidPackageName = 'com.homeservices.app';
  static const String iosBundleId = 'com.homeservices.app.ios';

  /// ==========================================
  /// 2. SYSTEM DEEP LINKING & DELEGATE SCHEMES
  /// ==========================================
  static const String deepLinkScheme = 'homeservices://';
  static const String deepLinkHost = 'homeservices.co.tz';

  // Specific Deep Link Route Targets
  static const String pathWalletCallback = 'wallet/verify-stk';
  static const String pathBookingReceipt = 'bookings/receipt';
  static const String pathProviderProfile = 'provider/profile';

  /// ==========================================
  /// 3. LOCAL PERSISTENCE STORAGE NAMESCRIPTS (Hive/NoSQL)
  /// ==========================================
  static const String boxUserProfile = 'box_user_profile_secure';
  static const String boxWalletLedger = 'box_wallet_ledger_cache';
  static const String boxServiceCatalog = 'box_service_catalog_cache';
  static const String boxAppSettings = 'box_app_settings_preferences';

  /// ==========================================
  /// 4. TRANS-GATEWAY PAYMENT CHANNEL TOKENS
  /// Exact system codes passed to payment processors for routing push requests.
  /// ==========================================
  static const String channelVodacomMpesa = 'MPESA';
  static const String channelTigoPesa = 'TIGOPESA';
  static const String channelAirtelMoney = 'AIRTELMONEY';
  static const String channelHalotelHaloPesa = 'HALOPESA';
  static const String channelBankTransfer = 'BANK_TRANSFER';

  // Default currency identifier system code
  static const String currencyTzs = 'TZS';

  /// ==========================================
  /// 5. FIREBASE & CLOUD NOTIFICATION CHANNELS
  /// Hardcoded system channels required to build notification view containers.
  /// ==========================================
  static const String fcmChannelWalletId = 'wallet_transaction_alerts';
  static const String fcmChannelWalletName = 'Wallet Transactions';

  static const String fcmChannelBookingId = 'booking_dispatch_alerts';
  static const String fcmChannelBookingName = 'Booking & Dispatch Updates';

  static const String fcmChannelSupportId = 'customer_support_chats';
  static const String fcmChannelSupportName = 'Support Message Feeds';

  /// ==========================================
  /// 6. THIRD-PARTY TELEMETRY & LOG ENGINE TOKENS
  /// Operational tracking IDs used by tracking initializers.
  /// ==========================================
  static const String sentryDsnProduction =
      'https://examplePublicKey@sentry.io/exampleProject';
  static const String mixpanelTokenProduction =
      'mixpanel_production_token_hash_value';
  static const String googleMapsApiKeyAndroid =
      'AIzaSyYourAndroidGoogleMapsKeyGoesHere';
  static const String googleMapsApiKeyIos =
      'AIzaSyYourIosGoogleMapsKeyGoesHere';

  /// ==========================================
  /// 7. TELEMETRY EVENT LOGGING RECOGNIZERS (Analytics)
  /// Strict, immutable tracking tokens to verify app performance metrics.
  /// ==========================================

  // Core Operational Events
  static const String eventSignUpCompleted = 'auth_signup_completed';
  static const String eventLoginSuccess = 'auth_login_success';
  static const String eventLogoutAction = 'auth_logout_executed';

  // Wallet Interaction Events
  static const String eventStkPushInitiated = 'wallet_stk_push_requested';
  static const String eventWalletTopUpSuccess =
      'wallet_topup_completed_successfully';
  static const String eventWalletTopUpFailed =
      'wallet_topup_failed_or_timed_out';
  static const String eventWithdrawalRequested = 'wallet_withdrawal_submitted';

  // Booking Service Flow Events
  static const String eventServiceCategorySelected = 'catalog_category_viewed';
  static const String eventProviderMatchDispatched =
      'booking_provider_dispatch_triggered';
  static const String eventBookingCompletedSuccess =
      'booking_job_completed_successfully';
  static const String eventBookingCancelledByClient =
      'booking_cancelled_by_customer';

  /// ==========================================
  /// 8. TELEMETRY USER PROFILE METRICS
  /// Identifiers bound to individual analytics tracking records.
  /// ==========================================
  static const String userPropAccountStatus = 'user_verification_tier';
  static const String userPropTotalJobsBooked = 'user_historical_job_count';
  static const String userPropWalletBalanceTier = 'user_wallet_balance_bracket';
  static const String userPropPreferredPaymentChannel =
      'user_favored_payment_route';
}
