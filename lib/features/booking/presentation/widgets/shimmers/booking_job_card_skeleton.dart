import 'package:flutter/material.dart';

import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/presentation/widgets/shimmer_block.dart'; // Ensure correct path to your ShimmerBlock

/// 👨‍🔧 SKELETON: Displays a placeholder matching the exact layout of a Provider Job Card
class BookingJobCardSkeleton extends StatelessWidget {
  const BookingJobCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(
          color: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER: Avatar, Name, and Status Badge
          Row(
            children: [
              const ShimmerBlock.circle(size: 48),
              AppDimensions.gapM,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBlock(
                      width: 140,
                      height: 16,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 8),
                    ShimmerBlock(
                      width: 90,
                      height: 12,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ),
              ),
              ShimmerBlock(
                width: 70,
                height: 24,
                borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
              ),
            ],
          ),

          AppDimensions.gapM,
          const Divider(height: 1),
          AppDimensions.gapM,

          // BODY: Service Details & Time
          ShimmerBlock(
            width: double.infinity,
            height: 14,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 8),
          ShimmerBlock(
            width: 200,
            height: 14,
            borderRadius: BorderRadius.circular(4),
          ),

          AppDimensions.gapL,

          // FOOTER: Price and Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerBlock(
                width: 80,
                height: 20,
                borderRadius: BorderRadius.circular(4),
              ),
              Row(
                children: [
                  ShimmerBlock(
                    width: 80,
                    height: 36,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                  AppDimensions.gapS,
                  ShimmerBlock(
                    width: 80,
                    height: 36,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
