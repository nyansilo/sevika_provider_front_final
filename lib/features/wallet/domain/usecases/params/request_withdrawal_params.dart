import 'package:equatable/equatable.dart';

import '../../enums/withdrawal_channel.dart';

class RequestWithdrawalParams extends Equatable {
  final double amount;
  final WithdrawalChannel channel;
  final String accountNumber;
  final String accountName;

  const RequestWithdrawalParams({
    required this.amount,
    required this.channel,
    required this.accountNumber,
    required this.accountName,
  });

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "channel": channel.code, // Sends 'm_pesa' to Laravel
    "account_number": accountNumber,
    "account_name": accountName,
  };

  @override
  List<Object?> get props => [amount, channel, accountNumber, accountName];
}
