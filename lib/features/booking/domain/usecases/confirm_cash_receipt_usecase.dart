import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/bookings_repository.dart';
import 'params/confirm_cash_receipt_params.dart';
import '../entities/booking_entity.dart';

class ConfirmCashReceiptUseCase
    implements UseCase<BookingEntity, ConfirmCashReceiptParams> {
  final BookingRepository repository;
  ConfirmCashReceiptUseCase(this.repository);

  @override
  Future<Either<AppError, BookingEntity>> call(
    ConfirmCashReceiptParams params,
  ) async {
    return await repository.confirmCashReceipt(params);
  }
}
