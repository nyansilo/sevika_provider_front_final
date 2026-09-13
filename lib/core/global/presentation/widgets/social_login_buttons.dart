import 'package:flutter/material.dart';

import '../../../constants/app_dimensions.dart';
import '../../../extensions/build_context_extensions.dart'; // Using your clean extension!

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;
  final VoidCallback onFacebookTap;

  const SocialLoginButtons({
    super.key,
    required this.onGoogleTap,
    required this.onAppleTap,
    required this.onFacebookTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          context,
          Icons.g_mobiledata,
          Colors.red,
          onGoogleTap,
        ),
        AppDimensions.gapM,
        _buildSocialButton(
          context,
          Icons.apple,
          context.colorScheme.onSurface, // Refactored using extension
          onAppleTap,
        ),
        AppDimensions.gapM,
        _buildSocialButton(context, Icons.facebook, Colors.blue, onFacebookTap),
      ],
    );
  }

  Widget _buildSocialButton(
    BuildContext context,
    IconData icon,
    Color iconColor,
    VoidCallback onTap,
  ) {
    // Uses your existing button height token to make a perfect 1:1 square ratio boundary
    final double buttonSize = AppDimensions.targetButtonHeight;

    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        shape:
            BoxShape.circle, // Forces the container outline into a clean circle
        border: Border.all(color: context.colorScheme.outlineVariant),
        color: context.colorScheme.surface,
      ),
      // Material wrapper ensures the InkWell tap splash clips perfectly inside the circle shape
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(), // Shapes the touch ripple effect to be a circle
          child: Center(
            child: Icon(
              icon,
              size: AppDimensions.socialIconSize,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
