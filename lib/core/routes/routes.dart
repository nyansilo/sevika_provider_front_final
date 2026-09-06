import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// =============================================================================
// APP CONFIG & SYSTEM STATES
// =============================================================================
import '../../features/app_config/presentation/screens/force_update_screen.dart';
import '../../features/earnings/presentation/screens/payout_detail_screen.dart';
import '../../features/review/presentation/args/provider_reply_args.dart';
import '../../features/review/presentation/cubits/provider_reviews_cubit.dart';
import '../../features/review/presentation/screens/provider_feedback_screen.dart';
import '../../features/review/presentation/screens/provider_review_reply_screen.dart';
import '../presentation/screens/generic_webview_screen.dart';
import '../presentation/screens/maintenance_screen.dart';
import '../presentation/screens/no_internet_screen.dart';

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
// PORTFOLIO & SERVICES
// =============================================================================
import '../../features/services/presentation/screens/add_edit_service_screen.dart';
import '../../features/services/presentation/screens/service_portfolio_screen.dart';
import '../../features/services/presentation/screens/service_preview_screen.dart';

// =============================================================================
// 💰 FINANCIALS (WALLET & EARNINGS) - 🎯 ADDED
// =============================================================================
import '../../features/wallet/presentation/cubits/wallet_cubit.dart';
import '../../features/wallet/presentation/cubits/wallet_transactions_cubit.dart';
import '../../features/wallet/presentation/cubits/withdrawal_cubit.dart';
import '../../features/wallet/presentation/screens/request_withdrawal_screen.dart';
import '../../features/wallet/presentation/screens/wallet_dashboard_screen.dart';
import '../../features/wallet/presentation/screens/all_transactions_screen.dart'; // 🎯 ADDED
import '../../features/wallet/presentation/screens/top_up_screen.dart'; // 🎯 ADDED

import '../../features/earnings/presentation/cubits/earnings_cubit.dart';
import '../../features/earnings/presentation/cubits/single_payout_cubit.dart';
import '../../features/earnings/presentation/screens/earnings_dashboard_screen.dart';

// =============================================================================
// CHAT & NOTIFICATIONS
// =============================================================================
import '../../features/chat/presentation/cubits/chat_cubit.dart';
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
        // Pipeline available globally for bottom navigation indicators
        BlocProvider<BookingHistoryCubit>(
          create: (_) => sl<BookingHistoryCubit>(),
        ),
        // Chat connection initialized globally
        BlocProvider<ChatCubit>(
          create: (_) => sl<ChatCubit>()..loadChatRooms(),
        ),

        // 🎯 FIXED: Injected WalletCubit so ProfileDashboardScreen can read the balance!
        BlocProvider<WalletCubit>(create: (_) => sl<WalletCubit>()),
      ],
      child: MainLayoutScreen(),
    ),
    // =========================================================================
    // 🛠️ CORE BOOKING PIPELINE (Requests, Active, History)
    // =========================================================================
    RouteList.bookingDashboardPage: (context) {
      // 🎯 THE FIX: Catch the argument passed by the Navigator!
      final args = ModalRoute.of(context)?.settings.arguments;
      final int targetTab = (args is int)
          ? args
          : 0; // Default to 0 (Requests) if null

      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<BookingHistoryCubit>()),
          BlocProvider(create: (context) => sl<ManageJobCubit>()),
        ],
        // 🎯 Pass the tab index to the screen constructor (remove the 'const' keyword)
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

    // Note: Emergency SOS does not have a route because it triggers as a
    // global Alert Dialog via the Push Notification Service payload!

    // =========================================================================
    // 💼 PROVIDER PORTFOLIO & SERVICES
    // =========================================================================
    RouteList.servicePortfolioPage: (context) => const ServicePortfolioScreen(),
    RouteList.addEditServicePage: (context) {
      final serviceId = setting.arguments as String?;
      return AddEditServiceScreen(serviceId: serviceId);
    },
    RouteList.servicePreviewPage: (context) {
      final serviceData = setting.arguments as Map<String, dynamic>;
      return ServicePreviewScreen(service: serviceData);
    },

    // =========================================================================
    // 💰 FINANCIALS: WALLET & EARNINGS (🎯 ADDED)
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

    // 🎯 NEW: All Transactions Screen
    RouteList.allTransactionsPage: (context) =>
        BlocProvider<WalletTransactionsCubit>(
          create: (_) =>
              sl<WalletTransactionsCubit>()..loadInitialTransactions(),
          child: const AllTransactionsScreen(),
        ),

    // 🎯 NEW: Top Up Screen (Static UI for now, no complex bloc needed yet)
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
    // ⭐ REVIEWS & PERFORMANCE
    // =========================================================================
    RouteList.providerFeedbackPage: (context) =>
        BlocProvider<ProviderReviewsCubit>(
          create: (_) => sl<ProviderReviewsCubit>(),
          child: const ProviderFeedbackScreen(),
        ),

    // 🚀 ADDED THIS NEW ROUTE
    RouteList.providerReviewReplyPage: (context) {
      final args = setting.arguments as ProviderReplyArgs;
      return BlocProvider<ProviderReviewsCubit>(
        create: (_) =>
            sl<ProviderReviewsCubit>(), // Inject a fresh cubit for the mutation
        child: ProviderReviewReplyScreen(args: args),
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
