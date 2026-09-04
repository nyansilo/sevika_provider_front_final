/// Centralized asset registry for the Home Services & Wallet ecosystem.
///
/// This class handles paths for SVGs (icons), PNGs/JPEGs (complex illustrations),
/// and JSON files (Lottie animations). It uses grouped namespaces for clean autocomplete access.
class AppAssets {
  const AppAssets._(); // Prevents instantiation

  // Base directory paths
  static const String _iconsPath = 'assets/icons';
  static const String _imagesPath = 'assets/images';
  static const String _animationsPath = 'assets/animations';

  /// ==========================================
  /// 1. UI & VECTOR ICONS (SVGs preferred)
  /// Access via: AppAssets.icons.property
  /// ==========================================
  static const Icons icons = Icons();

  /// ==========================================
  /// 2. RASTER IMAGES & ILLUSTRATIONS (PNG/JPG)
  /// Access via: AppAssets.images.property
  /// ==========================================
  static const Images images = Images();

  /// ==========================================
  /// 3. LOTTIE INTERACTIVE ANIMATIONS (JSON)
  /// Access via: AppAssets.animations.property
  /// ==========================================
  static const Animations animations = Animations();
}

/// Namespace for vector icons and logos
class Icons {
  const Icons();

  // Core App Navigation & Shell Icons
  String get home => '${AppAssets._iconsPath}/ic_home.svg';
  String get ledger => '${AppAssets._iconsPath}/ic_ledger.svg';
  String get bookings => '${AppAssets._iconsPath}/ic_bookings.svg';
  String get profile => '${AppAssets._iconsPath}/ic_profile.svg';
  String get notifications => '${AppAssets._iconsPath}/ic_notifications.svg';

  // Home Services Categories
  String get cleaning => '${AppAssets._iconsPath}/services/ic_cleaning.svg';
  String get plumbing => '${AppAssets._iconsPath}/services/ic_plumbing.svg';
  String get electrical => '${AppAssets._iconsPath}/services/ic_electrical.svg';
  String get acRepair => '${AppAssets._iconsPath}/services/ic_ac_repair.svg';
  String get painting => '${AppAssets._iconsPath}/services/ic_painting.svg';
  String get carpentry => '${AppAssets._iconsPath}/services/ic_carpentry.svg';
  String get mediaStudio =>
      '${AppAssets._iconsPath}/services/ic_media_studio.svg';

  // Financial & Payment Channels (Aligned with MobileMoneyHelper)
  String get wallet => '${AppAssets._iconsPath}/payment/ic_wallet.svg';
  String get mpesa => '${AppAssets._iconsPath}/payment/ic_mpesa.svg';
  String get tigoPesa => '${AppAssets._iconsPath}/payment/ic_tigopesa.svg';
  String get airtelMoney =>
      '${AppAssets._iconsPath}/payment/ic_airtel_money.svg';
  String get haloPesa => '${AppAssets._iconsPath}/payment/ic_halopesa.svg';
  String get creditCard => '${AppAssets._iconsPath}/payment/ic_credit_card.svg';
  String get bankTransfer => '${AppAssets._iconsPath}/payment/ic_bank.svg';

  // General Action Elements
  String get search => '${AppAssets._iconsPath}/actions/ic_search.svg';
  String get clear => '${AppAssets._iconsPath}/actions/ic_clear.svg';
  String get filter => '${AppAssets._iconsPath}/actions/ic_filter.svg';
  String get arrowBack => '${AppAssets._iconsPath}/actions/ic_arrow_back.svg';
  String get close => '${AppAssets._iconsPath}/actions/ic_close.svg';
  String get starFilled => '${AppAssets._iconsPath}/actions/ic_star_filled.svg';
}

/// Namespace for full-scale images, placeholders, and logos
class Images {
  const Images();

  // Corporate Identity Assets
  String get appLogoLight => '${AppAssets._imagesPath}/branding/logo_light.png';
  String get appLogoDark => '${AppAssets._imagesPath}/branding/logo_dark.png';

  // Onboarding System Experience
  String get onboardingWelcome =>
      '${AppAssets._imagesPath}/onboarding/img_welcome.png';
  String get onboardingFindProvider =>
      '${AppAssets._imagesPath}/onboarding/img_find_provider.png';
  String get onboardingSecurePayment =>
      '${AppAssets._imagesPath}/onboarding/img_secure_payment.png';

  // Structural Fallback Placeholders
  String get defaultAvatar =>
      '${AppAssets._imagesPath}/placeholders/avatar_placeholder.png';
  String get brokenImage =>
      '${AppAssets._imagesPath}/placeholders/image_fallback.png';
  String get noInternet =>
      '${AppAssets._imagesPath}/placeholders/no_internet_graphic.png';
}

/// Namespace for functional micro-interactions and status animations
class Animations {
  const Animations();

  // Transaction & Operation States
  String get paymentSuccess =>
      '${AppAssets._animationsPath}/anim_payment_success.json';
  String get paymentFailed =>
      '${AppAssets._animationsPath}/anim_payment_failed.json';
  String get processingWallet =>
      '${AppAssets._animationsPath}/anim_processing_wallet.json';

  // UI Empty State Placeholders
  String get emptyLedger =>
      '${AppAssets._animationsPath}/anim_empty_ledger.json';
  String get emptyBookings =>
      '${AppAssets._animationsPath}/anim_empty_bookings.json';
  String get providerSearching =>
      '${AppAssets._animationsPath}/anim_searching_providers.json';
}
