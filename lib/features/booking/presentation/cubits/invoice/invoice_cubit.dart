import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/params/download_invoice_params.dart';
import '../../../domain/usecases/download_invoice_usecase.dart';
import 'invoice_state.dart';

// --- CUBIT ---
class InvoiceCubit extends Cubit<InvoiceState> {
  final DownloadInvoiceUseCase downloadInvoiceUseCase;

  InvoiceCubit({required this.downloadInvoiceUseCase})
    : super(const InvoiceInitial());

  Future<void> downloadReceipt(
    String invoiceUrl,
    String bookingReference,
  ) async {
    emit(const InvoiceDownloading());

    final result = await downloadInvoiceUseCase.call(
      DownloadInvoiceParams(
        invoiceUrl: invoiceUrl,
        bookingReference: bookingReference,
      ),
    );

    if (isClosed) return;

    result.fold(
      (error) => emit(InvoiceDownloadFailure(error)),
      (filePath) => emit(InvoiceDownloadSuccess(filePath)),
    );
  }
}
