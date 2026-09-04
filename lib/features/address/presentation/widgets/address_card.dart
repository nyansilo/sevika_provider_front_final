// presentation/widgets/address_card.dart
import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart'; // 🚀 Swapped Theme.of(context) usages with your context properties
import '../../../../core/presentation/widgets/app_confirmation_dialog.dart';
import '../../domain/entities/customer_address_entity.dart';

class AddressCard extends StatelessWidget {
  final CustomerAddressEntity address;
  final String label;
  final String fullAddress;
  final IconData icon;
  final bool isDefault;
  final VoidCallback? onSetDefault;
  final VoidCallback? onDeleteSuccess;
  final VoidCallback? onTap;

  const AddressCard({
    super.key,
    required this.address,
    required this.label,
    required this.fullAddress,
    required this.icon,
    required this.isDefault,
    this.onSetDefault,
    this.onDeleteSuccess,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          border: Border.all(
            color: isDefault
                ? context.colorScheme.primary
                : context.colorScheme.outlineVariant.withValues(alpha: 0.3),
            width: isDefault
                ? AppDimensions.borderWidthMedium
                : AppDimensions.borderWidthThin,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingSM),
              decoration: BoxDecoration(
                color: isDefault
                    ? context.colorScheme.primary.withValues(alpha: 0.1)
                    : context.colorScheme.surfaceContainerHigh,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: AppDimensions.fontSizeHeading,
                color: isDefault
                    ? context.colorScheme.primary
                    : context.colorScheme.outline,
              ),
            ),
            AppDimensions.gapM,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        label,
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isDefault) ...[
                        AppDimensions.gapHS,
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingXS,
                            vertical: AppDimensions.radiusXXS,
                          ),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusXS,
                            ),
                          ),
                          child: Text(
                            'DEFAULT',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: context.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimensions.fontSizeTarget - 1,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    fullAddress,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                      height: AppDimensions.lineHeightNormal,
                    ),
                  ),
                ],
              ),
            ),
            AppDimensions.gapS,
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert_rounded,
                color: context.colorScheme.outline,
                size: AppDimensions.iconM,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onSelected: (value) => _handleMenuSelection(context, value),
              itemBuilder: (context) => [
                if (!isDefault)
                  PopupMenuItem(
                    value: 'set_default',
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline_rounded,
                          size: AppDimensions.fontSizeSubheading,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        AppDimensions.gapHS,
                        const Text('Set as Default'),
                      ],
                    ),
                  ),
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        size: AppDimensions.fontSizeSubheading,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      AppDimensions.gapHS,
                      const Text('Edit Address'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_outline_rounded,
                        size: AppDimensions.fontSizeSubheading,
                        color: context.colorScheme.error,
                      ),
                      AppDimensions.gapHS,
                      Text(
                        'Delete Address',
                        style: TextStyle(color: context.colorScheme.error),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuSelection(BuildContext context, String value) {
    switch (value) {
      case 'edit':
        if (onTap != null) {
          onTap!();
        }
        break;
      case 'delete':
        showDialog(
          context: context,
          builder: (dialogContext) => AppConfirmationDialog(
            title: 'Delete Address?',
            content:
                'Are you sure you want to remove "$label"? This action cannot be undone.',
            label: 'Delete',
            onDeleteConfirmed: () {
              if (onDeleteSuccess != null) onDeleteSuccess!();
            },
          ),
        );
        break;
      case 'set_default':
        if (onSetDefault != null) onSetDefault!();
        break;
    }
  }
}
