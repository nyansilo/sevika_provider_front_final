import 'package:flutter/material.dart';

import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routes/route_list.dart';
import '../../../../core/presentation/widgets/brand_logo.dart';
import '../../../../core/presentation/widgets/sevika_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppDimensions.maxFormContentWidth,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingL),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const BrandLogo(),
                  AppDimensions.gapXL,

                  Container(
                    padding: const EdgeInsets.all(AppDimensions.paddingL),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusXXL,
                      ),
                      border: Border.all(
                        color: context.colorScheme.outlineVariant,
                      ),
                    ),
                    child: Icon(
                      Icons.handyman_rounded, // 👨‍🔧 Provider visual cue
                      size: AppDimensions.size48,
                      color: context.colorScheme.primary,
                    ),
                  ),
                  AppDimensions.gapXL,

                  // 👨‍🔧 PROVIDER BRANDING
                  Text(
                    'Sevika for Partners',
                    style: context.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  AppDimensions.gapM,
                  Text(
                    'Join the leading network of verified home service professionals and grow your business today.',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),

                  SevikaButton(
                    text: 'Login to Partner Account', // 👨‍🔧 Explicit action
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteList.loginPage),
                  ),
                  AppDimensions.gapM,

                  SevikaButton(
                    text: 'Apply to be a Partner', // 👨‍🔧 Provider semantics
                    isSecondary: true,
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteList.registerPage),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
