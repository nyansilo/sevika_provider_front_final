import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs _instance = SharedPrefs._internal();

  late SharedPreferences _prefs;

  SharedPrefs._internal();

  factory SharedPrefs() => _instance;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Force disk sync
  Future<void> commit() async {
    await _prefs.reload();
  }

  /// SETTERS

  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);

  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);

  Future<bool> setDouble(String key, double value) =>
      _prefs.setDouble(key, value);

  Future<bool> setStringList(String key, List<String> value) =>
      _prefs.setStringList(key, value);

  Future<void> setStringAndSync(String key, String value) async {
    await _prefs.setString(key, value);

    await _prefs.reload();
  }

  /// GETTERS

  String? getString(String key) => _prefs.getString(key);

  int? getInt(String key) => _prefs.getInt(key);

  bool? getBool(String key) => _prefs.getBool(key);

  double? getDouble(String key) => _prefs.getDouble(key);

  List<String>? getStringList(String key) => _prefs.getStringList(key);

  /// REMOVE

  Future<bool> remove(String key) => _prefs.remove(key);

  Future<bool> clear() => _prefs.clear();

  bool containsKey(String key) => _prefs.containsKey(key);
}
