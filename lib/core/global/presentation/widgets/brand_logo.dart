import 'package:flutter/material.dart';

import '../../../constants/app_dimensions.dart';
import '../../../extensions/build_context_extensions.dart'; // Added the extension import

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(
        'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=150&auto=format&fit=crop&q=60',
        height: AppDimensions.logoHeight,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // Note: The 'context' parameter here is local to the errorBuilder,
          // but because it is a genuine BuildContext, our extension properties
          // like .colorScheme work seamlessly here too!
          return Container(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.home_repair_service_rounded,
              size: AppDimensions.logoHeight * 0.6,
              color: context.colorScheme.onPrimaryContainer,
            ),
          );
        },
      ),
    );
  }
}
