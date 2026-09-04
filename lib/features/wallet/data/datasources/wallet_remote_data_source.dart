import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/base_remote_data_source.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/usecases/params/pagination_params.dart';
import '../../domain/usecases/params/request_withdrawal_params.dart';
import '../models/wallet_model.dart';
import '../models/wallet_transactions_response_model.dart';

abstract class WalletRemoteDataSource {
  Future<WalletModel> fetchWalletBalance();
  Future<WalletTransactionsResponseModel> fetchTransactions(
    PaginationParams params,
  );
  Future<void> requestWithdrawal(RequestWithdrawalParams params);
}

class WalletRemoteDataSourceImpl extends BaseRemoteDataSource
    implements WalletRemoteDataSource {
  final DioClient dioClient;
  WalletRemoteDataSourceImpl(this.dioClient);

  @override
  Future<WalletModel> fetchWalletBalance() async {
    final response = await dioClient.get(
      '${ApiEndpoints.baseUrl}/provider/wallet',
    );
    return WalletModel.fromJson(response.data['data']);
  }

  @override
  Future<WalletTransactionsResponseModel> fetchTransactions(
    PaginationParams params,
  ) async {
    final response = await dioClient.get(
      '${ApiEndpoints.baseUrl}/provider/wallet/transactions',
      queryParameters: params.toQueryParameters(),
    );

    // 🧠 Utilizing your exact BaseRemoteDataSource method!
    final rawList = extractDataList(
      response.data['data'],
      customKey: 'transactions',
    );
    return WalletTransactionsResponseModel.fromJson(
      response.data['data'],
      rawList,
    );
  }

  @override
  Future<void> requestWithdrawal(RequestWithdrawalParams params) async {
    await dioClient.post(
      '${ApiEndpoints.baseUrl}/provider/withdrawals/request',
      data: params.toJson(),
    );
  }
}
