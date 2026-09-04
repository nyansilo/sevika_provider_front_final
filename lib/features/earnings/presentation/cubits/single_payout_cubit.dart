import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/earnings_usecases.dart';
import 'single_payout_state.dart';

class SinglePayoutCubit extends Cubit<SinglePayoutState> {
  final GetSinglePayoutUseCase getSinglePayoutUseCase;

  SinglePayoutCubit(this.getSinglePayoutUseCase) : super(SinglePayoutInitial());

  Future<void> fetchPayoutDetails(String payoutId) async {
    emit(SinglePayoutLoading());
    final result = await getSinglePayoutUseCase.call(payoutId);

    result.fold(
      (failure) => emit(
        SinglePayoutFailure(failure.message ?? 'Failed to load payout details'),
      ),
      (payout) => emit(SinglePayoutLoaded(payout)),
    );
  }
}
