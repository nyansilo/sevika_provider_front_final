import '../../../booking/data/models/pagination_model.dart';
import '../../domain/entities/wallet_transaction_response_entity.dart';
import 'wallet_transaction_model.dart';

class WalletTransactionsResponseModel extends WalletTransactionsResponseEntity {
  const WalletTransactionsResponseModel({
    required super.transactions,
    required super.pagination,
  });

  factory WalletTransactionsResponseModel.fromJson(
    Map<String, dynamic> json,
    List<Map<String, dynamic>> rawList,
  ) {
    return WalletTransactionsResponseModel(
      transactions: rawList
          .map((e) => WalletTransactionModel.fromJson(e))
          .toList(),
      pagination: PaginationModel.fromJson(
        json['pagination'] is Map
            ? Map<String, dynamic>.from(json['pagination'])
            : {},
      ).toEntity(),
    );
  }
}
