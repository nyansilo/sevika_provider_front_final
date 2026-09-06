import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/navigation/app_keys.dart';
import '../args/provider_reply_args.dart';
import '../cubits/provider_reviews_cubit.dart';
import '../cubits/provider_reviews_state.dart';

class ProviderReviewReplyScreen extends StatefulWidget {
  final ProviderReplyArgs args;

  const ProviderReviewReplyScreen({super.key, required this.args});

  @override
  State<ProviderReviewReplyScreen> createState() =>
      _ProviderReviewReplyScreenState();
}

class _ProviderReviewReplyScreenState extends State<ProviderReviewReplyScreen> {
  late final TextEditingController _replyController;

  @override
  void initState() {
    super.initState();
    _replyController = TextEditingController(
      text: widget.args.existingReply ?? '',
    );
  }

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
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

  void _submitReply() {
    final text = _replyController.text.trim();
    if (text.isEmpty) {
      _showMessengerSnackBar('Please enter a reply message.', isError: true);
      return;
    }

    context.read<ProviderReviewsCubit>().replyToReview(
      reviewId: widget.args.reviewId,
      replyText: text,
      onSuccess: () {}, // Success is handled by the BlocListener
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProviderReviewsCubit, ProviderReviewsState>(
      listenWhen: (previous, current) =>
          current is ProviderReviewReplySuccess ||
          current is ProviderReviewReplyFailure,
      listener: (context, state) {
        if (state is ProviderReviewReplySuccess) {
          _showMessengerSnackBar('Your response has been posted publicly.');
          // Pop and return true so the previous screen knows to refresh the list!
          Navigator.pop(context, true);
        } else if (state is ProviderReviewReplyFailure) {
          _showMessengerSnackBar(
            state.error.message ?? 'Failed to post reply.',
            isError: true,
          );
        }
      },
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        appBar: AppBar(
          backgroundColor: context.colorScheme.surface,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: context.colorScheme.onSurface,
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: Text(
            'Reply to Customer',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(AppDimensions.paddingM),
                  children: [
                    // 1️⃣ ORIGINAL REVIEW CONTEXT CARD
                    Container(
                      padding: const EdgeInsets.all(AppDimensions.paddingM),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusL,
                        ),
                        border: Border.all(
                          color: context.colorScheme.outlineVariant.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.args.customerName,
                                style: context.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < widget.args.score
                                        ? Icons.star_rounded
                                        : Icons.star_outline_rounded,
                                    color: Colors.amber.shade700,
                                    size: 14,
                                  );
                                }),
                              ),
                            ],
                          ),
                          AppDimensions.gapXS,
                          Text(
                            widget.args.serviceName,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: AppDimensions.paddingS,
                            ),
                            child: Divider(height: 1, thickness: 0.2),
                          ),
                          Text(
                            widget.args.feedback,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onSurface.withValues(
                                alpha: 0.85,
                              ),
                              height: 1.4,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),

                    AppDimensions.gapL,

                    // 2️⃣ REPLY INPUT AREA
                    Text(
                      'Your Public Response',
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppDimensions.gapXS,
                    Text(
                      'This will be visible on your public marketplace profile.',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    AppDimensions.gapM,
                    TextField(
                      controller: _replyController,
                      maxLines: 8,
                      maxLength: 500,
                      decoration: InputDecoration(
                        hintText: 'Thank you for choosing my services! It was a pleasure working with you...',
                        filled: true,
                        fillColor: context.colorScheme.surfaceContainerLowest,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusM,
                          ),
                          borderSide: BorderSide(
                            color: context.colorScheme.outlineVariant,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusM,
                          ),
                          borderSide: BorderSide(
                            color: context.colorScheme.outlineVariant,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusM,
                          ),
                          borderSide: BorderSide(
                            color: context.colorScheme.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 3️⃣ BOTTOM ACTION BAR
              BlocBuilder<ProviderReviewsCubit, ProviderReviewsState>(
                builder: (context, state) {
                  final isLoading = state is ProviderReviewReplyLoading;
                  return Container(
                    padding: const EdgeInsets.all(AppDimensions.paddingM),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: context.colorScheme.shadow.withValues(
                            alpha: 0.05,
                          ),
                          blurRadius: 10,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _submitReply,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.colorScheme.primary,
                            foregroundColor: context.colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusM,
                              ),
                            ),
                          ),
                          child: isLoading
                              ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: context.colorScheme.onPrimary,
                                  ),
                                )
                              : const Text(
                                  'Publish Reply',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
