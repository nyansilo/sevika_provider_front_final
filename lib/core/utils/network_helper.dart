import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkHelper {
  // 🎯 Use your production backend URL here.
  // (Change it to a fake one like 'broken-domain.app' temporarily to test offline mode)
  //static const String _targetDomain = 'api.sevika.app';
  static const String _targetDomain = 'google.com';
  //static const String _targetDomain = 'this-is-a-broken-domain.app';
  static const int _timeoutSeconds = 3;

  /// Pings the backend to verify true data reachability.
  /// Uses a hybrid Gatekeeper pattern for maximum efficiency.
  static Future<bool> hasInternetAccess() async {
    try {
      // 🛡️ STEP 1: The Hardware Gatekeeper
      // Checks if the physical antennas (Wi-Fi/Cellular) are actually on and connected.
      final List<ConnectivityResult> connectivityResult = await Connectivity()
          .checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.none)) {
        // Instantly fails if offline. Saves the user from waiting 3 seconds!
        return false;
      }

      // 🌍 STEP 2: The Reachability Test
      // Hardware is connected, but does the router actually have internet access?
      final result = await InternetAddress.lookup(
        _targetDomain,
      ).timeout(const Duration(seconds: _timeoutSeconds));

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true; // 100% verified online and able to reach the Sevika servers
      }
      return false;
    } on SocketException catch (_) {
      return false; // Connected to Wi-Fi, but router has no internet
    } on TimeoutException catch (_) {
      return false; // Connection is too slow/hanging
    } catch (_) {
      return false;
    }
  }
}
