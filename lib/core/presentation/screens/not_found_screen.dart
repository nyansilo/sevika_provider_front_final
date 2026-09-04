import 'package:flutter/material.dart';

import '../../extensions/build_context_extensions.dart';
import '../../routes/route_list.dart';
import '../widgets/sevika_state_placeholder.dart';

class NotFoundScreen extends StatelessWidget {
  final String? attemptedRoute;

  const NotFoundScreen({super.key, this.attemptedRoute});

  @override
  Widget build(BuildContext context) {
    // 🎯 Dynamically inject the broken route path for debugging
    final routeText = attemptedRoute != null
        ? '\n\nError code: $attemptedRoute'
        : '';

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(context, RouteList.initial);
            }
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SevikaStatePlaceholder(
            title: 'Page Not Found',
            message:
                "We couldn't find the page you're looking for. The link might be broken, or the page may have been removed.$routeText",
            icon: Icons.explore_off_rounded,
            iconColor: context.colorScheme.error,
            iconBackgroundColor: context.colorScheme.errorContainer.withValues(
              alpha: 0.3,
            ),
            actionButtonText: 'Return to Home',
            actionButtonIcon: Icons.home_rounded,
            onActionPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteList.initial,
                (route) => false,
              );
            },
          ),
        ),
      ),
    );
  }
}
