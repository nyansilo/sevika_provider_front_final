import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

/// 📦 Data Transfer Object for Location Results
class LocationData {
  final double latitude;
  final double longitude;
  final String addressLabel;

  LocationData({
    required this.latitude,
    required this.longitude,
    required this.addressLabel,
  });
}

/// 🌍 Location Service
///
/// Handles native GPS hardware permissions, satellite fixes, and
/// reverse-geocoding (turning coordinates into street addresses).
class LocationService {
  // 🎯 INSTANTIATE GEOCODING: Required for geocoding v5.0.0+
  final Geocoding _geocoding = Geocoding();

  /// Requests permissions and fetches the current location with a human-readable address.
  Future<LocationData> getCurrentLocationWithAddress() async {
    // 1. 🛡️ CHECK HARDWARE: Ensure GPS is actually turned on in phone settings
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled. Please turn on GPS.');
    }

    // 2. 🛡️ CHECK PERMISSIONS: Ensure the user allowed the app to access location
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions were denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permissions are permanently denied in settings.',
      );
    }

    // 3. 🛰️ GET SATELLITE FIX: Fetch exact high-accuracy coordinates using LocationSettings
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    // 4. 🗺️ REVERSE GEOCODE: Turn Lat/Lng into a readable street name
    String humanReadableLabel = 'Shared Location';
    try {
      // 🎯 FIX: Using the v5+ Geocoding instance method `placemarkFromCoordinates`
      List<Placemark> placemarks = await _geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        // Combines Street and City (e.g., "Kijitonyama, Dar es Salaam")
        humanReadableLabel = [
          place.street,
          place.locality,
        ].where((e) => e != null && e.isNotEmpty).join(', ');

        if (humanReadableLabel.isEmpty) {
          humanReadableLabel = 'Shared Location';
        }
      }
    } catch (e) {
      // Geocoding can fail if the network drops, but we still have the raw coordinates.
      debugPrint('Geocoding failed, falling back to default label: $e');
    }

    return LocationData(
      latitude: position.latitude,
      longitude: position.longitude,
      addressLabel: humanReadableLabel,
    );
  }
}
