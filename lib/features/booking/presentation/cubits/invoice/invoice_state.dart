import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_error.dart';

// --- STATES ---
abstract class InvoiceState extends Equatable {
  const InvoiceState();
  @override
  List<Object?> get props => [];
}

class InvoiceInitial extends InvoiceState {
  const InvoiceInitial();
}

class InvoiceDownloading extends InvoiceState {
  const InvoiceDownloading();
}

class InvoiceDownloadSuccess extends InvoiceState {
  final String filePath;
  const InvoiceDownloadSuccess(this.filePath);

  @override
  List<Object?> get props => [filePath];
}

class InvoiceDownloadFailure extends InvoiceState {
  final AppError error;
  const InvoiceDownloadFailure(this.error);

  @override
  List<Object?> get props => [error];
}
