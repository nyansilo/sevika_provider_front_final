import 'package:flutter/foundation.dart';

/// Exhaustive immutable security vault for the Home Services App ecosystem.
///
/// Intercepts configuration states directly from the target binary layer,
/// separating keys dynamically by execution context (Dev vs. Prod) and client platform (Android vs. iOS).
class AppSecrets {
  const AppSecrets._();

  /// ==========================================
  /// INTERNAL ENVIRONMENT FLAG INTERCEPTORS
  /// ==========================================
  static const String environment = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'development',
  );

  // 🎯 READS LOCAL MAC IP FROM secrets.env.json FOR PHYSICAL DEVICES
  // Add "LOCAL_IP": "192.168.1.15" to secrets.env.json when using a real phone.
  static const String localIp = String.fromEnvironment(
    'LOCAL_IP',
    defaultValue: '',
  );

  // Centralized App Key for the Laravel Reverb engine configuration
  static const String reverbKey = String.fromEnvironment(
    'REVERB_APP_KEY',
    defaultValue: 'i6az9ouywfabe6drpgoq',
  );

  // 🎯 MAPBOX ACCESS TOKEN
  static const String mapboxAccessToken = String.fromEnvironment(
    'MAPBOX_ACCESS_TOKEN',
    defaultValue: '',
  );

  // SMS Gateway Pipeline Injections
  static const String _smsKeyDev = String.fromEnvironment('SMS_API_KEY_DEV');
  static const String _smsKeyProd = String.fromEnvironment('SMS_API_KEY_PROD');
  static const String smsSenderId = String.fromEnvironment(
    'SMS_SENDER_ID',
    defaultValue: 'HOMESVC', // Merged from your ApiEndpoints
  );

  // Payment Gateway Aggregator Injections
  static const String _paymentVendorDev = String.fromEnvironment(
    'PAYMENT_VENDOR_ID_DEV',
  );
  static const String _paymentVendorProd = String.fromEnvironment(
    'PAYMENT_VENDOR_ID_PROD',
  );
  static const String _paymentSecretDev = String.fromEnvironment(
    'PAYMENT_SECRET_TOKEN_DEV',
  );
  static const String _paymentSecretProd = String.fromEnvironment(
    'PAYMENT_SECRET_TOKEN_PROD',
  );

  // Maps Infrastructure Injections
  static const String _mapsAndroid = String.fromEnvironment(
    'MAPS_API_KEY_ANDROID',
  );
  static const String _mapsIos = String.fromEnvironment('MAPS_API_KEY_IOS');

  // Push Notification Signal Injections
  static const String _pushIdDev = String.fromEnvironment('PUSH_APP_ID_DEV');
  static const String _pushIdProd = String.fromEnvironment('PUSH_APP_ID_PROD');

  // Telemetry Performance Injections
  static const String sentryDsn = String.fromEnvironment('SENTRY_DSN_PROD');

  /// ==========================================
  /// PUBLIC SECURE RESOLVER ROUTERS
  /// ==========================================

  // 🎯 MAPBOX STYLE URL
  static String get mapboxStyleUrl =>
      'https://api.mapbox.com/styles/v1/mapbox/streets-v12?access_token=$mapboxAccessToken';

  /// Resolves target verification SMS pipeline authentication keys.
  static String get smsApiKey {
    if (kReleaseMode) {
      _assertKeyNotEmpty(_smsKeyProd, 'PRODUCTION_SMS_API_KEY');
      return _smsKeyProd;
    }
    return _smsKeyDev.isNotEmpty ? _smsKeyDev : 'mock_dev_sms_key';
  }

  /// Resolves the payment integration identification parameter.
  static String get paymentVendorId {
    if (kReleaseMode) {
      _assertKeyNotEmpty(_paymentVendorProd, 'PRODUCTION_PAYMENT_VENDOR_ID');
      return _paymentVendorProd;
    }
    return _paymentVendorDev.isNotEmpty ? _paymentVendorDev : 'mock_dev_vendor';
  }

  /// Resolves the payment signature secret token safely used to compute HMAC authentication hashes.
  static String get paymentSecretToken {
    if (kReleaseMode) {
      _assertKeyNotEmpty(_paymentSecretProd, 'PRODUCTION_PAYMENT_SECRET_TOKEN');
      return _paymentSecretProd;
    }
    return _paymentSecretDev.isNotEmpty
        ? _paymentSecretDev
        : 'mock_dev_secret_token';
  }

  /// Resolves the specific Google Maps API token based on active platform runtime compilation.
  static String get mapsApiKey {
    if (defaultTargetPlatform == TargetPlatform.android) {
      _assertKeyNotEmpty(_mapsAndroid, 'MAPS_API_KEY_ANDROID');
      return _mapsAndroid;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      _assertKeyNotEmpty(_mapsIos, 'MAPS_API_KEY_IOS');
      return _mapsIos;
    }
    return '';
  }

  /// Resolves targeted push notification channel reference identifications.
  static String get pushAppId {
    if (kReleaseMode) {
      _assertKeyNotEmpty(_pushIdProd, 'PRODUCTION_PUSH_APP_ID');
      return _pushIdProd;
    }
    return _pushIdDev.isNotEmpty ? _pushIdDev : 'mock_dev_push_id';
  }

  /// ==========================================
  /// DEFENSIVE STRUCTURAL INTEGRITY UTILITIES
  /// ==========================================
  static void _assertKeyNotEmpty(String key, String keyIdentifier) {
    if (key.isEmpty) {
      throw StateError(
        'CRITICAL ARTIFACT ERROR: The initialization parameter "$keyIdentifier" '
        'is completely blank inside your compilation secret matrix file configuration layer.',
      );
    }
  }
}
