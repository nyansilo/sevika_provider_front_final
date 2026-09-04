import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/params/request_withdrawal_params.dart';
import '../../domain/usecases/wallet_usecases.dart';
import 'withdrawal_state.dart';

class WithdrawalCubit extends Cubit<WithdrawalState> {
  final RequestWithdrawalUseCase requestWithdrawalUseCase;

  WithdrawalCubit(this.requestWithdrawalUseCase) : super(WithdrawalInitial());

  Future<void> submitWithdrawal(RequestWithdrawalParams params) async {
    emit(WithdrawalLoading());
    final result = await requestWithdrawalUseCase.call(params);

    result.fold(
      (failure) =>
          emit(WithdrawalFailure(failure.message ?? 'Withdrawal failed')),
      (_) => emit(WithdrawalSuccess()),
    );
  }
}
