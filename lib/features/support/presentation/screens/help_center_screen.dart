// import 'package:flutter/material.dart';
// import '../../../../core/constants/app_dimensions.dart';
// import '../widgets/help_center/faq_search_bar.dart';
// import '../widgets/help_center/support_category_card.dart';
// import '../widgets/help_center/faq_accordion_tile.dart';
// import '../widgets/help_center/contact_support_card.dart';

// class HelpCenterScreen extends StatelessWidget {
//   const HelpCenterScreen({super.key});

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
//             size: 20,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Help & Support',
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
//             child: Column(
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.all(AppDimensions.paddingM),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // 1. FAQ SEARCH COMPONENT
//                         const FaqSearchBar(),
//                         AppDimensions.gapXL,

//                         // 2. QUICK CATEGORIES GRID
//                         Text(
//                           'Browse Topics',
//                           style: theme.textTheme.titleSmall?.copyWith(
//                             fontWeight: FontWeight.bold,
//                             color: theme.colorScheme.onSurface,
//                           ),
//                         ),
//                         AppDimensions.gapS,
//                         GridView.count(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           crossAxisCount: 2,
//                           crossAxisSpacing: AppDimensions.paddingS,
//                           mainAxisSpacing: AppDimensions.paddingS,
//                           childAspectRatio: 1.4,
//                           children: [
//                             SupportCategoryCard(
//                               title: 'Bookings & Services',
//                               icon: Icons.calendar_today_rounded,
//                               iconColor: theme.colorScheme.primary,
//                               onTap: () {},
//                             ),
//                             SupportCategoryCard(
//                               title: 'Payments & Refunds',
//                               icon: Icons.account_balance_wallet_rounded,
//                               iconColor: Colors.green.shade600,
//                               onTap: () {},
//                             ),
//                             SupportCategoryCard(
//                               title: 'Account Security',
//                               icon: Icons.shield_outlined,
//                               iconColor: Colors.amber.shade700,
//                               onTap: () {},
//                             ),
//                             SupportCategoryCard(
//                               title: 'Technical Support',
//                               icon: Icons.build_circle_outlined,
//                               iconColor: Colors.purple.shade600,
//                               onTap: () {},
//                             ),
//                           ],
//                         ),
//                         AppDimensions.gapXL,

//                         // 3. ACCORDION TOP FREQUENTLY ASKED QUESTIONS
//                         Text(
//                           'Top Frequently Asked Questions',
//                           style: theme.textTheme.titleSmall?.copyWith(
//                             fontWeight: FontWeight.bold,
//                             color: theme.colorScheme.onSurface,
//                           ),
//                         ),
//                         AppDimensions.gapS,
//                         const FaqAccordionTile(
//                           question:
//                               'How do I modify or cancel an upcoming session?',
//                           answer:
//                               'Navigate to your dashboard, select the active schedule item, and tap "Modify Booking". Cancellations made 24 hours prior to service execution receive full wallet balance refunds.',
//                         ),
//                         AppDimensions.gapS,
//                         const FaqAccordionTile(
//                           question:
//                               'What payment methods are supported natively?',
//                           answer:
//                               'We accept all major East African Mobile Money options (M-Pesa, Tigo Pesa, Airtel Money, HaloPesa) alongside secured local and global Visa or Mastercard processing layouts.',
//                         ),
//                         AppDimensions.gapS,
//                         const FaqAccordionTile(
//                           question:
//                               'Can I request a custom receipt for tax tracking?',
//                           answer:
//                               'Yes. Every finished request produces an automated digital manifest downloadable directly from your account page ledger history.',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // 4. PERSISTENT FLOATING SUPPORT CHANNEL HOOK
//                 const ContactSupportCard(),
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
import '../widgets/help_center/contact_support_card.dart';
import '../widgets/help_center/faq_accordion_tile.dart';
import '../widgets/help_center/faq_search_bar.dart';
import '../widgets/help_center/support_category_card.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

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
            size: AppDimensions.iconM, // Standardized icon metric token mapping
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Help & Support',
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
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppDimensions.paddingM),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. FAQ SEARCH COMPONENT
                        const FaqSearchBar(),
                        AppDimensions.gapXL,

                        // 2. QUICK CATEGORIES GRID
                        Text(
                          'Browse Topics',
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        AppDimensions.gapS,
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: AppDimensions.paddingS,
                          mainAxisSpacing: AppDimensions.paddingS,
                          childAspectRatio: 1.4,
                          children: [
                            SupportCategoryCard(
                              title: 'Bookings & Services',
                              icon: Icons.calendar_today_rounded,
                              iconColor: context.colorScheme.primary,
                              onTap: () {},
                            ),
                            SupportCategoryCard(
                              title: 'Payments & Refunds',
                              icon: Icons.account_balance_wallet_rounded,
                              iconColor: Colors.green.shade600,
                              onTap: () {},
                            ),
                            SupportCategoryCard(
                              title: 'Account Security',
                              icon: Icons.shield_outlined,
                              iconColor: Colors.amber.shade700,
                              onTap: () {},
                            ),
                            SupportCategoryCard(
                              title: 'Technical Support',
                              icon: Icons.build_circle_outlined,
                              iconColor: Colors.purple.shade600,
                              onTap: () {},
                            ),
                          ],
                        ),
                        AppDimensions.gapXL,

                        // 3. ACCORDION TOP FREQUENTLY ASKED QUESTIONS
                        Text(
                          'Top Frequently Asked Questions',
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        AppDimensions.gapS,
                        const FaqAccordionTile(
                          question:
                              'How do I modify or cancel an upcoming session?',
                          answer:
                              'Navigate to your dashboard, select the active schedule item, and tap "Modify Booking". Cancellations made 24 hours prior to service execution receive full wallet balance refunds.',
                        ),
                        AppDimensions.gapS,
                        const FaqAccordionTile(
                          question:
                              'What payment methods are supported natively?',
                          answer:
                              'We accept all major East African Mobile Money options (M-Pesa, Tigo Pesa, Airtel Money, HaloPesa) alongside secured local and global Visa or Mastercard processing layouts.',
                        ),
                        AppDimensions.gapS,
                        const FaqAccordionTile(
                          question:
                              'Can I request a custom receipt for tax tracking?',
                          answer:
                              'Yes. Every finished request produces an automated digital manifest downloadable directly from your account page ledger history.',
                        ),
                      ],
                    ),
                  ),
                ),

                // 4. PERSISTENT FLOATING SUPPORT CHANNEL HOOK
                const ContactSupportCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
