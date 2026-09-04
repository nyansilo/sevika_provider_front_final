import 'dart:io';

import 'package:flutter/foundation.dart';

// 🎯 IMPORT THE SECRETS VAULT
import '../config/app_secrets.dart';

/// Centralized endpoint engine for the Home Services App ecosystem.
class ApiEndpoints {
  const ApiEndpoints._();

  /// ==========================================
  /// ENVIRONMENT CONFIGURATION MANAGEMENT
  /// ==========================================

  // 🎯 CHANGE THIS TO TRUE FOR ULTRA-FAST LOCAL TESTING
  // Set to false only when testing on a completely remote device outside your WiFi network.
  static const bool useLocalLoopback = true;

  /// 🎯 SMART HOST RESOLVER
  /// Determines host IP based on environment parameters:
  /// Determines host IP based on environment parameters:
  /// 1. Uses [LOCAL_IP] from secrets.env.json if provided (Physical Device over Wi-Fi)
  /// 2. Uses '10.0.2.2' if running on Android Emulator
  /// 3. Fallback to '127.0.0.1' for iOS Simulator / Web / Desktop
  static String get _devHost {
    if (AppSecrets.localIp.isNotEmpty) return AppSecrets.localIp;
    if (!kIsWeb && Platform.isAndroid) return '10.0.2.2';
    return '127.0.0.1';
  }

  static String get _devBaseUrl => 'http://$_devHost:8000/api/v1';
  static const String _stageBaseUrl =
      'https://groggily-animating-reward.ngrok-free.dev/api/v1';
  static const String _prodBaseUrl = 'https://api.homeservices.co.tz/api/v1';

  /// Resolves the absolute server boundary dynamically based on environmental contexts.
  static String get baseUrl {
    if (kReleaseMode) return _prodBaseUrl;

    switch (AppSecrets.environment.toLowerCase()) {
      case 'production':
      case 'prod':
        return _prodBaseUrl;
      case 'staging':
      case 'stage':
        // 🎯 Route local requests directly to your Node Proxy (8001) using active dev host
        return useLocalLoopback
            ? 'http://$_devHost:8001/api/v1'
            : _stageBaseUrl;
      case 'development':
      case 'dev':
      default:
        return _devBaseUrl;
    }
  }

  /// ==========================================
  /// REAL-TIME WEBSOCKETS & BROADCASTING CORES
  /// ==========================================
  static const String broadcastingAuth = '/broadcasting/auth';

  static final String wsScheme = _resolveWsScheme();
  static final String wsHost = _resolveWsHost();
  static final int? wsPort = _resolveWsPort();

  static String _resolveWsScheme() {
    if (useLocalLoopback &&
        AppSecrets.environment.toLowerCase().startsWith('stag')) {
      return 'ws';
    }
    if (baseUrl.trim().toLowerCase().startsWith('https://')) {
      return 'wss';
    }
    return 'ws';
  }

  static String _resolveWsHost() {
    switch (AppSecrets.environment.toLowerCase()) {
      case 'production':
      case 'prod':
        return _prodBaseUrl.replaceFirst('https://', '').split('/').first;

      case 'staging':
      case 'stage':
        if (useLocalLoopback) {
          return _devHost; // Hits proxy directly using active host
        }
        return _stageBaseUrl
            .replaceFirst('https://', '')
            .replaceFirst('http://', '')
            .split('/')
            .first;

      case 'development':
      case 'dev':
      default:
        return _devHost; // Auto-routes to 10.0.2.2, 127.0.0.1, or localIp
    }
  }

  static int? _resolveWsPort() {
    if (AppSecrets.environment.toLowerCase().startsWith('stag') &&
        useLocalLoopback) {
      return 8001;
    }
    if (baseUrl.trim().toLowerCase().startsWith('https://')) {
      return null;
    }
    return 8080;
  }

  /// ==========================================
  /// DYNAMIC BACKEND URL SANITIZER
  /// ==========================================
  /// 🎯 Pass any absolute URL returned by Laravel (like Invoice URLs or Image URLs) here.
  /// Automatically fixes the "Localhost Trap" for Android emulators and physical devices.
  static String sanitizeBackendUrl(String rawUrl) {
    if (kReleaseMode || kIsWeb) return rawUrl;

    final targetHost = _devHost;

    // 1. The Localhost Trap
    if (rawUrl.contains('localhost')) {
      return rawUrl.replaceAll('localhost', targetHost);
    }
    if (rawUrl.contains('127.0.0.1')) {
      return rawUrl.replaceAll('127.0.0.1', targetHost);
    }

    // 2. THE NGROK BYPASS
    if (rawUrl.contains('groggily-animating-reward.ngrok-free.dev')) {
      return rawUrl.replaceAll(
        'https://groggily-animating-reward.ngrok-free.dev',
        'http://$targetHost:8000',
      );
    }

    return rawUrl;
  }

  /// ==========================================
  /// SYSTEM STATIC METADATA SEGMENTS
  /// ==========================================
  static const String locationsBoundaries = '/locations/boundaries';

  /// ==========================================
  /// AUTHENTICATION SEGMENT CORES
  /// ==========================================
  static const String login = '/provider/auth/login';
  static const String socialLogin = '/provider/auth/login/social';
  static const String completeSocialRegistration =
      '/provider/auth/complete/social/registration';
  static const String updatePhoneNumber = '/provider/auth/update/phone';
  static const String register = '/provider/auth/register';
  static const String verifyOtp = '/provider/auth/otp/verify';
  static const String sendOtp = '/provider/auth/otp/send';
  static const String changePassword = '/provider/auth/change-password';
  static const String forgotPassword = '/provider/auth/password/forgot';
  static const String resetPassword = '/provider/auth/password/reset';
  static const String refreshToken = '/provider/auth/token/refresh';
  static const String logout = '/provider/auth/logout';
  static const String deleteAccount = '/provider/auth/delete/account';
  static const String updateProfile = '/provider/profile';
  static const String profile = '/provider/profile';

  /// ==========================================
  /// provider PROFILE & ADDRESS SEGMENTS
  /// ==========================================
  static const String addresses = '/provider/addresses';

  /// ==========================================
  /// CUSTOM JOBS & OPEN MARKETPLACE BIDS & EMERGENCY DISPATCH
  /// ==========================================
  static const String providerOpenJobs = '/provider/jobs/explore';
  static const String providerEmergencies = '/provider/emergencies';
  static const String providerPlaceBid = '/provider/jobs/bids';

  /// ==========================================
  /// DIGITAL WALLET & TRANSACTION SEGMENTS
  /// ==========================================
  static const String walletBalance = '/provider/wallet/balance';
  static const String transactionLedger = '/provider/wallet/transactions';
  static const String initiateTopUp = '/provider/wallet/topup/initialize';
  static const String verifyTransaction = '/provider/wallet/topup/verify/';
  static const String savedPaymentMethods = '/provider/saved-payment-methods';
  static const String verifyIntentPayment =
      '/provider/saved-payment-methods/verify-intent';
  static const String validatePayment = '/provider/payments/validate';

  /// ==========================================
  /// NOTIFICATION INSTRUMENTS
  /// ==========================================
  static const String providerNotifications = '/provider/notifications';
  static const String updateFcmToken = '/provider/fcm-token';

  /// ==========================================
  /// SERVICES & BOOKINGS & PAYMENTS SEGMENTS
  /// ==========================================
  static const String serviceCategories = '/services/categories';
  static const String providerList = '/services/providers';
  static const String activeBookings = '/provider/bookings/active';
  static const String bookingHistory = '/provider/bookings';
  static const String createBooking = '/provider/bookings';
  static const String providerBookings = '/provider/bookings';
  static const String cancelBooking = '/provider/bookings';
  static const String downloadBookingInvoice = '/provider/bookings';
  static const String processPayment = '/provider/payments';
  static const String paymentHistory = '/provider/payments';

  static const String homeBanners = '/provider/home-banners';
  static const String appVersions = '/provider/app-configs';

  /// ==========================================
  /// SERVICE CATALOG DOMAIN SEGMENTS
  /// ==========================================
  static const String providerServices = '/provider/services';
  static const String popularServices = '/services/popular';
  static const String recommendedServices = '/services/recommended';

  /// ==========================================
  /// PROFESSIONALS DOMAIN SEGMENTS
  /// ==========================================
  static const String homeFeaturedProfessionals =
      '/provider/professionals/home-featured';
  static const String featuredProfessionals =
      '/provider/professionals/featured';
  static const String professionalDetails = '/provider/professionals';

  /// ==========================================
  /// SAVED MARKETPLACE FAVORITES SEGMENTS
  /// ==========================================
  static const String providerFavorites = '/provider/favorites';
  static const String toggleFavorite = '/provider/favorites/toggle';

  /// ==========================================
  /// WAITLISTS & CALLS & CHATS
  /// ==========================================
  static const String waitlists = '/provider/waitlists';
  static const String chatRooms = '/chats/rooms';
  static const String initiateCall = '/provider/calls/initiate';

  /// ==========================================
  /// REWARDS & WALLET SEGMENTS
  /// ==========================================
  static const String providerRewards = '/provider/rewards';
  static const String providerRewardsWallet = '/provider/rewards/wallet';
  static const String providerWallet = '/provider/wallet';
}
