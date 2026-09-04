import 'package:package_info_plus/package_info_plus.dart';
import '../../domain/repositories/local_app_info_repository.dart';

/// 🎯 Implementation of the local info abstraction using the Flutter plugin.
class LocalAppInfoRepositoryImpl implements LocalAppInfoRepository {
  @override
  Future<String> getCurrentAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
