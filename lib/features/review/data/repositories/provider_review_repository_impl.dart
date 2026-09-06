import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_handler.dart';
import '../../domain/entities/provider_review_response_entity.dart';
import '../../domain/repositories/provider_review_repository.dart';
import '../../domain/usecases/params/get_provider_reviews_params.dart';
import '../../domain/usecases/params/reply_to_review_params.dart';
import '../datasources/provider_review_remote_data_source.dart';

class ProviderReviewRepositoryImpl implements ProviderReviewRepository {
  final ProviderReviewRemoteDataSource remoteDataSource;

  ProviderReviewRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppError, ProviderReviewResponseEntity>> getReviews(
    GetProviderReviewsParams params,
  ) async {
    try {
      final responseModel = await remoteDataSource.fetchReviews(params);
      return Right(responseModel);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<AppError, void>> replyToReview(
    ReplyToReviewParams params,
  ) async {
    try {
      await remoteDataSource.replyToReview(params);
      return const Right(null);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }
}
