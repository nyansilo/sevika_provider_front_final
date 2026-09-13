// lib/features/kyc/domain/usecases/params/submit_basic_kyc_params.dart
class SubmitBasicKycParams {
  final String nidaNumber;
  final String idFrontPath;
  final String selfiePath;

  SubmitBasicKycParams({
    required this.nidaNumber,
    required this.idFrontPath,
    required this.selfiePath,
  });
}
