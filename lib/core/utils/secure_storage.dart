import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();

  factory SecureStorage() {
    return _instance;
  }

  SecureStorage._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Save Data
  Future<void> saveData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Read Data
  Future<String?> readData(String key) async {
    return await _storage.read(key: key);
  }

  /// Remove Data
  Future<void> removeData(String key) async {
    await _storage.delete(key: key);
  }

  /// Clear All
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
