import '../../domain/entities/wallet_entity.dart';

class WalletModel extends WalletEntity {
  const WalletModel({
    required super.walletId,
    required super.availableBalance,
    required super.heldEscrowBalance,
    required super.currency,
    required super.isFrozen,
    super.lastUpdated,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      walletId: json['walletId']?.toString() ?? '',
      availableBalance: (json['availableBalance'] as num?)?.toDouble() ?? 0.0,
      heldEscrowBalance: (json['heldEscrowBalance'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency']?.toString() ?? 'TZS',
      isFrozen: json['isFrozen'] == true,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.tryParse(json['lastUpdated'])
          : null,
    );
  }
}
