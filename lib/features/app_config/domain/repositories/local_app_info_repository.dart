/// 🎯 INDUSTRY PRACTICE: Abstracting device-level plugins (like package_info_plus)
/// behind an interface so the Domain layer remains pure and unit-testable.
abstract class LocalAppInfoRepository {
  Future<String> getCurrentAppVersion();
}
