import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/provider_review_item_entity.dart';

import '../../domain/usecases/params/get_provider_reviews_params.dart';
import '../../domain/usecases/params/reply_to_review_params.dart';

import '../../domain/usecases/reviews_usecase.dart';
import 'provider_reviews_state.dart';

class ProviderReviewsCubit extends Cubit<ProviderReviewsState> {
  final GetProviderReviewsUseCase getReviewsUseCase;
  final ReplyToReviewUseCase replyToReviewUseCase;

  ProviderReviewsCubit({
    required this.getReviewsUseCase,
    required this.replyToReviewUseCase,
  }) : super(const ProviderReviewsInitial());

  Future<void> loadReviews() async {
    emit(const ProviderReviewsLoading());
    final result = await getReviewsUseCase.call(
      const GetProviderReviewsParams(page: 1),
    );

    if (isClosed) return;

    result.fold(
      (error) => emit(ProviderReviewsLoadFailure(error: error)),
      (response) => emit(
        ProviderReviewsLoadSuccess(
          reviews: response.reviews,
          metrics: response.metrics,
          pagination: response.pagination,
        ),
      ),
    );
  }

  Future<void> loadNextPage() async {
    final currentState = state;
    if (currentState is! ProviderReviewsLoadSuccess) return;
    if (currentState.isMoreLoading || !currentState.pagination.hasMore) return;

    emit(currentState.copyWith(isMoreLoading: true));
    final nextPage = currentState.pagination.currentPage + 1;

    final result = await getReviewsUseCase.call(
      GetProviderReviewsParams(page: nextPage),
    );

    if (isClosed) return;

    result.fold((error) => emit(currentState.copyWith(isMoreLoading: false)), (
      response,
    ) {
      final combinedList = List<ProviderReviewItemEntity>.from(
        currentState.reviews,
      )..addAll(response.reviews);

      emit(
        ProviderReviewsLoadSuccess(
          reviews: combinedList,
          metrics: response.metrics,
          pagination: response.pagination,
          isMoreLoading: false,
        ),
      );
    });
  }

  Future<void> replyToReview({
    required int reviewId,
    required String replyText,
    required Function() onSuccess,
  }) async {
    final currentState = state;
    emit(const ProviderReviewReplyLoading());

    final params = ReplyToReviewParams(
      reviewId: reviewId,
      providerReply: replyText,
    );
    final result = await replyToReviewUseCase.call(params);

    if (isClosed) return;

    result.fold(
      (error) {
        emit(ProviderReviewReplyFailure(error: error));
        if (currentState is ProviderReviewsLoadSuccess) emit(currentState);
      },
      (_) {
        emit(const ProviderReviewReplySuccess());
        onSuccess();

        // Optimistically update the UI list without a full reload
        if (currentState is ProviderReviewsLoadSuccess) {
          final updatedReviews = currentState.reviews.map((review) {
            if (review.reviewId == reviewId) {
              return ProviderReviewItemEntity(
                reviewId: review.reviewId,
                bookingId: review.bookingId,
                bookingRef: review.bookingRef,
                score: review.score,
                feedback: review.feedback,
                providerReply: replyText,
                repliedAt: DateTime.now().toIso8601String(),
                submitted: review.submitted,
                timeAgo: review.timeAgo,
                serviceName: review.serviceName,
                customer: review.customer,
              );
            }
            return review;
          }).toList();
          emit(currentState.copyWith(reviews: updatedReviews));
        }
      },
    );
  }
}
