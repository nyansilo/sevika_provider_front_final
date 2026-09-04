import 'package:equatable/equatable.dart';

class WalletEntity extends Equatable {
  final String walletId;
  final double availableBalance;
  final double heldEscrowBalance;
  final String currency;
  final bool isFrozen;
  final DateTime? lastUpdated;

  const WalletEntity({
    required this.walletId,
    required this.availableBalance,
    required this.heldEscrowBalance,
    required this.currency,
    required this.isFrozen,
    this.lastUpdated,
  });

  @override
  List<Object?> get props => [walletId, availableBalance, heldEscrowBalance];
}
