import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/provider_review_response_entity.dart';
import '../repositories/provider_review_repository.dart';
import 'params/get_provider_reviews_params.dart';
import 'params/reply_to_review_params.dart';

class GetProviderReviewsUseCase
    implements UseCase<ProviderReviewResponseEntity, GetProviderReviewsParams> {
  final ProviderReviewRepository repository;

  GetProviderReviewsUseCase(this.repository);

  @override
  Future<Either<AppError, ProviderReviewResponseEntity>> call(
    GetProviderReviewsParams params,
  ) async {
    return await repository.getReviews(params);
  }
}

class ReplyToReviewUseCase implements UseCase<void, ReplyToReviewParams> {
  final ProviderReviewRepository repository;

  ReplyToReviewUseCase(this.repository);

  @override
  Future<Either<AppError, void>> call(ReplyToReviewParams params) async {
    return await repository.replyToReview(params);
  }
}
