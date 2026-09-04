// import 'package:flutter/material.dart';
// import '../../../../core/constants/app_dimensions.dart';
// import '../widgets/legal_term/legal_item_tile.dart';
// import '../widgets/legal_term/copyright_footer.dart';

// class LegalTermsScreen extends StatelessWidget {
//   const LegalTermsScreen({super.key});

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
//           'Legal & Compliance',
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
//                   child: ListView(
//                     padding: const EdgeInsets.all(AppDimensions.paddingM),
//                     children: [
//                       Text(
//                         'Our Core Agreements',
//                         style: theme.textTheme.titleSmall?.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: theme.colorScheme.onSurface,
//                         ),
//                       ),
//                       AppDimensions.gapS,
//                       LegalItemTile(
//                         title: 'Terms of Service',
//                         subtitle:
//                             'Rules, user responsibilities, and platform guidelines',
//                         version: 'v2.4 (Updated May 2026)',
//                         icon: Icons.gavel_rounded,
//                         onTap: () {},
//                       ),
//                       AppDimensions.gapS,
//                       LegalItemTile(
//                         title: 'Privacy Policy',
//                         subtitle:
//                             'Data governance, telemetry parameters, and usage policies',
//                         version: 'v2.1 (Updated Jan 2026)',
//                         icon: Icons.privacy_tip_rounded,
//                         onTap: () {},
//                       ),
//                       AppDimensions.gapS,
//                       LegalItemTile(
//                         title: 'Digital Rights & DRM Policy',
//                         subtitle:
//                             'Intellectual property boundaries and trade enforcement',
//                         version: 'v1.0',
//                         icon: Icons.copyright_rounded,
//                         onTap: () {},
//                       ),
//                       AppDimensions.gapL,
//                       Text(
//                         'Third-Party & Software Manifests',
//                         style: theme.textTheme.titleSmall?.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: theme.colorScheme.onSurface,
//                         ),
//                       ),
//                       AppDimensions.gapS,
//                       LegalItemTile(
//                         title: 'Open Source Licenses',
//                         subtitle: 'Compilations of package legal declarations',
//                         icon: Icons.code_rounded,
//                         onTap: () {
//                           showLicensePage(
//                             context: context,
//                             applicationName: 'Service Marketplace',
//                             applicationVersion: '1.0.2',
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 const CopyrightFooter(),
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
import '../widgets/legal_term/copyright_footer.dart';
import '../widgets/legal_term/legal_item_tile.dart';

class LegalTermsScreen extends StatelessWidget {
  const LegalTermsScreen({super.key});

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
          'Legal & Compliance',
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
                  child: ListView(
                    padding: const EdgeInsets.all(AppDimensions.paddingM),
                    children: [
                      Text(
                        'Our Core Agreements',
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      AppDimensions.gapS,
                      LegalItemTile(
                        title: 'Terms of Service',
                        subtitle:
                            'Rules, user responsibilities, and platform guidelines',
                        version: 'v2.4 (Updated May 2026)',
                        icon: Icons.gavel_rounded,
                        onTap: () {},
                      ),
                      AppDimensions.gapS,
                      LegalItemTile(
                        title: 'Privacy Policy',
                        subtitle:
                            'Data governance, telemetry parameters, and usage policies',
                        version: 'v2.1 (Updated Jan 2026)',
                        icon: Icons.privacy_tip_rounded,
                        onTap: () {},
                      ),
                      AppDimensions.gapS,
                      LegalItemTile(
                        title: 'Digital Rights & DRM Policy',
                        subtitle:
                            'Intellectual property boundaries and trade enforcement',
                        version: 'v1.0',
                        icon: Icons.copyright_rounded,
                        onTap: () {},
                      ),
                      AppDimensions.gapL,
                      Text(
                        'Third-Party & Software Manifests',
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      AppDimensions.gapS,
                      LegalItemTile(
                        title: 'Open Source Licenses',
                        subtitle: 'Compilations of package legal declarations',
                        icon: Icons.code_rounded,
                        onTap: () {
                          showLicensePage(
                            context: context,
                            applicationName: 'Service Marketplace',
                            applicationVersion: '1.0.2',
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const CopyrightFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
