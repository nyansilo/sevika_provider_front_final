import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';

class AppLogger {
  const AppLogger._();

  /// Debug tracking printouts for repository lifecycle actions.
  static void debug(String message, [Object? error]) {
    if (kDebugMode) {
      dev.log('ℹ️ [DEBUG]: $message', error: error, name: 'CoreApp');
    }
  }

  /// Track warning updates that aren't critical blockages (e.g., HTTP 401 token refresh).
  static void warn(String message) {
    if (kDebugMode) {
      dev.log('⚠️ [WARNING]: $message', name: 'CoreApp');
    }
  }

  /// Logs fatal blockages directly to terminal consoles and channels metrics up to remote monitors.
  static void error(String message, Object exception, StackTrace stackTrace) {
    if (kDebugMode) {
      dev.log(
        '❌ [ERROR]: $message',
        error: exception,
        stackTrace: stackTrace,
        name: 'CoreApp',
      );
    } else {
      // Ideal integration boundary hook for third-party platforms:
      // Sentry.captureException(exception, stackTrace: stackTrace);
    }
  }
}
