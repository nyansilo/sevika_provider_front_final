import '../../domain/entities/wallet_transaction_entity.dart';

class WalletTransactionModel extends WalletTransactionEntity {
  const WalletTransactionModel({
    required super.transactionId,
    required super.amount,
    required super.type,
    super.action,
    super.bookingReference,
    required super.description,
    required super.currency,
    super.createdAt,
  });

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    return WalletTransactionModel(
      transactionId: json['transactionId']?.toString() ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      type: json['type']?.toString() ?? 'debit',
      action: json['action']?.toString(),
      bookingReference: json['bookingReference']
          ?.toString(), // Handled perfectly by backend resource
      description: json['description']?.toString() ?? '',
      currency: json['currency']?.toString() ?? 'TSh',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }
}
