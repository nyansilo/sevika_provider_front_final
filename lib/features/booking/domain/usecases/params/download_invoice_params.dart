import 'package:equatable/equatable.dart';

/// 🎯 INVOICE DOWNLOAD PARAMS
/// Encapsulates the specific URL and booking reference needed to securely
/// fetch a PDF invoice from the backend.
class DownloadInvoiceParams extends Equatable {
  final String invoiceUrl;
  final String bookingReference;

  const DownloadInvoiceParams({
    required this.invoiceUrl,
    required this.bookingReference,
  });

  @override
  List<Object?> get props => [invoiceUrl, bookingReference];
}
