import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';

import '../../domain/usecases/wallet_usecases.dart';
import 'wallet_state.dart'; // Adjust path to GetWalletBalanceUseCase

class WalletCubit extends Cubit<WalletState> {
  final GetWalletBalanceUseCase getWalletBalanceUseCase;

  WalletCubit(this.getWalletBalanceUseCase) : super(WalletInitial());

  Future<void> fetchWallet() async {
    emit(WalletLoading());
    final result = await getWalletBalanceUseCase.call(NoParams());

    result.fold(
      (failure) =>
          emit(WalletFailure(failure.message ?? 'Failed to load wallet')),
      (wallet) => emit(WalletLoaded(wallet)),
    );
  }
}
