class RouteList {
  RouteList._();

  // =========================================================================
  // AUTHENTICATION & ONBOARDING
  // =========================================================================
  static const String initial = '/';
  static const String onBoardingPage = '/onboarding';
  static const String welcomePage = '/welcome';
  static const String loginPage = '/login';
  static const String registerPage = '/register';
  static const String changePasswordPage = '/change-password';

  // 🚀 NEW: PASSWORD RECOVERY ROUTES
  static const String forgotPasswordPage = '/forgot-password';
  static const String otpVerificationPage = '/otp';
  static const String resetPasswordPage = '/reset-password';

  // =========================================================================
  // MAIN LAYOUT & TABS
  // =========================================================================
  static const String mainPage = '/main';
  static const String homePage = '/home';
  static const String bookingPage = '/bookings-dashboard';
  static const String chatPage = '/chat-dashboard';
  static const String profilePage = '/profile-dashboard';

  // =========================================================================
  // DISCOVERY & CATALOG
  // =========================================================================
  static const String searchPage = '/search';
  static const String serviceCatalogPage = '/service-catalog';
  static const String serviceCatalogDetailPage = '/service-catalog-detail';
  static const String serviceProviderDetailPage = '/provider-detail';
  static const String promoWebviewPage = '/promo-webview';
  static const String featuredProfessionalsPage = '/featured-professionals';

  // =========================================================================
  // BOOKING PIPELINE & CHECKOUT
  // =========================================================================
  static const String bookingAppointmentPage = '/booking-appointment';
  static const String bookingSummaryPage = '/booking-summary';
  static const String bookingSuccessPage = '/booking-success';
  static const String autoCheckoutPage = '/auto-checkout';
  static const String bookingHistoryPage = '/booking-history';
  static const String activeJobWorkspacePage = '/active-job-workspace';
  static const String liveTrackingPage = '/live-tracking';
  static const String mapBoxLiveTrackingPage = '/mapbox-live-tracking';

  // =========================================================================
  // 🎯 CUSTOM JOBS & OPEN MARKETPLACE
  // =========================================================================
  static const String customJobFormPage = '/custom-job-form';
  static const String jobBidAcceptancePage = '/job-bid-acceptance';
  static const String customQuoteReviewPage = '/custom-quote-review';
  static const String customQuotePage = '/custom-quote';

  // =========================================================================
  // CHAT & EMERGENCY DISPATCH
  // =========================================================================
  static const String inboxPage = '/inbox';
  static const String activeCallPage = '/active-call';
  static const String emergencyDispatchPage = '/emergency-dispatch';
  static const String emergencyRadarPage =
      '/emergency-radar'; // 🎯 Fixed double slash bug
  static const String emergencyInvoiceReviewPage = '/emergency-invoice-review';

  // =========================================================================
  // PROFILE, ADDRESS, PAYMENTS & FINANCIALS
  // =========================================================================
  static const String editProfilePage = '/edit-profile';
  static const String savedAddressesPage = '/saved-addresses';
  static const String savedPaymentsPage = '/saved-payments';
  static const String addPaymentMethodPage = '/add-payment-method';
  static const String billingHistoryPage = '/billing-history';

  // 💰 NEW: WALLET & EARNINGS ROUTES
  static const String walletDashboardPage = '/wallet-dashboard';
  static const String requestWithdrawalPage = '/request-withdrawal';
  static const String allTransactionsPage = '/all-transactions'; // 🎯 ADDED
  static const String topUpPage = '/top-up'; // 🎯 ADDED
  static const String earningsDashboardPage = '/earnings-dashboard';
  static const String payoutDetailsPage = '/payout-details';

  // =========================================================================
  // ⭐ REVIEWS, FEEDBACK & PERFORMANCE (🚀 UPDATED CATEGORIZATION)
  // =========================================================================
  static const String reviewsPage = '/reviews';
  static const String feedbackHistoryPage = '/feedback-history';
  static const String favoriteProviderPage = '/favorite-providers';
  static const String favoriteServicePage = '/favorite-services';
  static const String providerFeedbackPage = '/provider-feedback';
  static const String providerReviewReplyPage = '/provider-review-reply';
  static const String performanceAnalyticsPage =
      '/performance-analytics'; // 🚀 MOVED HERE
  static const String waitlistPage = '/waitlist';

  // =========================================================================
  // REWARDS
  // =========================================================================
  static const String rewardsPage = '/rewards';
  static const String rewardDetailPage = '/reward-detail';
  static const String rewardHistoryPage = '/reward-history';

  // =========================================================================
  // SETTINGS & SUPPORT
  // =========================================================================
  static const String notificationPage = '/notifications';
  static const String settingPage = '/settings';
  static const String appLanguagePage = '/app-language';
  static const String appThemePage = '/app-theme';

  static const String systemPermissionsPage = '/system-permissions';
  static const String helpCenterPage = '/help-center';
  static const String safetyInsurancePage = '/safety-insurance';
  static const String legalTermsPage = '/legal-terms';

  // =========================================================================
  // CORE APP STATES & WEBVIEWS
  // =========================================================================
  static const String noInternetPage = '/no-internet';
  static const String forceUpdatePage = '/force-update';
  static const String maintenancePage = '/maintenance';
  static const String genericWebviewPage = '/webview';

  static const String servicePortfolioPage = '/service-portfolio';
  static const String addEditServicePage = '/add-edit-service';
  static const String servicePreviewPage = '/service-preview';
  static const String submitQuotePage = '/submit-quote';
  static const String bookingDetailPage = '/provider-booking-detail';
  static const String bookingDashboardPage = '/provider-booking-dashboard';
  static const String exploreMarketplacePage = '/provider-explore-marketplace';
  static const String rewardsDashboardPage = '/provider-reward-dashboard';

  // =========================================================================
  // 🛡️ TRUST & SAFETY (KYC)
  // =========================================================================
  static const String kycDashboardPage = '/kyc-dashboard';
  static const String submitBasicKycPage = '/submit-basic-kyc';
  static const String submitProKycPage = '/submit-pro-kyc';
}
