// lib/features/kyc/domain/usecases/params/upgrade_to_pro_params.dart
class UpgradeToProParams {
  final String businessLicensePath;
  final String? tradeCertificatePath;
  final String? policeClearancePath;

  UpgradeToProParams({
    required this.businessLicensePath,
    this.tradeCertificatePath,
    this.policeClearancePath,
  });
}
