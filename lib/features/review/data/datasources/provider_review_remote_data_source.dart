import '../../../../core/network/dio_client.dart';
import '../../../../core/network/base_remote_data_source.dart';
import '../../domain/usecases/params/get_provider_reviews_params.dart';
import '../../domain/usecases/params/reply_to_review_params.dart';
import '../models/provider_review_response_model.dart';

abstract class ProviderReviewRemoteDataSource {
  Future<ProviderReviewResponseModel> fetchReviews(
    GetProviderReviewsParams params,
  );
  Future<void> replyToReview(ReplyToReviewParams params);
}

class ProviderReviewRemoteDataSourceImpl extends BaseRemoteDataSource
    implements ProviderReviewRemoteDataSource {
  final DioClient dioClient;

  ProviderReviewRemoteDataSourceImpl(this.dioClient);

  @override
  Future<ProviderReviewResponseModel> fetchReviews(
    GetProviderReviewsParams params,
  ) async {
    final response = await dioClient.get(
      '/provider/reviews',
      queryParameters: params.toQueryParameters(),
    );

    final responseData = response.data as Map<String, dynamic>;

    // Safely un-nest if wrapped in "data: { reviews: [...] }"
    final Map<String, dynamic> innerData =
        responseData['data'] is Map<String, dynamic>
        ? responseData['data']
        : responseData;

    final extractedList = extractDataList(innerData, customKey: 'reviews');

    return ProviderReviewResponseModel.fromMap(responseData, extractedList);
  }

  @override
  Future<void> replyToReview(ReplyToReviewParams params) async {
    // Assuming POST route for reply based on standard action routing
    await dioClient.post(
      '/provider/reviews/${params.reviewId}/reply',
      data: params.toMap(),
    );
  }
}
