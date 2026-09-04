import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/extensions/string_extensions.dart'; // Assumes toCleanMsisdn() is here

class SupportLauncher {
  /// 💬 Safely launches WhatsApp with an optional pre-filled message.
  static Future<void> launchWhatsApp({
    required String rawNumber,
    String? message,
  }) async {
    try {
      final cleanNumber = rawNumber.toCleanMsisdn();

      final encodedMessage = message != null
          ? Uri.encodeComponent(message)
          : '';
      final urlString = encodedMessage.isNotEmpty
          ? 'https://wa.me/$cleanNumber?text=$encodedMessage'
          : 'https://wa.me/$cleanNumber';

      final url = Uri.parse(urlString);

      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        debugPrint(
          '🚨 [SupportLauncher] Could not open WhatsApp URL: $urlString',
        );
      }
    } catch (e) {
      debugPrint('🚨 [SupportLauncher] Failed to launch WhatsApp: $e');
    }
  }

  /// 📞 Safely launches the device phone dialer.
  static Future<void> launchPhoneDialer({required String rawNumber}) async {
    try {
      final cleanNumber = rawNumber.toCleanMsisdn();
      final url = Uri.parse('tel:$cleanNumber');

      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        debugPrint(
          '🚨 [SupportLauncher] Could not open phone dialer for: $rawNumber',
        );
      }
    } catch (e) {
      debugPrint('🚨 [SupportLauncher] Failed to launch phone dialer: $e');
    }
  }
}
