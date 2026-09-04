import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  /// 📡 Check if a specific permission is granted
  Future<bool> isGranted(Permission permission) async {
    if (permission == Permission.storage) {
      // Android/iOS have fragmented storage permissions, so we safely check both
      return await Permission.storage.isGranted ||
          await Permission.photos.isGranted;
    }
    return await permission.isGranted;
  }

  /// 🚀 Request a permission. Returns true if granted, false if denied.
  Future<bool> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  /// 🛑 Check if the permission is permanently denied (OS blocked the popup)
  Future<bool> isPermanentlyDenied(Permission permission) async {
    return await permission.isPermanentlyDenied;
  }

  /// ⚙️ Opens the Native OS Settings page for this app
  Future<void> openSettings() async {
    await openAppSettings();
  }
}
