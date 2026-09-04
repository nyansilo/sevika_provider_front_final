import 'package:flutter/material.dart';

import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/routes/route_list.dart';

class PortfolioServiceCard extends StatelessWidget {
  final Map<String, dynamic> service;

  const PortfolioServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final status = service['status'] as String;

    // 🎨 Resolve Dynamic Colors & Icons
    final Color statusColor = _getStatusColor(context, status);
    final IconData statusIcon = _getStatusIcon(status);
    final IconData categoryIcon = _getCategoryIcon(service['category']);

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          // Red border if rejected to grab attention, otherwise standard subtle border
          color: status == 'Rejected'
              ? context.colorScheme.error
              : context.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔝 TOP ROW: Icon, Info, and Status Pill
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Icon Box
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer.withValues(
                      alpha: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                  ),
                  child: Icon(categoryIcon, color: context.colorScheme.primary),
                ),
                AppDimensions.gapM,

                // Title, Category, and Price
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service['category'],
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                      ),
                      AppDimensions.gapXXS,
                      Text(
                        service['title'],
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onSurface,
                          height: 1.2,
                        ),
                      ),
                      AppDimensions.gapXS,
                      Text(
                        service['price'],
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Status Pill
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, size: 12, color: statusColor),
                      const SizedBox(width: 4),
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 🚨 ADMIN FEEDBACK (Only shows if Rejected)
          if (status == 'Rejected' && service['feedback'] != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingM,
                vertical: AppDimensions.paddingS,
              ),
              color: context.colorScheme.errorContainer.withValues(alpha: 0.3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: context.colorScheme.error,
                  ),
                  AppDimensions.gapHS,
                  Expanded(
                    child: Text(
                      'Admin Note: ${service['feedback']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // 🔽 BOTTOM ROW: Action Buttons
          Divider(
            height: 1,
            color: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingM,
              vertical: AppDimensions.paddingS,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    // 🎯 Pass the whole service map object to the preview screen
                    Navigator.pushNamed(
                      context,
                      RouteList.servicePreviewPage,
                      arguments: service,
                    );
                  },
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  label: const Text('Preview'),
                  style: TextButton.styleFrom(
                    foregroundColor: context.colorScheme.onSurfaceVariant,
                    minimumSize: const Size(0, 36),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                AppDimensions.gapS,
                FilledButton.tonalIcon(
                  onPressed: () {
                    // Navigate to Edit Mode
                    Navigator.pushNamed(
                      context,
                      RouteList.addEditServicePage,
                      arguments: service['id'],
                    );
                  },
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: const Text('Edit Service'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(
                      0,
                      36,
                    ), // 🎯 Perfect height constraint
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ), // 🎯 Evenly spaced padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusL,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper Methods for UI logic
  Color _getStatusColor(BuildContext context, String status) {
    return switch (status) {
      'Active' => Colors.green,
      'Pending' => Colors.orange,
      'Rejected' => context.colorScheme.error,
      _ => context.colorScheme.outline,
    };
  }

  IconData _getStatusIcon(String status) {
    return switch (status) {
      'Active' => Icons.check_circle_outline,
      'Pending' => Icons.hourglass_empty,
      'Rejected' => Icons.error_outline,
      _ => Icons.help_outline,
    };
  }

  IconData _getCategoryIcon(String category) {
    // Mock logic: Replace with actual icon mapping or network images later
    if (category.toLowerCase().contains('cleaning')) {
      return Icons.cleaning_services_outlined;
    }
    if (category.toLowerCase().contains('plumbing')) {
      return Icons.plumbing_outlined;
    }
    return Icons.design_services_outlined;
  }
}
