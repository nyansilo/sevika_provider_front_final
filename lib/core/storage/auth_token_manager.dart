import '../constants/storage_keys.dart';
import 'token_storage_service.dart';

class AuthTokenManager {
  final TokenStorageService _secureStorage;

  AuthTokenManager(this._secureStorage);

  Future<void> saveAccessToken(String token) async {
    await _secureStorage.saveData(StorageKeys.accessToken, token);
  }

  Future<void> saveRefreshToken(String token) async {
    await _secureStorage.saveData(StorageKeys.refreshToken, token);
  }

  /// Securely persists the verified user role string value
  Future<void> saveUserRole(String role) async {
    await _secureStorage.saveData(StorageKeys.userRole, role);
  }

  /// 🎯 NEW: Securely persists the user's profile data as a JSON string
  Future<void> saveCachedUser(String userJson) async {
    await _secureStorage.saveData(StorageKeys.cachedUser, userJson);
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.readData(StorageKeys.accessToken);
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.readData(StorageKeys.refreshToken);
  }

  /// Retrieves the user role to enforce app boundary controls
  Future<String?> getUserRole() async {
    return await _secureStorage.readData(StorageKeys.userRole);
  }

  /// 🎯 NEW: Retrieves the cached user profile for instant offline booting
  Future<String?> getCachedUser() async {
    return await _secureStorage.readData(StorageKeys.cachedUser);
  }

  /// Ensured all tokens and cached payloads are completely purged
  Future<void> clearTokens() async {
    await _secureStorage.removeData(StorageKeys.accessToken);
    await _secureStorage.removeData(StorageKeys.refreshToken);
    await _secureStorage.removeData(StorageKeys.userRole);
    await _secureStorage.removeData(
      StorageKeys.cachedUser,
    ); // 🎯 Clean up cached user
  }
}
