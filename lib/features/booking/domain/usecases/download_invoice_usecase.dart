import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/bookings_repository.dart';
import 'params/download_invoice_params.dart';

/// 👨‍🔧 DOWNLOAD INVOICE USE CASE (PROVIDER)
///
/// Allows a Provider to download the official PDF receipt/invoice for a completed job.
/// Highly useful for providers needing to track their payouts, platform commission deductions,
/// and cash collections for their own tax and accounting purposes.
class DownloadInvoiceUseCase implements UseCase<String, DownloadInvoiceParams> {
  final BookingRepository repository;

  DownloadInvoiceUseCase(this.repository);

  @override
  Future<Either<AppError, String>> call(DownloadInvoiceParams params) async {
    // 🎯 Returns the absolute local file path where the PDF was safely saved on the device
    return await repository.downloadInvoice(params);
  }
}
