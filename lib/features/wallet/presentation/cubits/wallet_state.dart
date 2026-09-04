import 'package:equatable/equatable.dart';

import '../../domain/entities/wallet_entity.dart';

abstract class WalletState extends Equatable {
  const WalletState();
  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final WalletEntity wallet;
  const WalletLoaded(this.wallet);
  @override
  List<Object?> get props => [wallet];
}

class WalletFailure extends WalletState {
  final String message;
  const WalletFailure(this.message);
  @override
  List<Object?> get props => [message];
}
