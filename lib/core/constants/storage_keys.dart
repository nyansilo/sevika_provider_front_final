class StorageKeys {
  const StorageKeys._(); // Prevents instantiation

  /// ==========================================
  /// 1. SECURE VAULT KEYS (Flutter Secure Storage)
  /// These keys hold high-security cryptographic tokens and session anchors.
  /// ==========================================

  /// Encrypted JSON Web Token (JWT) sent alongside API requests for client clearance.
  static const String accessToken = 'secure_user_access_token';

  /// Long-lived token used to silently fetch an updated access token when it expires.
  static const String refreshToken = 'secure_user_refresh_token';

  /// Encrypted user verification credentials or biometric authentication preferences.
  static const String biometricPasskey = 'secure_biometric_passkey';

  /// Added: The validated administrative role of the account session ('customer')
  /// Expected type: [String]
  static const String userRole = 'secure_user_role';

  /// ==========================================
  /// 2. USER SESSION & ONBOARDING STATES (Shared Preferences / Hive)
  /// ==========================================
  static const String isFirstTimeUser = 'pref_is_first_time_user';
  static const String onboardingDone = 'onboarding_done';
  static const String userId = 'cache_user_id';
  static const String userProfileJson = 'cache_user_profile_json';
  static const String cachedUser = 'cached_user';

  /// ==========================================
  /// 3. APP ENGINE CONFIGURATIONS & PREFERENCES
  /// ==========================================
  static const String activeThemeMode = 'pref_active_theme_mode';
  static const String appLanguageLocale = 'pref_app_language_locale';

  /// ==========================================
  /// 4. DIGITAL WALLET METRIC CACHES (Offline-First UI Syncing)
  /// ==========================================
  static const String cachedWalletBalance = 'cache_wallet_balance_amount';
  static const String cachedTransactionLedger = 'cache_transaction_ledger_box';

  /// ==========================================
  /// 5. SERVICE CATALOGS & LOCATION CACHES
  /// ==========================================
  static const String cachedServiceCategories = 'cache_service_categories_list';
  static const String serviceSearchHistory = 'cache_service_search_history';
  static const String cachedLastKnownLatitude = 'cache_last_latitude';
  static const String cachedLastKnownLongitude = 'cache_last_longitude';
}
