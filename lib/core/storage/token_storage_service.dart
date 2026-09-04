import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TokenStorageService {
  Future<void> saveData(String key, String value);
  Future<String?> readData(String key);
  Future<void> removeData(String key);
  Future<void> clearAll();
}

class TokenStorageServiceImpl implements TokenStorageService {
  final FlutterSecureStorage _storage;

  TokenStorageServiceImpl(this._storage);

  @override
  Future<void> saveData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<String?> readData(String key) async {
    return await _storage.read(key: key);
  }

  @override
  Future<void> removeData(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
