// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../../core/extensions/build_context_extensions.dart';
// import '../../../../auth/presentation/cubits/auth/auth_cubit.dart';

// /// Displays an alert dialog confirming sign-out intent before triggering data mutations
// void showLogoutConfirmationDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (dialogContext) => AlertDialog(
//       title: const Text('Sign Out'),
//       content: const Text(
//         'Are you sure you want to securely close your active profile session?',
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(dialogContext),
//           child: Text(
//             'Cancel',
//             style: TextStyle(color: context.colorScheme.onSurfaceVariant),
//           ),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.pop(dialogContext); // Close the dialog box
//             // Dispatches logout request to your business state manager layer
//             context.read<AuthCubit>().logout();
//           },
//           child: Text(
//             'Sign Out',
//             style: TextStyle(
//               color: context.colorScheme.error,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../../core/extensions/build_context_extensions.dart';
// import '../../../../auth/presentation/cubits/auth/auth_cubit.dart';

// /// Displays an alert dialog confirming sign-out intent before triggering data mutations
// void showLogoutConfirmationDialog(BuildContext context) {
//   final l10n = context.l10n; // 🎯 Capture l10n from the parent context

//   showDialog(
//     context: context,
//     builder: (dialogContext) => AlertDialog(
//       title: Text(l10n.signOut), // 🎯 Localized
//       content: Text(l10n.signOutContent), // 🎯 Localized
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(dialogContext),
//           child: Text(
//             l10n.cancel, // 🎯 Localized
//             style: TextStyle(color: context.colorScheme.onSurfaceVariant),
//           ),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.pop(dialogContext);
//             context.read<AuthCubit>().logout();
//           },
//           child: Text(
//             l10n.signOut, // 🎯 Localized
//             style: TextStyle(
//               color: context.colorScheme.error,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/global/presentation/widgets/sevika_alert_dialog.dart'; // 🎯 IMPORT HELPER
import '../../../../auth/presentation/cubits/auth/auth_cubit.dart';

/// Displays an alert dialog confirming sign-out intent before triggering data mutations
void showLogoutConfirmationDialog(BuildContext context) {
  final l10n = context.l10n;

  showSevikaAlertDialog(
    context: context,
    title: l10n.signOut,
    content: l10n.signOutContent,

    isDestructive: true, // 🔴 Makes primary text red and bold
    primaryIsFilled:
        false, // Keeps it as a subtle TextButton (standard for logouts)

    secondaryActionText: l10n.cancel,

    primaryActionText: l10n.signOut,
    onPrimaryAction: () {
      Navigator.pop(context);
      context.read<AuthCubit>().logout();
    },
  );
}
