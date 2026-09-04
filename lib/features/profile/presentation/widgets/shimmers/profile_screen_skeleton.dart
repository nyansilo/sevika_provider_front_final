import 'package:flutter/material.dart';

import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/presentation/widgets/shimmer_block.dart';
import 'profile_header_skeleton.dart';
import 'profile_promo_card_skeleton.dart';
import 'profile_quick_actions_skeleton.dart';
import 'profile_section_skeleton.dart';

class ProfileScreenSkeleton extends StatelessWidget {
  const ProfileScreenSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        title: const ShimmerBlock(
          width: AppDimensions.size80,
          height: AppDimensions.size20,
        ),
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppDimensions.paddingS),
            child: ShimmerBlock.circle(size: AppDimensions.iconL),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppDimensions.maxDashboardWidth,
            ),
            child: const SingleChildScrollView(
              padding: EdgeInsets.all(AppDimensions.paddingM),
              physics:
                  NeverScrollableScrollPhysics(), // Prevents engine list bouncing during load state
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. IDENTITY MODULE PLACEHOLDER
                  ProfileHeaderSkeleton(),
                  AppDimensions.gapM,

                  // 2. QUICK QUICK ACTIONS METRIC HUB PLACEHOLDER
                  ProfileQuickActionsSkeleton(),
                  AppDimensions.gapL,

                  // 3. CORE TRANSACTIONAL SECTION ("My Activity")
                  ProfileSectionSkeleton(
                    titleWidth: AppDimensions.size80,
                    itemCount: 3,
                  ),
                  AppDimensions.gapL,

                  // 4. DISPATCH INFRASTRUCTURE SECTION ("Logistics Details")
                  ProfileSectionSkeleton(
                    titleWidth: AppDimensions.size110,
                    itemCount: 2,
                  ),
                  AppDimensions.gapL,

                  // 5. ECOSYSTEM EXPANSION CALL-TO-ACTION CARD
                  ProfilePromoCardSkeleton(),
                  AppDimensions.gapL,

                  // 6. CRISIS SUPPORT MANAGEMENT CHANNEL ("Support")
                  ProfileSectionSkeleton(
                    titleWidth: AppDimensions.size56,
                    itemCount: 3,
                  ),
                  AppDimensions.gapXXL,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
