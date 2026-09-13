import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';

class DocumentPickerWidget extends StatelessWidget {
  final String title;
  final bool isRequired;
  final String? filePath;
  final String? fileName;
  final VoidCallback onTap;

  const DocumentPickerWidget({
    super.key,
    required this.title,
    this.isRequired = false,
    this.filePath,
    this.fileName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasFile = filePath != null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          border: Border.all(
            color: hasFile
                ? context.colorScheme.primary
                : context.colorScheme.outlineVariant,
            width: hasFile ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: hasFile
                    ? context.colorScheme.primaryContainer
                    : context.colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                hasFile
                    ? Icons.check_circle_rounded
                    : Icons.description_outlined,
                color: hasFile
                    ? context.colorScheme.primary
                    : context.colorScheme.onSurfaceVariant,
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
                        title,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isRequired) ...[
                        AppDimensions.gapHS,
                        Text(
                          '*',
                          style: TextStyle(
                            color: context.colorScheme.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                  AppDimensions.gapVS,
                  Text(
                    hasFile ? fileName! : 'Tap to select document',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: hasFile
                          ? context.colorScheme.onSurface
                          : context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
