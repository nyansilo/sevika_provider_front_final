import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';

class ImagePickerBoxWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? imagePath;
  final IconData icon;
  final VoidCallback onTap;

  const ImagePickerBoxWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.imagePath,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasImage = imagePath != null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          border: Border.all(
            color: hasImage
                ? context.colorScheme.primary
                : context.colorScheme.outlineVariant,
            width: hasImage ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        child: hasImage
            ? ClipRRect(
                borderRadius: BorderRadius.circular(AppDimensions.radiusL - 2),
                child: Image.file(
                  File(imagePath!),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 40, color: context.colorScheme.primary),
                  AppDimensions.gapS,
                  Text(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
