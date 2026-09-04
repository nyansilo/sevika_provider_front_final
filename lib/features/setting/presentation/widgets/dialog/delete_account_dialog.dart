// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../../core/extensions/build_context_extensions.dart';
// import '../../../../auth/presentation/cubits/auth/auth_cubit.dart';

// void showDeleteAccountDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext dialogContext) {
//       return AlertDialog(
//         title: Row(
//           children: [
//             Icon(Icons.warning_amber_rounded, color: context.colorScheme.error),
//             const SizedBox(width: 8),
//             const Expanded(child: Text('Delete Account?')),
//           ],
//         ),
//         content: const Text(
//           'This action is irreversible. All your booking history, saved addresses, and profile data will be permanently wiped.\n\nAre you sure you want to proceed?',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(dialogContext).pop(),
//             child: const Text('Cancel'),
//           ),
//           FilledButton(
//             onPressed: () {
//               Navigator.of(dialogContext).pop(); // Close dialog
//               // 🎯 Trigger your API call here
//               context.read<AuthCubit>().deleteAccount();
//             },
//             style: FilledButton.styleFrom(
//               backgroundColor: context.colorScheme.error,
//               foregroundColor: context.colorScheme.onError,
//               // 🎯 Tweak padding to give the text slightly more breathing room
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             ),
//             // 🎯 FIXED: FittedBox forces the text to scale down dynamically
//             // if the screen width is too small, completely preventing overflow!
//             child: const FittedBox(
//               fit: BoxFit.scaleDown,
//               child: Text('Yes, Delete', maxLines: 1),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../../core/extensions/build_context_extensions.dart';
// import '../../../../auth/presentation/cubits/auth/auth_cubit.dart';

// void showDeleteAccountDialog(BuildContext context) {
//   final l10n = context.l10n; // 🎯 Capture l10n from the parent context

//   showDialog(
//     context: context,
//     builder: (BuildContext dialogContext) {
//       return AlertDialog(
//         title: Row(
//           children: [
//             Icon(Icons.warning_amber_rounded, color: context.colorScheme.error),
//             const SizedBox(width: 8),
//             Expanded(child: Text(l10n.deleteAccountTitle)), // 🎯 Localized
//           ],
//         ),
//         content: Text(l10n.deleteAccountContent), // 🎯 Localized
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(dialogContext).pop(),
//             child: Text(l10n.cancel), // 🎯 Localized
//           ),
//           FilledButton(
//             onPressed: () {
//               Navigator.of(dialogContext).pop();
//               context.read<AuthCubit>().deleteAccount();
//             },
//             style: FilledButton.styleFrom(
//               backgroundColor: context.colorScheme.error,
//               foregroundColor: context.colorScheme.onError,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             ),
//             child: FittedBox(
//               fit: BoxFit.scaleDown,
//               child: Text(l10n.yesDelete, maxLines: 1), // 🎯 Localized
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/presentation/widgets/sevika_alert_dialog.dart'; // 🎯 IMPORT HELPER
import '../../../../auth/presentation/cubits/auth/auth_cubit.dart';

void showDeleteAccountDialog(BuildContext context) {
  final l10n = context.l10n;

  showSevikaAlertDialog(
    context: context,
    title: l10n.deleteAccountTitle,
    content: l10n.deleteAccountContent,
    icon: Icons.warning_amber_rounded,

    isDestructive: true, // 🔴 Makes text/icon red
    primaryIsFilled: true, // 🔴 Makes the primary button a solid red block

    secondaryActionText: l10n.cancel,

    // onSecondaryAction is omitted, so it defaults to just closing the dialog
    primaryActionText: l10n.yesDelete,
    onPrimaryAction: () {
      Navigator.pop(context);
      context.read<AuthCubit>().deleteAccount();
    },
  );
}
