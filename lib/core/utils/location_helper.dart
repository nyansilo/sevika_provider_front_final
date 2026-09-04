import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../extensions/build_context_extensions.dart'; // Adjust path to your SnackBar extension

class LocationHelper {
  /// Ensures permissions are granted and returns the live high-accuracy GPS position.
  /// If permissions are denied or GPS is off, it alerts the user and returns null.
  static Future<Position?> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Check if GPS hardware is actually turned on
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (context.mounted) {
        context.showSnackBar(
          'Location services are disabled. Please turn on GPS.',
          type: SnackBarType.warning,
        );
      }
      return null;
    }

    // 2. Check App Permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (context.mounted) {
          context.showSnackBar(
            'Location permissions are required for SOS dispatch.',
            type: SnackBarType.error,
          );
        }
        return null;
      }
    }

    // 3. Handle Permanently Denied (User clicked "Don't ask again")
    if (permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        context.showSnackBar(
          'Location permissions are permanently denied. Please enable them in your phone settings.',
          type: SnackBarType.error,
        );
      }
      return null;
    }

    // 4. Permissions granted! Fetch high-accuracy coordinates.
    // 🎯 FIXED: Replaced deprecated desiredAccuracy with the new LocationSettings object
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }
}
