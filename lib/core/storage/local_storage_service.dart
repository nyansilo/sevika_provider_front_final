import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageService {
  String? getString(String key);
  Future<bool> setString(String key, String value);

  // 🎯 NEW: Boolean Support
  bool? getBool(String key);
  Future<bool> setBool(String key, bool value);

  Future<bool> remove(String key);
  Future<bool> clear();
}

class LocalStorageServiceImpl implements LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageServiceImpl(this._prefs);

  @override
  String? getString(String key) => _prefs.getString(key);

  @override
  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  @override
  bool? getBool(String key) => _prefs.getBool(key);

  @override
  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);

  @override
  Future<bool> remove(String key) => _prefs.remove(key);

  @override
  Future<bool> clear() => _prefs.clear();
}
