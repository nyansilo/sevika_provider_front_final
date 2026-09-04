/// Centralized UI Display String Registry.
///
/// Consolidates all user-facing copy, screen headers, button labels, error alerts,
/// and informational prompts across the Home Services & Wallet interface modules.
class UiStrings {
  const UiStrings._(); // Prevents instantiation

  /// ==========================================
  /// 1. SCREEN & NAVIGATION PAGE TITLES
  /// Perfect for AppBar titles, named routing tables, and analytics page-tracking.
  /// ==========================================
  static const String pageSplash = 'Loading Hub...';
  static const String pageOnboarding = 'Welcome to Ecosystem';
  static const String pageLogin = 'Sign In';
  static const String pageRegister = 'Create Account';
  static const String pageOtpVerification = 'Verify Phone Number';

  // Main Navigation Core Tabs
  static const String pageHome = 'Home Dashboard';
  static const String pageBookingsHistory = 'My Bookings';
  static const String pageWallet = 'Wallet & Payments';
  static const String pageProfile = 'Account Settings';

  // Wallet Interaction Pages
  static const String pageWalletTopUp = 'Top Up Funds';
  static const String pageWalletWithdraw = 'Withdraw Cash';
  static const String pageTransactionDetails = 'Transaction Receipt';

  // Booking & Service Selection Flow
  static const String pageServiceCatalog = 'Select Sub-Service';
  static const String pageProviderSelection = 'Available Professionals';
  static const String pageBookingCheckout = 'Confirm Order Summary';
  static const String pageTrackingLive = 'Live Job Tracking';

  // Profile & Support Auxiliary Pages
  static const String pageCustomerSupport = 'Help Center';
  static const String pageEditProfile = 'Update Personal Info';
  static const String pageNotifications = 'Notifications';

  /// ==========================================
  /// 2. ONBOARDING & WELCOME MODULE
  /// ==========================================
  static const String onboardingSkip = 'Skip';
  static const String onboardingNext = 'Next';
  static const String onboardingGetStarted = 'Get Started';

  static const String onboardingTitle1 = 'Verified Local Experts';
  static const String onboardingSub1 =
      'Find trusted fundis, cleaners, and electricians near you, vetted for quality and safety.';

  static const String onboardingTitle2 = 'Secure Digital Wallet';
  static const String onboardingSub2 =
      'Top up seamlessly via M-Pesa, Tigo Pesa, or Airtel Money. Pay securely only after the job is done.';

  static const String onboardingTitle3 = 'Instant Job Dispatch';
  static const String onboardingSub3 =
      'Book a service in seconds. Our automated system matches you with the closest available professional.';

  /// ==========================================
  /// 3. AUTHENTICATION & IDENTITY MODULE
  /// ==========================================
  static const String authLoginTitle = 'Welcome Back';
  static const String authLoginSub =
      'Enter your phone number to access your account';
  static const String authRegisterTitle = 'Create Account';
  static const String authRegisterSub =
      'Join us to book reliable services instantly';

  // Form Labels & Placeholders
  static const String labelPhoneNumber = 'Phone Number';
  static const String hintPhoneNumber = 'e.g., 0700000000';
  static const String labelFullName = 'Full Name';
  static const String hintFullName = 'e.g., John Doe';
  static const String labelNidaNumber = 'NIDA National ID Number';
  static const String hintNidaNumber = 'Enter 20-digit NIDA number';

  // OTP Verification Screen
  static const String otpTitle = 'Verification Code';
  static const String otpSub = 'We have sent a 6-digit verification code to';
  static const String otpResendPrompt = "Didn't receive the code? ";
  static const String otpResendAction = 'Resend OTP';

  // Buttons
  static const String btnContinue = 'Continue';
  static const String btnVerify = 'Verify & Proceed';

  /// ==========================================
  /// 4. HOME & SERVICE CATALOG FEEDS
  /// ==========================================
  static const String homeSearchPlaceholder =
      'Search for a service (e.g., plumber)...';
  static const String homeSectionCategories = 'Our Services';
  static const String homeSectionFeaturedPros = 'Top Rated Providers Nearby';
  static const String homeSectionRecentBookings = 'Your Active Requests';
  static const String homeViewAll = 'See All';

  // Core Service Categories
  static const String serviceCleaning = 'Cleaning';
  static const String servicePlumbing = 'Plumbing';
  static const String serviceElectrical = 'Electrical';
  static const String serviceHandyman = 'Handyman Services';

  /// ==========================================
  /// 5. DIGITAL WALLET & TRANSACTION SHEET
  /// ==========================================
  static const String walletBalanceLabel = 'Available Balance';
  static const String walletTopUp = 'Top Up';
  static const String walletWithdraw = 'Withdraw';
  static const String walletRecentTransactions = 'Transaction History';
  static const String walletNoTransactions = 'No transactions recorded yet.';

  // Top Up & Withdrawal Sheets
  static const String paymentSelectChannel = 'Select Payment Channel';
  static const String paymentAmountLabel = 'Amount (TZS)';
  static const String paymentMinLimitWarning =
      'Minimum amount allowed is TZS 1,000';
  static const String walletTransferFeeNotice =
      'A system processing fee of TZS 500 applies to withdrawals.';
  static const String walletUnverifiedLimitWarning =
      'Upgrade to a verified account using NIDA to hold up to TZS 5,000,000.';

  // Transaction Types / Statuses
  static const String txnDepositSuccess = 'Deposit Successful';
  static const String txnWithdrawalSuccess = 'Withdrawal Successful';
  static const String txnPaymentDeduction = 'Job Payment Deduction';
  static const String txnStatusPending = 'Pending Verification';
  static const String txnStatusFailed = 'Failed';

  /// ==========================================
  /// 6. BOOKING CONTEXT & CHECKOUT ENGINE
  /// ==========================================
  static const String bookingScheduleTitle = 'Schedule Service';
  static const String bookingSelectDate = 'Select Preferred Date';
  static const String bookingSelectTime = 'Select Preferred Time';
  static const String bookingLocationTitle = 'Confirm Service Location';
  static const String bookingLocationSub = 'Using your pinned map location';

  // Invoice / Price Breakdowns
  static const String checkoutOrderSummary = 'Payment Summary';
  static const String checkoutBasePrice = 'Service Base Charge';
  static const String checkoutBookingFee = 'Platform Booking Fee';
  static const String checkoutVat = 'Statutory VAT (18%)';
  static const String checkoutTotal = 'Total Bill Amount';
  static const String checkoutPayWithWallet = 'Confirm & Pay from Wallet';

  // Booking Status States
  static const String bookingStatusRequested = 'Finding your provider...';
  static const String bookingStatusAccepted = 'Provider is on the way';
  static const String bookingStatusInProgress = 'Job in progress';
  static const String bookingStatusCompleted = 'Job completed successfully';
  static const String bookingStatusCancelled = 'Booking Cancelled';

  /// ==========================================
  /// 7. CUSTOMER SUPPORT & CHAT MODULE
  /// ==========================================
  static const String supportHeader = 'Help & Support';
  static const String supportSub =
      'Having trouble? Connect with our team 24/7.';
  static const String supportCallUs = 'Call Head Office';
  static const String supportWhatsAppUs = 'Chat via WhatsApp';
  static const String supportEmailUs = 'Email Support';
  static const String chatInputPlaceholder = 'Type your message here...';

  /// ==========================================
  /// 8. GLOBAL STATUS ALERTS, SUCCESS, & ERROR PROMPTS
  /// ==========================================
  static const String alertSuccessTitle = 'Success!';
  static const String alertErrorTitle = 'Something went wrong';
  static const String alertNoInternet =
      'No internet connection detected. Please check your network status.';
  static const String alertTimeout =
      'The server is taking too long to respond. Please try again.';
  static const String alertInsufficientFunds =
      'Insufficient wallet balance. Please top up your wallet to book this service.';
  static const String alertInvalidOtp =
      'The code entered is invalid. Please double-check and retry.';
  static const String alertLocationDenied =
      'Location permissions are required to map nearby service providers.';

  // Specific Action Feedback
  static const String successTopUpInitiated =
      'STK Push prompt sent to your phone. Please input your PIN to complete the transaction.';
  static const String successBookingConfirmed =
      'Your booking request has been confirmed! An expert provider is being assigned.';
  static const String successWithdrawalProcessed =
      'Your withdrawal request has been received and is being processed.';
  static const String dialogCancelConfirmTitle = 'Cancel Booking?';
  static const String dialogCancelConfirmSub =
      'Cancellations made past our 30-minute grace window incur a 10% penalty fee.';
  static const String dialogBtnDismiss = 'Go Back';
  static const String dialogBtnConfirm = 'Confirm Cancellation';
}
