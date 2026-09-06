import 'package:flutter/material.dart';

import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';

class ReviewFeedCard extends StatelessWidget {
  final String serviceName;
  final String providerName;
  final String dateString;
  final double ratingGiven;
  final String reviewText;
  final bool isOwnReview;
  final String? authorName;
  final String? authorAvatar;
  final bool isVerifiedBooking;
  final String? providerReply; // 🚀 Added
  final String? repliedAt; // 🚀 Added
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ReviewFeedCard({
    super.key,
    required this.serviceName,
    required this.providerName,
    required this.dateString,
    required this.ratingGiven,
    required this.reviewText,
    this.isOwnReview = false,
    this.isVerifiedBooking = true,
    this.authorName,
    this.authorAvatar,
    this.providerReply,
    this.repliedAt,
    this.onEdit,
    this.onDelete,
  });

  void _showActionMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXL),
        ),
      ),
      builder: (bottomSheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.edit_rounded,
                color: context.colorScheme.primary,
              ),
              title: const Text('Edit Review'),
              onTap: () {
                Navigator.pop(bottomSheetContext);
                onEdit?.call();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.delete_outline_rounded,
                color: context.colorScheme.error,
              ),
              title: const Text('Delete Review'),
              onTap: () {
                Navigator.pop(bottomSheetContext);
                onDelete?.call();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String resolvedName = authorName ?? 'Anonymous Customer';

    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: isOwnReview
            ? context.colorScheme.primaryContainer.withValues(alpha: 0.08)
            : context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        border: Border.all(
          color: isOwnReview
              ? context.colorScheme.primary.withValues(alpha: 0.2)
              : context.colorScheme.outlineVariant.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1️⃣ TOP AREA: IDENTITY ROW
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 36,
                height: 36,
                child: ClipOval(
                  child: authorAvatar != null && authorAvatar!.isNotEmpty
                      ? Image.network(
                          authorAvatar!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildPlaceholderAvatar(context, resolvedName),
                        )
                      : _buildPlaceholderAvatar(context, resolvedName),
                ),
              ),
              AppDimensions.gapS,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            resolvedName,
                            style: context.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isVerifiedBooking) ...[
                          AppDimensions.gapXXS,
                          Icon(
                            Icons.verified_rounded,
                            size: 14,
                            color: context.colorScheme.primary,
                          ),
                        ],
                      ],
                    ),
                    if (isOwnReview) ...[
                      AppDimensions.gapXXS,
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingXS,
                          vertical: AppDimensions.paddingXXS,
                        ),
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusS,
                          ),
                        ),
                        child: Text(
                          'Your Review',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (isOwnReview)
                IconButton(
                  icon: Icon(
                    Icons.more_horiz_rounded,
                    color: context.colorScheme.outline,
                    size: AppDimensions.iconM,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => _showActionMenu(context),
                ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimensions.paddingXS),
            child: Divider(height: 1, thickness: 0.2),
          ),

          // 2️⃣ CONTEXT AREA
          Text(
            serviceName,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            providerName,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          AppDimensions.gapS,

          // 3️⃣ METRICS AREA
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < ratingGiven
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: Colors.amber.shade700,
                    size: 16,
                  );
                }),
              ),
              Text(
                dateString,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.outline,
                ),
              ),
            ],
          ),
          AppDimensions.gapS,

          // 4️⃣ SUBSTANCE AREA
          Text(
            reviewText,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.85),
              height: 1.4,
            ),
          ),

          // 🚀 5️⃣ PROVIDER REPLY AREA (Clean Architecture UI Upgrade)
          if (providerReply != null && providerReply!.isNotEmpty) ...[
            AppDimensions.gapM,
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingS),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.4,
                ),
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                border: Border(
                  left: BorderSide(
                    color: context.colorScheme.primary.withValues(alpha: 0.5),
                    width: 3,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.reply_rounded,
                        size: 14,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      AppDimensions.gapXXS,
                      Text(
                        'Response from Provider',
                        style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  AppDimensions.gapXS,
                  Text(
                    providerReply!,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurface,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPlaceholderAvatar(BuildContext context, String name) {
    return Container(
      color: context.colorScheme.outlineVariant,
      alignment: Alignment.center,
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : 'U',
        style: context.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
