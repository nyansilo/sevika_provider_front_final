import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/global/presentation/widgets/app_network_image.dart';
import '../../../../../core/routes/route_list.dart';

import '../../../domain/entities/provider_service_entity.dart';
import '../../../domain/enums/service_status.dart';
import '../../args/service_action_args.dart';
import '../../cubits/provider_service_cubit.dart';

class PortfolioServiceCard extends StatelessWidget {
  final ProviderServiceEntity service;

  const PortfolioServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    // 🎨 Resolve Dynamic Colors & Icons strictly from the Enum
    final Color statusColor = _getStatusColor(context, service.status);
    final IconData statusIcon = _getStatusIcon(service.status);
    final String statusLabel = _getStatusLabel(service.status);

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          // 🚨 Red border if rejected to grab attention
          color: service.status == ServiceStatus.rejected
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
          // 🔝 TOP ROW: Image/Icon, Info, and Status Pill
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🖼️ Uses your AppNetworkImage or a fallback icon
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer.withValues(
                      alpha: 0.3,
                    ),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                  ),
                  child: service.image != null
                      ? AppNetworkImage(
                          imageUrl: service.image!,
                          borderRadius: AppDimensions.radiusS,
                        )
                      : Icon(
                          Icons.design_services_outlined,
                          color: context.colorScheme.primary,
                        ),
                ),
                AppDimensions.gapM,

                // Title, Pricing, and Booking count
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.title,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onSurface,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      AppDimensions.gapXS,
                      Text(
                        'TZS ${service.visitFee.toStringAsFixed(0)}', // Format cleanly
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
                        statusLabel,
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
          if (service.status == ServiceStatus.rejected &&
              service.rejectionReason != null)
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
                      'Admin Note: ${service.rejectionReason}',
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
                    // 🎯 Route using the strongly-typed Args pattern
                    Navigator.pushNamed(
                      context,
                      RouteList.servicePreviewPage,
                      arguments: ServiceActionArgs(service: service),
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
                  onPressed: () async {
                    await Navigator.pushNamed(
                      context,
                      RouteList.addEditServicePage,
                      arguments: ServiceActionArgs(service: service),
                    );

                    // 🚀 Automatically refresh so the new price/status shows instantly!
                    if (context.mounted) {
                      context.read<ProviderServiceCubit>().fetchCatalog();
                    }
                  },
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: const Text('Edit Service'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(0, 36),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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

  // Helper Methods for UI logic bound to strict Enums
  Color _getStatusColor(BuildContext context, ServiceStatus status) {
    return switch (status) {
      ServiceStatus.approved => Colors.green,
      ServiceStatus.pending => Colors.orange,
      ServiceStatus.rejected => context.colorScheme.error,
      _ => context.colorScheme.outline,
    };
  }

  IconData _getStatusIcon(ServiceStatus status) {
    return switch (status) {
      ServiceStatus.approved => Icons.check_circle_outline,
      ServiceStatus.pending => Icons.hourglass_empty,
      ServiceStatus.rejected => Icons.error_outline,
      _ => Icons.help_outline,
    };
  }

  String _getStatusLabel(ServiceStatus status) {
    return switch (status) {
      ServiceStatus.approved => 'Active',
      ServiceStatus.pending => 'Pending',
      ServiceStatus.rejected => 'Rejected',
      _ => 'Unknown',
    };
  }
}
