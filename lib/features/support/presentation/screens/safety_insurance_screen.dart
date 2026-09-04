// import 'package:flutter/material.dart';
// import '../../../../core/constants/app_dimensions.dart';
// import '../widgets/satety/safety_banner_card.dart';
// import '../widgets/satety/assurance_feature_card.dart';

// class SafetyInsuranceScreen extends StatelessWidget {
//   const SafetyInsuranceScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: theme.colorScheme.surface,
//       appBar: AppBar(
//         backgroundColor: theme.colorScheme.surface,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios_new_rounded,
//             color: theme.colorScheme.onSurface,
//             size: AppDimensions.iconM,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Safety & Guarantees',
//           style: theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Center(
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(
//               maxWidth: AppDimensions.maxDashboardWidth,
//             ),
//             child: ListView(
//               padding: const EdgeInsets.all(AppDimensions.paddingM),
//               children: [
//                 // EXTRACTED WIDGET 1: Top Visual Shield & Protection Banner
//                 const SafetyBannerCard(),
//                 AppDimensions.gapL,

//                 Text(
//                   'Your Protection Pillars',
//                   style: theme.textTheme.titleSmall?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: theme.colorScheme.onSurface,
//                   ),
//                 ),
//                 AppDimensions.gapS,

//                 // EXTRACTED WIDGET 2: Individual Protection Cards
//                 AssuranceFeatureCard(
//                   title: 'Property & Liability Insurance',
//                   description:
//                       'Every booking is insured up to TSh 5,000,000 against accidental property damages during service execution.',
//                   badgeLabel: 'Active Coverage',
//                   icon: Icons.shield_outlined,
//                   iconColor: theme.colorScheme.primary,
//                 ),
//                 AppDimensions.gapM,

//                 AssuranceFeatureCard(
//                   title: 'Vetted Professionals Only',
//                   description:
//                       'All service operators undergo rigorous multi-step identity verification, criminal background check mapping, and dynamic skill evaluations.',
//                   badgeLabel: '100% Verified',
//                   icon: Icons.verified_user_outlined,
//                   iconColor: theme.colorScheme.secondary,
//                 ),
//                 AppDimensions.gapM,

//                 AssuranceFeatureCard(
//                   title: 'Escrow Secure Payments',
//                   description:
//                       'Funds are securely locked in reservation escrow and are only transferred to the professional after you formally confirm structural completion.',
//                   badgeLabel: 'Fraud Protected',
//                   icon: Icons.lock_outline_rounded,
//                   iconColor: theme.colorScheme.tertiary,
//                 ),
//                 AppDimensions.gapM,

//                 AssuranceFeatureCard(
//                   title: '24/7 Dispute Resolution Team',
//                   description:
//                       'If a project does not match agreed milestones, our independent platform arbitration officers halt payments and step in to manage mediation within 24 hours.',
//                   badgeLabel: 'Mediation Support',
//                   icon: Icons.support_agent_rounded,
//                   iconColor: theme.colorScheme.error,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart'; // Imported context layer shortcuts
import '../widgets/satety/assurance_feature_card.dart';
import '../widgets/satety/safety_banner_card.dart';

class SafetyInsuranceScreen extends StatelessWidget {
  const SafetyInsuranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: context.colorScheme.onSurface,
            size: AppDimensions.iconM,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Safety & Guarantees',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppDimensions.maxDashboardWidth,
            ),
            child: ListView(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              children: [
                // EXTRACTED WIDGET 1: Top Visual Shield & Protection Banner
                const SafetyBannerCard(),
                AppDimensions.gapL,

                Text(
                  'Your Protection Pillars',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                AppDimensions.gapS,

                // EXTRACTED WIDGET 2: Individual Protection Cards
                AssuranceFeatureCard(
                  title: 'Property & Liability Insurance',
                  description:
                      'Every booking is insured up to TSh 5,000,000 against accidental property damages during service execution.',
                  badgeLabel: 'Active Coverage',
                  icon: Icons.shield_outlined,
                  iconColor: context.colorScheme.primary,
                ),
                AppDimensions.gapM,

                AssuranceFeatureCard(
                  title: 'Vetted Professionals Only',
                  description:
                      'All service operators undergo rigorous multi-step identity verification, criminal background check mapping, and dynamic skill evaluations.',
                  badgeLabel: '100% Verified',
                  icon: Icons.verified_user_outlined,
                  iconColor: context.colorScheme.secondary,
                ),
                AppDimensions.gapM,

                AssuranceFeatureCard(
                  title: 'Escrow Secure Payments',
                  description:
                      'Funds are securely locked in reservation escrow and are only transferred to the professional after you formally confirm structural completion.',
                  badgeLabel: 'Fraud Protected',
                  icon: Icons.lock_outline_rounded,
                  iconColor: context.colorScheme.tertiary,
                ),
                AppDimensions.gapM,

                AssuranceFeatureCard(
                  title: '24/7 Dispute Resolution Team',
                  description:
                      'If a project does not match agreed milestones, our independent platform arbitration officers halt payments and step in to manage mediation within 24 hours.',
                  badgeLabel: 'Mediation Support',
                  icon: Icons.support_agent_rounded,
                  iconColor: context.colorScheme.error,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
