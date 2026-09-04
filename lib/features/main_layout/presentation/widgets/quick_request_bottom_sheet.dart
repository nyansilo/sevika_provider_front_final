import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart'; // 💡 Ensure extension import
import '../../../../core/routes/route_list.dart';
import 'quick_request_option.dart';

class QuickRequestBottomSheet extends StatelessWidget {
  const QuickRequestBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface, // 💡 Refactored to extension
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXL),
        ),
      ),
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: AppDimensions.size40,
              height: AppDimensions.size4,
              decoration: BoxDecoration(
                color: context.colorScheme.outlineVariant, // 💡 Refactored
                borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
              ),
            ),
          ),
          AppDimensions.gapM,

          Text(
            'What do you need help with?',
            style: context.textTheme.titleMedium?.copyWith(
              // 💡 Refactored
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          AppDimensions.gapM,

          QuickRequestOption(
            icon: Icons.search_rounded,
            title: 'Browse Service Catalog',
            subtitle:
                'Book verified pros for cleaning, barbering, standard repairs, and more.',
            iconColor: context.colorScheme.primary, // 💡 Refactored
            bgColor: context.colorScheme.primaryContainer.withValues(
              alpha: 0.2,
            ), // 💡 Refactored
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                RouteList.serviceCatalogPage,
                arguments: {'categoryName': 'All Services'},
              );
            },
          ),
          AppDimensions.gapS,

          QuickRequestOption(
            icon: Icons.offline_bolt_rounded,
            title: 'Emergency Pro Dispatch',
            subtitle:
                'Urgent leak, electrical spark, or AC failure? Match with a pro within 15 mins.',
            iconColor: context.colorScheme.error, // 💡 Refactored
            bgColor: context.colorScheme.errorContainer.withValues(
              alpha: 0.2,
            ), // 💡 Refactored
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, RouteList.emergencyDispatchPage);
            },
          ),
          AppDimensions.gapS,

          QuickRequestOption(
            icon: Icons.assignment_outlined,
            title: 'Post a Custom Job Request',
            subtitle:
                'Describe a custom structural project and collect incoming bidding estimates.',
            iconColor: context.colorScheme.secondary, // 💡 Refactored
            bgColor: context.colorScheme.secondaryContainer.withValues(
              alpha: 0.2,
            ), // 💡 Refactored
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, RouteList.customJobFormPage);
            },
          ),
          SizedBox(
            height:
                MediaQuery.of(context).padding.bottom + AppDimensions.paddingS,
          ),
        ],
      ),
    );
  }
}
