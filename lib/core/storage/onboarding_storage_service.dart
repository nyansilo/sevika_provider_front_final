import '../constants/storage_keys.dart';
import 'local_storage_service.dart'; // This is your base SharedPreferences interface

class OnboardingStorageService {
  final LocalStorageService _prefs;

  OnboardingStorageService(this._prefs);

  Future<void> setOnboardingDone() async {
    await _prefs.setString(StorageKeys.onboardingDone, 'true');
    // Note: If your LocalStorageService has a setBool method, use that instead!
  }

  bool isOnboardingDone() {
    // If saving as string, parse it. If using a custom getBool on your interface, call that directly.
    final value = _prefs.getString(StorageKeys.onboardingDone);
    return value == 'true';
  }
}
