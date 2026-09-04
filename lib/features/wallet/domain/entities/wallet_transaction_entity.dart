import 'package:equatable/equatable.dart';

class WalletTransactionEntity extends Equatable {
  final String transactionId;
  final double amount;
  final String type; // 'credit' or 'debit'
  final String? action;
  final String? bookingReference;
  final String description;
  final String currency;
  final DateTime? createdAt;

  const WalletTransactionEntity({
    required this.transactionId,
    required this.amount,
    required this.type,
    this.action,
    this.bookingReference,
    required this.description,
    required this.currency,
    this.createdAt,
  });

  @override
  List<Object?> get props => [transactionId, amount, type, bookingReference];
}
