// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // =============================================================================
// // APP CONFIG & SYSTEM STATES
// // =============================================================================
// import '../../features/analytics/args/analytics_args.dart';
// import '../../features/app_config/presentation/screens/force_update_screen.dart';
// import '../../features/earnings/presentation/screens/payout_detail_screen.dart';

// import '../../features/analytics/presentation/cubits/analytics_cubit.dart';
// import '../../features/analytics/presentation/screens/performance_analytics_screen.dart';

// import '../../features/kyc/presentation/cubits/provider_kyc_cubit.dart';
// import '../../features/kyc/presentation/screens/kyc_dashboard_screen.dart';
// import '../../features/kyc/presentation/screens/submit_basic_kyc_screen.dart';
// import '../../features/kyc/presentation/screens/submit_pro_kyc_screen.dart';
// import '../../features/review/presentation/args/provider_reply_args.dart';
// import '../../features/review/presentation/cubits/provider_reviews_cubit.dart';
// import '../../features/review/presentation/screens/provider_feedback_screen.dart';
// import '../../features/review/presentation/screens/provider_review_reply_screen.dart';
// import '../../features/service_catalog/presentation/args/service_action_args.dart';
// import '../../features/service_catalog/presentation/cubits/provider_service_cubit.dart';
// import '../../features/service_catalog/presentation/screens/service_preview_screen.dart';
// import '../global/presentation/screens/generic_webview_screen.dart';
// import '../global/presentation/screens/maintenance_screen.dart';
// import '../global/presentation/screens/no_internet_screen.dart';

// // =============================================================================
// // AUTHENTICATION & ONBOARDING
// // =============================================================================
// import '../../features/auth/presentation/cubits/password_recovery/password_recovery_cubit.dart';
// import '../../features/auth/presentation/screens/change_password_screen.dart';
// import '../../features/auth/presentation/screens/forgot_password_screen.dart';
// import '../../features/auth/presentation/screens/login_screen.dart';
// import '../../features/auth/presentation/screens/onboarding_screen.dart';
// import '../../features/auth/presentation/screens/otp_verification_screen.dart';
// import '../../features/auth/presentation/screens/register_screen.dart';
// import '../../features/auth/presentation/screens/reset_password_screen.dart';
// import '../../features/auth/presentation/screens/start_up_screen.dart';
// import '../../features/auth/presentation/screens/welcome_screen.dart';

// // =============================================================================
// // MAIN LAYOUT & PROFILE
// // =============================================================================
// import '../../features/main_layout/presentation/screens/main_layout_screen.dart';
// import '../../features/profile/presentation/cubits/profile/profile_cubit.dart';

// // =============================================================================
// // CORE BOOKING PIPELINE (Assigned Jobs)
// // =============================================================================
// import '../../features/booking/domain/entities/booking_entity.dart';
// import '../../features/booking/presentation/cubits/booking_history/booking_history_cubit.dart';
// import '../../features/booking/presentation/cubits/invoice/invoice_cubit.dart';
// import '../../features/booking/presentation/cubits/manage_job/manage_job_cubit.dart';
// import '../../features/booking/presentation/screens/bookings_dashboard_screen.dart';
// import '../../features/booking/presentation/screens/provider_booking_detail_screen.dart';
// import '../../features/booking/presentation/screens/submit_quote_screen.dart';

// // =============================================================================
// // 🛒 MARKETPLACE (Bidding Pool) & 🚨 EMERGENCY (SOS)
// // =============================================================================
// import '../../features/marketplace/presentation/cubits/explore_jobs_cubit.dart';
// import '../../features/marketplace/presentation/screens/explore_marketplace_screen.dart';

// // =============================================================================
// // 💼 PORTFOLIO & SERVICES
// // =============================================================================
// import '../../features/categories/presentation/cubits/service_category_cubit.dart';
// import '../../features/service_catalog/presentation/screens/add_edit_service_screen.dart';
// import '../../features/service_catalog/presentation/screens/service_portfolio_screen.dart';

// // =============================================================================
// // 💰 FINANCIALS (WALLET & EARNINGS)
// // =============================================================================
// import '../../features/wallet/presentation/cubits/wallet_cubit.dart';
// import '../../features/wallet/presentation/cubits/wallet_transactions_cubit.dart';
// import '../../features/wallet/presentation/cubits/withdrawal_cubit.dart';
// import '../../features/wallet/presentation/screens/request_withdrawal_screen.dart';
// import '../../features/wallet/presentation/screens/wallet_dashboard_screen.dart';
// import '../../features/wallet/presentation/screens/all_transactions_screen.dart';
// import '../../features/wallet/presentation/screens/top_up_screen.dart';

// import '../../features/earnings/presentation/cubits/earnings_cubit.dart';
// import '../../features/earnings/presentation/cubits/single_payout_cubit.dart';
// import '../../features/earnings/presentation/screens/earnings_dashboard_screen.dart';

// // =============================================================================
// // CHAT & NOTIFICATIONS
// // =============================================================================
// import '../../features/chat/presentation/cubits/chat_cubit.dart';
// import '../../features/notification/presentation/screens/notification_screen.dart';

// // =============================================================================
// // SETTINGS & SUPPORT
// // =============================================================================
// import '../../features/address/presentation/cubits/customer_address/customer_address_cubit.dart';
// import '../../features/setting/presentation/screens/app_language_screen.dart';
// import '../../features/setting/presentation/screens/app_theme_screen.dart';
// import '../../features/setting/presentation/screens/setting_screen.dart';
// import '../../features/setting/presentation/screens/system_permissions_screen.dart';
// import '../../features/support/presentation/screens/help_center_screen.dart';
// import '../../features/support/presentation/screens/legal_terms_screen.dart';
// import '../../features/support/presentation/screens/safety_insurance_screen.dart';

// // =============================================================================
// // CORE UTILS
// // =============================================================================
// import '../di/service_locator.dart';
// import '../extensions/build_context_extensions.dart';
// import '../utils/network_helper.dart';
// import 'route_list.dart';

// class Routes {
//   static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
//     // =========================================================================
//     // 🚀 AUTHENTICATION & ONBOARDING
//     // =========================================================================
//     RouteList.initial: (context) => const StartUpScreen(),

//     RouteList.onBoardingPage: (context) => const OnboardingScreen(),
//     RouteList.welcomePage: (context) => const WelcomeScreen(),
//     RouteList.loginPage: (context) => const LoginScreen(),
//     RouteList.registerPage: (context) => const RegisterScreen(),
//     RouteList.changePasswordPage: (context) => const ChangePasswordScreen(),

//     RouteList.forgotPasswordPage: (context) =>
//         BlocProvider<PasswordRecoveryCubit>(
//           create: (_) => sl<PasswordRecoveryCubit>(),
//           child: const ForgotPasswordScreen(),
//         ),
//     RouteList.otpVerificationPage: (context) => const OtpVerificationScreen(),
//     RouteList.resetPasswordPage: (context) =>
//         BlocProvider<PasswordRecoveryCubit>(
//           create: (_) => sl<PasswordRecoveryCubit>(),
//           child: const ResetPasswordScreen(),
//         ),

//     // =========================================================================
//     // 🏠 MAIN LAYOUT & TAB GLOBALS
//     // =========================================================================
//     RouteList.mainPage: (context) => MultiBlocProvider(
//       providers: [
//         BlocProvider<ProfileCubit>(create: (_) => sl<ProfileCubit>()),
//         BlocProvider<CustomerAddressCubit>(
//           create: (_) => sl<CustomerAddressCubit>(),
//         ),
//         BlocProvider<BookingHistoryCubit>(
//           create: (_) => sl<BookingHistoryCubit>(),
//         ),
//         BlocProvider<ChatCubit>(
//           create: (_) => sl<ChatCubit>()..loadChatRooms(),
//         ),
//         BlocProvider<WalletCubit>(create: (_) => sl<WalletCubit>()),
//       ],
//       child: MainLayoutScreen(),
//     ),

//     // =========================================================================
//     // 🛠️ CORE BOOKING PIPELINE (Requests, Active, History)
//     // =========================================================================
//     RouteList.bookingDashboardPage: (context) {
//       final args = ModalRoute.of(context)?.settings.arguments;
//       final int targetTab = (args is int) ? args : 0;

//       return MultiBlocProvider(
//         providers: [
//           BlocProvider(create: (context) => sl<BookingHistoryCubit>()),
//           BlocProvider(create: (context) => sl<ManageJobCubit>()),
//         ],
//         child: BookingDashboardScreen(initialTabIndex: targetTab),
//       );
//     },

//     RouteList.bookingDetailPage: (context) {
//       final booking = setting.arguments as BookingEntity;

//       return MultiBlocProvider(
//         providers: [
//           BlocProvider<ManageJobCubit>(
//             create: (context) => sl<ManageJobCubit>(),
//           ),
//           BlocProvider<InvoiceCubit>(create: (context) => sl<InvoiceCubit>()),
//         ],
//         child: ProviderBookingDetailScreen(booking: booking),
//       );
//     },

//     RouteList.submitQuotePage: (context) {
//       final booking = setting.arguments as BookingEntity;

//       return BlocProvider<ManageJobCubit>(
//         create: (context) => sl<ManageJobCubit>(),
//         child: SubmitQuoteScreen(booking: booking),
//       );
//     },

//     // =========================================================================
//     // 🛒 MARKETPLACE (Bidding Pool)
//     // =========================================================================
//     RouteList.exploreMarketplacePage: (context) =>
//         BlocProvider<ExploreJobsCubit>(
//           create: (_) => sl<ExploreJobsCubit>(),
//           child: const ExploreMarketplaceScreen(),
//         ),

//     // =========================================================================
//     // 💼 PROVIDER PORTFOLIO & SERVICES
//     // =========================================================================
//     RouteList.servicePortfolioPage: (context) =>
//         BlocProvider<ProviderServiceCubit>(
//           create: (_) => sl<ProviderServiceCubit>(),
//           child: const ServicePortfolioScreen(),
//         ),

//     RouteList.addEditServicePage: (context) {
//       final args =
//           setting.arguments as ServiceActionArgs? ?? ServiceActionArgs();

//       return MultiBlocProvider(
//         providers: [
//           BlocProvider<ProviderServiceCubit>(
//             create: (_) => sl<ProviderServiceCubit>(),
//           ),
//           BlocProvider<ServiceCategoryCubit>(
//             create: (_) => sl<ServiceCategoryCubit>(),
//           ),
//         ],
//         child: AddEditServiceScreen(args: args),
//       );
//     },

//     RouteList.servicePreviewPage: (context) {
//       final serviceData = setting.arguments as Map<String, dynamic>;
//       return ServicePreviewScreen(service: serviceData);
//     },

//     // =========================================================================
//     // 💰 FINANCIALS: WALLET & EARNINGS
//     // =========================================================================
//     RouteList.walletDashboardPage: (context) => MultiBlocProvider(
//       providers: [
//         BlocProvider<WalletCubit>(create: (_) => sl<WalletCubit>()),
//         BlocProvider<WalletTransactionsCubit>(
//           create: (_) => sl<WalletTransactionsCubit>(),
//         ),
//       ],
//       child: const WalletDashboardScreen(),
//     ),

//     RouteList.requestWithdrawalPage: (context) => BlocProvider<WithdrawalCubit>(
//       create: (_) => sl<WithdrawalCubit>(),
//       child: const RequestWithdrawalScreen(),
//     ),

//     RouteList.allTransactionsPage: (context) =>
//         BlocProvider<WalletTransactionsCubit>(
//           create: (_) =>
//               sl<WalletTransactionsCubit>()..loadInitialTransactions(),
//           child: const AllTransactionsScreen(),
//         ),

//     RouteList.topUpPage: (context) => const TopUpScreen(),

//     RouteList.earningsDashboardPage: (context) => BlocProvider<EarningsCubit>(
//       create: (_) => sl<EarningsCubit>(),
//       child: const EarningsDashboardScreen(),
//     ),

//     RouteList.payoutDetailsPage: (context) {
//       final payoutId = setting.arguments as String;
//       return BlocProvider<SinglePayoutCubit>(
//         create: (_) => sl<SinglePayoutCubit>(),
//         child: PayoutDetailsScreen(payoutId: payoutId),
//       );
//     },

//     // =========================================================================
//     // ⭐ REVIEWS & PERFORMANCE (🚀 UPDATED)
//     // =========================================================================
//     RouteList.providerFeedbackPage: (context) =>
//         BlocProvider<ProviderReviewsCubit>(
//           create: (_) => sl<ProviderReviewsCubit>(),
//           child: const ProviderFeedbackScreen(),
//         ),

//     RouteList.providerReviewReplyPage: (context) {
//       final args = setting.arguments as ProviderReplyArgs;
//       return BlocProvider<ProviderReviewsCubit>(
//         create: (_) => sl<ProviderReviewsCubit>(),
//         child: ProviderReviewReplyScreen(args: args),
//       );
//     },

//     // 🚀 NEW: Integrated Analytics Screen with DI and Args parsing
//     RouteList.performanceAnalyticsPage: (context) {
//       final args = setting.arguments as AnalyticsArgs?;

//       return BlocProvider<AnalyticsCubit>(
//         create: (_) => sl<AnalyticsCubit>(),
//         child: PerformanceAnalyticsScreen(args: args),
//       );
//     },

//     // =========================================================================
//     // 🛡️ TRUST & SAFETY (KYC)
//     // =========================================================================
//     RouteList.kycDashboardPage: (context) {
//       // 🚀 DEFENSIVE ROUTING: Checks if the Dashboard was launched with an existing Cubit argument.
//       // (Like when called from the Profile Dashboard menu to save API calls)
//       final existingCubit = setting.arguments as ProviderKycCubit?;
//       return existingCubit != null
//           ? BlocProvider<ProviderKycCubit>.value(
//               value: existingCubit,
//               child: const KycDashboardScreen(),
//             )
//           : BlocProvider<ProviderKycCubit>(
//               create: (_) => sl<ProviderKycCubit>()..fetchKycStatus(),
//               child: const KycDashboardScreen(),
//             );
//     },

//     RouteList.submitBasicKycPage: (context) {
//       // 🚀 DEFENSIVE ROUTING: Safely handles Deep Links or Push Notifications!
//       final existingCubit = setting.arguments as ProviderKycCubit?;
//       return existingCubit != null
//           ? BlocProvider<ProviderKycCubit>.value(
//               value: existingCubit,
//               child: const SubmitBasicKycScreen(),
//             )
//           : BlocProvider<ProviderKycCubit>(
//               create: (_) => sl<ProviderKycCubit>()..fetchKycStatus(),
//               child: const SubmitBasicKycScreen(),
//             );
//     },

//     RouteList.submitProKycPage: (context) {
//       final existingCubit = setting.arguments as ProviderKycCubit?;
//       return existingCubit != null
//           ? BlocProvider<ProviderKycCubit>.value(
//               value: existingCubit,
//               child: const SubmitProKycScreen(),
//             )
//           : BlocProvider<ProviderKycCubit>(
//               create: (_) => sl<ProviderKycCubit>()..fetchKycStatus(),
//               child: const SubmitProKycScreen(),
//             );
//     },

//     // =========================================================================
//     // ⚙️ SETTINGS, NOTIFICATIONS & SUPPORT
//     // =========================================================================
//     RouteList.notificationPage: (context) => const NotificationScreen(),
//     RouteList.appThemePage: (context) => const AppThemeScreen(),
//     RouteList.settingPage: (context) => const SettingScreen(),
//     RouteList.appLanguagePage: (context) => const AppLanguageScreen(),
//     RouteList.systemPermissionsPage: (context) =>
//         const SystemPermissionsScreen(),
//     RouteList.helpCenterPage: (context) => const HelpCenterScreen(),
//     RouteList.safetyInsurancePage: (context) => const SafetyInsuranceScreen(),
//     RouteList.legalTermsPage: (context) => const LegalTermsScreen(),

//     // =========================================================================
//     // 🛑 CORE APP STATES & SYSTEM FALLBACKS
//     // =========================================================================
//     RouteList.noInternetPage: (context) => NoInternetScreen(
//       onRetry: () async {
//         final isConnected = await NetworkHelper.hasInternetAccess();
//         if (!context.mounted) return;

//         if (isConnected) {
//           Navigator.pop(context);
//         } else {
//           context.showOfflineSnackBar();
//         }
//       },
//     ),

//     RouteList.forceUpdatePage: (context) {
//       final storeUrl = setting.arguments as String? ?? 'https://sevika.co.tz';
//       return ForceUpdateScreen(storeUrl: storeUrl);
//     },

//     RouteList.maintenancePage: (context) {
//       final eta = setting.arguments as String?;
//       return MaintenanceScreen(estimatedCompletionTime: eta);
//     },

//     RouteList.genericWebviewPage: (context) {
//       final args = setting.arguments as Map<String, dynamic>? ?? {};
//       return GenericWebviewScreen(
//         title: args['title'] as String? ?? 'Sevika',
//         url: args['url'] as String? ?? 'https://sevika.co.tz',
//       );
//     },
//   };
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// =============================================================================
// APP CONFIG & SYSTEM STATES
// =============================================================================
import '../../features/analytics/args/analytics_args.dart';
import '../../features/app_config/presentation/screens/force_update_screen.dart';
import '../../features/earnings/presentation/screens/payout_detail_screen.dart';

import '../../features/analytics/presentation/cubits/analytics_cubit.dart';
import '../../features/analytics/presentation/screens/performance_analytics_screen.dart';

import '../../features/kyc/presentation/cubits/provider_kyc_cubit.dart';
import '../../features/kyc/presentation/screens/kyc_dashboard_screen.dart';
import '../../features/kyc/presentation/screens/submit_basic_kyc_screen.dart';
import '../../features/kyc/presentation/screens/submit_pro_kyc_screen.dart';
import '../../features/review/presentation/args/provider_reply_args.dart';
import '../../features/review/presentation/cubits/provider_reviews_cubit.dart';
import '../../features/review/presentation/screens/provider_feedback_screen.dart';
import '../../features/review/presentation/screens/provider_review_reply_screen.dart';
import '../../features/service_catalog/presentation/args/service_action_args.dart';
import '../../features/service_catalog/presentation/cubits/provider_service_cubit.dart';
import '../../features/service_catalog/presentation/screens/service_preview_screen.dart';
import '../global/presentation/screens/generic_webview_screen.dart';
import '../global/presentation/screens/maintenance_screen.dart';
import '../global/presentation/screens/no_internet_screen.dart';

// =============================================================================
// AUTHENTICATION & ONBOARDING
// =============================================================================
import '../../features/auth/presentation/cubits/password_recovery/password_recovery_cubit.dart';
import '../../features/auth/presentation/screens/change_password_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/otp_verification_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/reset_password_screen.dart';
import '../../features/auth/presentation/screens/start_up_screen.dart';
import '../../features/auth/presentation/screens/welcome_screen.dart';

// =============================================================================
// MAIN LAYOUT & PROFILE
// =============================================================================
import '../../features/main_layout/presentation/screens/main_layout_screen.dart';
import '../../features/profile/presentation/cubits/profile/profile_cubit.dart';
import '../../features/profile/presentation/cubits/status/provider_status_cubit.dart'; // 🚀 ADDED

// =============================================================================
// CORE BOOKING PIPELINE (Assigned Jobs)
// =============================================================================
import '../../features/booking/domain/entities/booking_entity.dart';
import '../../features/booking/presentation/cubits/booking_history/booking_history_cubit.dart';
import '../../features/booking/presentation/cubits/invoice/invoice_cubit.dart';
import '../../features/booking/presentation/cubits/manage_job/manage_job_cubit.dart';
import '../../features/booking/presentation/screens/bookings_dashboard_screen.dart';
import '../../features/booking/presentation/screens/provider_booking_detail_screen.dart';
import '../../features/booking/presentation/screens/submit_quote_screen.dart';

// =============================================================================
// 🛒 MARKETPLACE (Bidding Pool) & 🚨 EMERGENCY (SOS)
// =============================================================================
import '../../features/marketplace/presentation/cubits/explore_jobs_cubit.dart';
import '../../features/marketplace/presentation/screens/explore_marketplace_screen.dart';

// =============================================================================
// 💼 PORTFOLIO & SERVICES
// =============================================================================
import '../../features/categories/presentation/cubits/service_category_cubit.dart';
import '../../features/service_catalog/presentation/screens/add_edit_service_screen.dart';
import '../../features/service_catalog/presentation/screens/service_portfolio_screen.dart';

// =============================================================================
// 💰 FINANCIALS (WALLET & EARNINGS)
// =============================================================================
import '../../features/wallet/presentation/cubits/wallet_cubit.dart';
import '../../features/wallet/presentation/cubits/wallet_transactions_cubit.dart';
import '../../features/wallet/presentation/cubits/withdrawal_cubit.dart';
import '../../features/wallet/presentation/screens/request_withdrawal_screen.dart';
import '../../features/wallet/presentation/screens/wallet_dashboard_screen.dart';
import '../../features/wallet/presentation/screens/all_transactions_screen.dart';
import '../../features/wallet/presentation/screens/top_up_screen.dart';

import '../../features/earnings/presentation/cubits/earnings_cubit.dart';
import '../../features/earnings/presentation/cubits/single_payout_cubit.dart';
import '../../features/earnings/presentation/screens/earnings_dashboard_screen.dart';

// =============================================================================
// CHAT & NOTIFICATIONS
// =============================================================================
import '../../features/chat/presentation/cubits/chat_cubit.dart';
import '../../features/notification/presentation/cubits/notification/notifications_cubit.dart'; // 🚀 ADDED
import '../../features/notification/presentation/screens/notification_screen.dart';

// =============================================================================
// SETTINGS & SUPPORT
// =============================================================================
import '../../features/address/presentation/cubits/customer_address/customer_address_cubit.dart';
import '../../features/setting/presentation/screens/app_language_screen.dart';
import '../../features/setting/presentation/screens/app_theme_screen.dart';
import '../../features/setting/presentation/screens/setting_screen.dart';
import '../../features/setting/presentation/screens/system_permissions_screen.dart';
import '../../features/support/presentation/screens/help_center_screen.dart';
import '../../features/support/presentation/screens/legal_terms_screen.dart';
import '../../features/support/presentation/screens/safety_insurance_screen.dart';

// =============================================================================
// CORE UTILS
// =============================================================================
import '../di/service_locator.dart';
import '../extensions/build_context_extensions.dart';
import '../utils/network_helper.dart';
import 'route_list.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
    // =========================================================================
    // 🚀 AUTHENTICATION & ONBOARDING
    // =========================================================================
    RouteList.initial: (context) => const StartUpScreen(),

    RouteList.onBoardingPage: (context) => const OnboardingScreen(),
    RouteList.welcomePage: (context) => const WelcomeScreen(),
    RouteList.loginPage: (context) => const LoginScreen(),
    RouteList.registerPage: (context) => const RegisterScreen(),
    RouteList.changePasswordPage: (context) => const ChangePasswordScreen(),

    RouteList.forgotPasswordPage: (context) =>
        BlocProvider<PasswordRecoveryCubit>(
          create: (_) => sl<PasswordRecoveryCubit>(),
          child: const ForgotPasswordScreen(),
        ),
    RouteList.otpVerificationPage: (context) => const OtpVerificationScreen(),
    RouteList.resetPasswordPage: (context) =>
        BlocProvider<PasswordRecoveryCubit>(
          create: (_) => sl<PasswordRecoveryCubit>(),
          child: const ResetPasswordScreen(),
        ),

    // =========================================================================
    // 🏠 MAIN LAYOUT & TAB GLOBALS
    // =========================================================================
    RouteList.mainPage: (context) => MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(create: (_) => sl<ProfileCubit>()),
        BlocProvider<CustomerAddressCubit>(
          create: (_) => sl<CustomerAddressCubit>(),
        ),
        BlocProvider<BookingHistoryCubit>(
          create: (_) => sl<BookingHistoryCubit>(),
        ),
        BlocProvider<ChatCubit>(
          create: (_) => sl<ChatCubit>()..loadChatRooms(),
        ),
        BlocProvider<WalletCubit>(create: (_) => sl<WalletCubit>()),

        // 🚀 NEW: Required by HomeDashboardScreen to function correctly inside the layout!
        BlocProvider<ProviderStatusCubit>(
          create: (_) => sl<ProviderStatusCubit>(),
        ),
        BlocProvider<ProviderKycCubit>(create: (_) => sl<ProviderKycCubit>()),
        BlocProvider<EarningsCubit>(create: (_) => sl<EarningsCubit>()),
        BlocProvider<NotificationsCubit>(
          create: (_) => sl<NotificationsCubit>(),
        ),

        // 🚀 THE FIX: Added ProviderReviewsCubit so the Home Dashboard can calculate the dynamic rating!
        BlocProvider<ProviderReviewsCubit>(
          create: (_) => sl<ProviderReviewsCubit>(),
        ),

        BlocProvider<AnalyticsCubit>(create: (_) => sl<AnalyticsCubit>()),
      ],
      child: MainLayoutScreen(),
    ),

    // =========================================================================
    // 🛠️ CORE BOOKING PIPELINE (Requests, Active, History)
    // =========================================================================
    RouteList.bookingDashboardPage: (context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      final int targetTab = (args is int) ? args : 0;

      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<BookingHistoryCubit>()),
          BlocProvider(create: (context) => sl<ManageJobCubit>()),
        ],
        child: BookingDashboardScreen(initialTabIndex: targetTab),
      );
    },

    RouteList.bookingDetailPage: (context) {
      final booking = setting.arguments as BookingEntity;

      return MultiBlocProvider(
        providers: [
          BlocProvider<ManageJobCubit>(
            create: (context) => sl<ManageJobCubit>(),
          ),
          BlocProvider<InvoiceCubit>(create: (context) => sl<InvoiceCubit>()),
        ],
        child: ProviderBookingDetailScreen(booking: booking),
      );
    },

    RouteList.submitQuotePage: (context) {
      final booking = setting.arguments as BookingEntity;

      return BlocProvider<ManageJobCubit>(
        create: (context) => sl<ManageJobCubit>(),
        child: SubmitQuoteScreen(booking: booking),
      );
    },

    // =========================================================================
    // 🛒 MARKETPLACE (Bidding Pool)
    // =========================================================================
    RouteList.exploreMarketplacePage: (context) =>
        BlocProvider<ExploreJobsCubit>(
          create: (_) => sl<ExploreJobsCubit>(),
          child: const ExploreMarketplaceScreen(),
        ),

    // =========================================================================
    // 💼 PROVIDER PORTFOLIO & SERVICES
    // =========================================================================
    RouteList.servicePortfolioPage: (context) =>
        BlocProvider<ProviderServiceCubit>(
          create: (_) => sl<ProviderServiceCubit>(),
          child: const ServicePortfolioScreen(),
        ),

    RouteList.addEditServicePage: (context) {
      final args =
          setting.arguments as ServiceActionArgs? ?? ServiceActionArgs();

      return MultiBlocProvider(
        providers: [
          BlocProvider<ProviderServiceCubit>(
            create: (_) => sl<ProviderServiceCubit>(),
          ),
          BlocProvider<ServiceCategoryCubit>(
            create: (_) => sl<ServiceCategoryCubit>(),
          ),
        ],
        child: AddEditServiceScreen(args: args),
      );
    },

    RouteList.servicePreviewPage: (context) {
      final serviceData = setting.arguments as Map<String, dynamic>;
      return ServicePreviewScreen(service: serviceData);
    },

    // =========================================================================
    // 💰 FINANCIALS: WALLET & EARNINGS
    // =========================================================================
    RouteList.walletDashboardPage: (context) => MultiBlocProvider(
      providers: [
        BlocProvider<WalletCubit>(create: (_) => sl<WalletCubit>()),
        BlocProvider<WalletTransactionsCubit>(
          create: (_) => sl<WalletTransactionsCubit>(),
        ),
      ],
      child: const WalletDashboardScreen(),
    ),

    RouteList.requestWithdrawalPage: (context) => BlocProvider<WithdrawalCubit>(
      create: (_) => sl<WithdrawalCubit>(),
      child: const RequestWithdrawalScreen(),
    ),

    RouteList.allTransactionsPage: (context) =>
        BlocProvider<WalletTransactionsCubit>(
          create: (_) =>
              sl<WalletTransactionsCubit>()..loadInitialTransactions(),
          child: const AllTransactionsScreen(),
        ),

    RouteList.topUpPage: (context) => const TopUpScreen(),

    RouteList.earningsDashboardPage: (context) => BlocProvider<EarningsCubit>(
      create: (_) => sl<EarningsCubit>(),
      child: const EarningsDashboardScreen(),
    ),

    RouteList.payoutDetailsPage: (context) {
      final payoutId = setting.arguments as String;
      return BlocProvider<SinglePayoutCubit>(
        create: (_) => sl<SinglePayoutCubit>(),
        child: PayoutDetailsScreen(payoutId: payoutId),
      );
    },

    // =========================================================================
    // ⭐ REVIEWS & PERFORMANCE (🚀 UPDATED)
    // =========================================================================
    RouteList.providerFeedbackPage: (context) =>
        BlocProvider<ProviderReviewsCubit>(
          create: (_) => sl<ProviderReviewsCubit>(),
          child: const ProviderFeedbackScreen(),
        ),

    RouteList.providerReviewReplyPage: (context) {
      final args = setting.arguments as ProviderReplyArgs;
      return BlocProvider<ProviderReviewsCubit>(
        create: (_) => sl<ProviderReviewsCubit>(),
        child: ProviderReviewReplyScreen(args: args),
      );
    },

    // 🚀 NEW: Integrated Analytics Screen with DI and Args parsing
    RouteList.performanceAnalyticsPage: (context) {
      final args = setting.arguments as AnalyticsArgs?;

      return BlocProvider<AnalyticsCubit>(
        create: (_) => sl<AnalyticsCubit>(),
        child: PerformanceAnalyticsScreen(args: args),
      );
    },

    // =========================================================================
    // 🛡️ TRUST & SAFETY (KYC)
    // =========================================================================
    RouteList.kycDashboardPage: (context) {
      // 🚀 DEFENSIVE ROUTING: Checks if the Dashboard was launched with an existing Cubit argument.
      // (Like when called from the Profile Dashboard menu to save API calls)
      final existingCubit = setting.arguments as ProviderKycCubit?;
      return existingCubit != null
          ? BlocProvider<ProviderKycCubit>.value(
              value: existingCubit,
              child: const KycDashboardScreen(),
            )
          : BlocProvider<ProviderKycCubit>(
              create: (_) => sl<ProviderKycCubit>()..fetchKycStatus(),
              child: const KycDashboardScreen(),
            );
    },

    RouteList.submitBasicKycPage: (context) {
      // 🚀 DEFENSIVE ROUTING: Safely handles Deep Links or Push Notifications!
      final existingCubit = setting.arguments as ProviderKycCubit?;
      return existingCubit != null
          ? BlocProvider<ProviderKycCubit>.value(
              value: existingCubit,
              child: const SubmitBasicKycScreen(),
            )
          : BlocProvider<ProviderKycCubit>(
              create: (_) => sl<ProviderKycCubit>()..fetchKycStatus(),
              child: const SubmitBasicKycScreen(),
            );
    },

    RouteList.submitProKycPage: (context) {
      final existingCubit = setting.arguments as ProviderKycCubit?;
      return existingCubit != null
          ? BlocProvider<ProviderKycCubit>.value(
              value: existingCubit,
              child: const SubmitProKycScreen(),
            )
          : BlocProvider<ProviderKycCubit>(
              create: (_) => sl<ProviderKycCubit>()..fetchKycStatus(),
              child: const SubmitProKycScreen(),
            );
    },

    // =========================================================================
    // ⚙️ SETTINGS, NOTIFICATIONS & SUPPORT
    // =========================================================================
    RouteList.notificationPage: (context) => const NotificationScreen(),
    RouteList.appThemePage: (context) => const AppThemeScreen(),
    RouteList.settingPage: (context) => const SettingScreen(),
    RouteList.appLanguagePage: (context) => const AppLanguageScreen(),
    RouteList.systemPermissionsPage: (context) =>
        const SystemPermissionsScreen(),
    RouteList.helpCenterPage: (context) => const HelpCenterScreen(),
    RouteList.safetyInsurancePage: (context) => const SafetyInsuranceScreen(),
    RouteList.legalTermsPage: (context) => const LegalTermsScreen(),

    // =========================================================================
    // 🛑 CORE APP STATES & SYSTEM FALLBACKS
    // =========================================================================
    RouteList.noInternetPage: (context) => NoInternetScreen(
      onRetry: () async {
        final isConnected = await NetworkHelper.hasInternetAccess();
        if (!context.mounted) return;

        if (isConnected) {
          Navigator.pop(context);
        } else {
          context.showOfflineSnackBar();
        }
      },
    ),

    RouteList.forceUpdatePage: (context) {
      final storeUrl = setting.arguments as String? ?? 'https://sevika.co.tz';
      return ForceUpdateScreen(storeUrl: storeUrl);
    },

    RouteList.maintenancePage: (context) {
      final eta = setting.arguments as String?;
      return MaintenanceScreen(estimatedCompletionTime: eta);
    },

    RouteList.genericWebviewPage: (context) {
      final args = setting.arguments as Map<String, dynamic>? ?? {};
      return GenericWebviewScreen(
        title: args['title'] as String? ?? 'Sevika',
        url: args['url'] as String? ?? 'https://sevika.co.tz',
      );
    },
  };
}
