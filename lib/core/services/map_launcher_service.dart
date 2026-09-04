import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// 🗺️ Map Launcher Service
///
/// Intelligently launches coordinates in the device's native mapping application.
/// Uses Apple Maps on iOS and Google Maps on Android/Web.
class MapLauncherService {
  /// Launches the native map app centered on the given coordinates.
  static Future<void> launchCoordinates(
    double lat,
    double lng, {
    String? label,
  }) async {
    Uri uri;

    if (!kIsWeb && Platform.isIOS) {
      // 🍎 Apple Maps URL Scheme for iOS
      // If a label is provided, it drops a pin with that name using 'q='
      final query = label != null ? Uri.encodeComponent(label) : '$lat,$lng';
      uri = Uri.parse('http://maps.apple.com/?ll=$lat,$lng&q=$query');
    } else {
      // 🤖 Google Maps URL Scheme for Android & Web
      final query = label != null ? Uri.encodeComponent(label) : '$lat,$lng';
      uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
    }

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Could not launch mapping application.');
      }
    } catch (e) {
      debugPrint('Failed to launch map: $e');
    }
  }
}
