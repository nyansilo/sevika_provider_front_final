import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/navigation/app_keys.dart';
import '../../../../core/global/presentation/widgets/sevika_state_placeholder.dart';
import '../../../../core/routes/route_list.dart'; // 🚀 ADDED FOR ROUTING
import '../../domain/entities/provider_review_item_entity.dart';
import '../args/provider_reply_args.dart';
import '../cubits/provider_reviews_cubit.dart';
import '../cubits/provider_reviews_state.dart';
import '../widgets/review_feed_card.dart'; // 🚀 ADDED NEW DTO

class ProviderFeedbackScreen extends StatefulWidget {
  const ProviderFeedbackScreen({super.key});

  @override
  State<ProviderFeedbackScreen> createState() => _ProviderFeedbackScreenState();
}

class _ProviderFeedbackScreenState extends State<ProviderFeedbackScreen> {
  @override
  void initState() {
    super.initState();
    // 🚀 Fetch the provider's reviews immediately on load
    context.read<ProviderReviewsCubit>().loadReviews();
  }

  void _showMessengerSnackBar(String message, {bool isError = false}) {
    final state = AppKeys.messengerKey.currentState;
    if (state != null) {
      state.hideCurrentSnackBar();
      state.showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(
              color: isError
                  ? context.colorScheme.onError
                  : context.colorScheme.onPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: isError
              ? context.colorScheme.error
              : context.colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
        ),
      );
    }
  }

  // 🚀 LAUNCHES THE DEDICATED REPLY SCREEN INSTEAD OF THE BOTTOM SHEET
  Future<void> _openReplyScreen(
    BuildContext context,
    ProviderReviewItemEntity review,
  ) async {
    final didReply = await Navigator.pushNamed(
      context,
      RouteList.providerReviewReplyPage,
      arguments: ProviderReplyArgs(
        reviewId: review.reviewId,
        customerName: review.customer.name,
        serviceName: review.serviceName,
        feedback: review.feedback,
        score: review.score,
        existingReply: review.providerReply,
      ),
    );

    // 🔄 If the provider successfully replied and popped back, refresh the list automatically!
    if (didReply == true && context.mounted) {
      context.read<ProviderReviewsCubit>().loadReviews();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: context.colorScheme.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Performance & Reviews',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<ProviderReviewsCubit, ProviderReviewsState>(
        listenWhen: (previous, current) =>
            current is ProviderReviewReplySuccess ||
            current is ProviderReviewReplyFailure,
        listener: (context, state) {
          if (state is ProviderReviewReplySuccess) {
            _showMessengerSnackBar('Your reply has been posted successfully.');
          } else if (state is ProviderReviewReplyFailure) {
            _showMessengerSnackBar(
              state.error.message ?? 'Failed to post reply.',
              isError: true,
            );
          }
        },
        builder: (context, state) {
          // 1️⃣ LOADING STATE
          if (state is ProviderReviewsLoading ||
              state is ProviderReviewsInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2️⃣ ERROR STATE
          if (state is ProviderReviewsLoadFailure) {
            return SevikaStatePlaceholder(
              title: 'Unable to Load Data',
              message: state.error.message ?? 'Failed to load your reviews.',
              icon: Icons.error_outline_rounded,
              iconColor: context.colorScheme.error,
              actionButtonText: 'Try Again',
              onActionPressed: () =>
                  context.read<ProviderReviewsCubit>().loadReviews(),
            );
          }

          // 3️⃣ SUCCESS STATE
          if (state is ProviderReviewsLoadSuccess) {
            if (state.reviews.isEmpty) {
              return const SevikaStatePlaceholder(
                title: 'No Reviews Yet',
                message: 'You have not received any feedback from customers yet. Complete more jobs to build your reputation!',
                icon: Icons.star_border_rounded,
              );
            }

            return RefreshIndicator(
              onRefresh: () async =>
                  context.read<ProviderReviewsCubit>().loadReviews(),
              child: CustomScrollView(
                slivers: [
                  // 📊 METRICS HEADER CARD
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.all(AppDimensions.paddingM),
                      padding: const EdgeInsets.all(AppDimensions.paddingM),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primaryContainer.withValues(
                          alpha: 0.15,
                        ),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusL,
                        ),
                        border: Border.all(
                          color: context.colorScheme.primary.withValues(
                            alpha: 0.2,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: Colors.amber.shade700,
                                    size: 28,
                                  ),
                                  AppDimensions.gapXS,
                                  Text(
                                    state.metrics.averageRating.toStringAsFixed(
                                      1,
                                    ),
                                    style: context.textTheme.headlineMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                'Average Rating',
                                style: context.textTheme.labelMedium,
                              ),
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: context.colorScheme.outlineVariant,
                          ),
                          Column(
                            children: [
                              Text(
                                state.metrics.totalReviewCount.toString(),
                                style: context.textTheme.headlineMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Total Reviews',
                                style: context.textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 📝 REVIEWS LIST
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        // Pagination trigger
                        if (index >= state.reviews.length) {
                          context.read<ProviderReviewsCubit>().loadNextPage();
                          return const Padding(
                            padding: EdgeInsets.all(AppDimensions.paddingM),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final review = state.reviews[index];
                        final hasReplied =
                            review.providerReply != null &&
                            review.providerReply!.isNotEmpty;

                        return Padding(
                          padding: const EdgeInsets.only(
                            left: AppDimensions.paddingM,
                            right: AppDimensions.paddingM,
                            bottom: AppDimensions.paddingM,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // The Card we built earlier
                              ReviewFeedCard(
                                serviceName: review.serviceName,
                                providerName:
                                    'You', // Since it's the provider viewing it
                                dateString: review
                                    .timeAgo, // Used timeAgo for cleaner UI
                                ratingGiven: review.score.toDouble(),
                                reviewText: review.feedback,
                                authorName: review.customer.name,
                                authorAvatar: review.customer.avatar,
                                providerReply: review.providerReply,
                                repliedAt: review.repliedAt,
                                isOwnReview: false, // Provider didn't write it, they received it
                                isVerifiedBooking: true,
                              ),

                              // 🚀 INLINE ACTION: If no reply exists, launch the full reply screen!
                              if (!hasReplied) ...[
                                AppDimensions.gapS,
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: OutlinedButton.icon(
                                    onPressed: () =>
                                        _openReplyScreen(context, review),
                                    icon: const Icon(
                                      Icons.reply_rounded,
                                      size: 18,
                                    ),
                                    label: const Text('Reply to Customer'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor:
                                          context.colorScheme.primary,
                                      side: BorderSide(
                                        color: context.colorScheme.primary,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          AppDimensions.radiusM,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                      childCount:
                          state.reviews.length +
                          (state.pagination.hasMore ? 1 : 0),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
