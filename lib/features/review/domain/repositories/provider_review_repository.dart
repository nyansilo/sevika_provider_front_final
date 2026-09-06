import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../entities/provider_review_response_entity.dart';
import '../usecases/params/get_provider_reviews_params.dart';
import '../usecases/params/reply_to_review_params.dart';

abstract class ProviderReviewRepository {
  Future<Either<AppError, ProviderReviewResponseEntity>> getReviews(
    GetProviderReviewsParams params,
  );
  Future<Either<AppError, void>> replyToReview(ReplyToReviewParams params);
}
