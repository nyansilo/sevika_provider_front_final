import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../domain/enums/kyc_status.dart';

class KycTierCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final KycStatus status;
  final bool isLocked;
  final String? rejectionReason;
  final VoidCallback onTap;

  const KycTierCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.status,
    required this.isLocked,
    this.rejectionReason,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    IconData statusIcon = Icons.arrow_forward_ios_rounded;
    Color statusColor = context.colorScheme.onSurfaceVariant;
    String statusText = 'Not Submitted';

    if (isLocked) {
      statusIcon = Icons.lock_rounded;
      statusText = 'Locked (Complete Tier 1 First)';
    } else if (status == KycStatus.pending || status == KycStatus.inReview) {
      statusIcon = Icons.hourglass_empty_rounded;
      statusColor = Colors.orange;
      statusText = 'In Review';
    } else if (status == KycStatus.approved) {
      statusIcon = Icons.check_circle_rounded;
      statusColor = context.colorScheme.primary;
      statusText = 'Approved';
    } else if (status == KycStatus.rejected) {
      statusIcon = Icons.error_outline_rounded;
      statusColor = context.colorScheme.error;
      statusText = 'Action Required';
    }

    final bool isClickable =
        !isLocked &&
        status != KycStatus.approved &&
        status != KycStatus.pending &&
        status != KycStatus.inReview;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        side: BorderSide(color: context.colorScheme.outlineVariant),
      ),
      child: InkWell(
        onTap: isClickable ? onTap : null,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    statusIcon,
                    color: statusColor,
                    size: AppDimensions.iconM,
                  ),
                ],
              ),
              AppDimensions.gapS,
              Text(
                description,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              AppDimensions.gapM,
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                ),
                child: Text(
                  statusText,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (status == KycStatus.rejected && rejectionReason != null) ...[
                AppDimensions.gapM,
                Container(
                  padding: const EdgeInsets.all(AppDimensions.paddingM),
                  decoration: BoxDecoration(
                    color: context.colorScheme.errorContainer.withValues(
                      alpha: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 16,
                        color: context.colorScheme.error,
                      ),
                      AppDimensions.gapS,
                      Expanded(
                        child: Text(
                          rejectionReason!,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
