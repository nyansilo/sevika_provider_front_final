import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/presentation/widgets/sevika_button.dart';

class ServicePreviewScreen extends StatelessWidget {
  final Map<String, dynamic> service;

  const ServicePreviewScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    // Fallback description if not provided in the mock data
    final description =
        service['description'] ??
        'This is a preview of your service description. When customers view your service, they will see all the details, scope of work, and terms you provided here. Make sure it is clear and professional to attract more bookings.';

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      // 🔽 BOTTOM FIXED ACTION BAR (Mock Booking Button)
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: AppDimensions.paddingM,
          right: AppDimensions.paddingM,
          top: AppDimensions.paddingM,
          bottom: context.viewInsetsBottom > 0
              ? AppDimensions.paddingM
              : MediaQuery.of(context).padding.bottom + AppDimensions.paddingM,
        ),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.shadow.withValues(alpha: 0.05),
              offset: const Offset(0, -4),
              blurRadius: 16,
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Price',
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      service['price'],
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              AppDimensions.gapM,
              Expanded(
                child: SevikaButton(
                  text: 'Book Now',
                  onPressed: () {
                    context.showSnackBar(
                      'This is just a preview. Customers will tap this to book you.',
                      type: SnackBarType.info,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 🖼️ HERO IMAGE (SliverAppBar)
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            backgroundColor: context.colorScheme.surface,
            iconTheme: IconThemeData(color: context.colorScheme.primary),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // 👨‍🔧 Placeholder for the Admin's Cover Image
                  Container(
                    color: context.colorScheme.primaryContainer.withValues(
                      alpha: 0.3,
                    ),
                    child: Icon(
                      Icons.image_outlined,
                      size: 64,
                      color: context.colorScheme.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  // Gradient overlay to make back button visible
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.4),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.3],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 📄 CONTENT BODY
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🚨 PREVIEW BANNER
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppDimensions.paddingS),
                  color: context.colorScheme.secondaryContainer,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.visibility_outlined,
                        size: 16,
                        color: context.colorScheme.onSecondaryContainer,
                      ),
                      AppDimensions.gapHS,
                      Text(
                        'Preview Mode: This is how customers see your service.',
                        style: context.textTheme.labelMedium?.copyWith(
                          color: context.colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(AppDimensions.paddingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Tag
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingS,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: context.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusXS,
                          ),
                        ),
                        child: Text(
                          service['category'],
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      AppDimensions.gapS,

                      // Title
                      Text(
                        service['title'],
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onSurface,
                          height: 1.2,
                        ),
                      ),
                      AppDimensions.gapL,

                      // Mock Provider Profile Row
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: context.colorScheme.primary,
                            child: const Text(
                              'You',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          AppDimensions.gapM,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Provided by You',
                                  style: context.textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star_rounded,
                                      size: 16,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '4.9 (120 Reviews)',
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: context
                                                .colorScheme
                                                .onSurfaceVariant,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      AppDimensions.gapL,
                      const Divider(),
                      AppDimensions.gapL,

                      // Description Section
                      Text(
                        'Service Description',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppDimensions.gapS,
                      Text(
                        description,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),

                      AppDimensions.gapXXXL, // Bottom clearance
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
