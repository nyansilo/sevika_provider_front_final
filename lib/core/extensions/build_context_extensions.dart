// import 'package:flutter/material.dart';
// import '../constants/app_dimensions.dart';

// /// Defines the different alert types for custom snackbars.
// enum SnackBarType { success, error, warning }

// extension BuildContextX on BuildContext {
//   ThemeData get theme => Theme.of(this);
//   TextTheme get textTheme => theme.textTheme;
//   ColorScheme get colorScheme => theme.colorScheme;

//   double get screenWidth => MediaQuery.of(this).size.width;
//   double get screenHeight => MediaQuery.of(this).size.height;
//   double get viewPaddingTop => MediaQuery.of(this).viewPadding.top;
//   double get viewInsetsBottom => MediaQuery.of(this).viewInsets.bottom;

//   // Responsive Breakpoint Helpers (Eliminates hardcoded `600` widths across views)
//   bool get isTablet => screenWidth > AppDimensions.maxModalBottomSheetWidth;
//   bool get isMobile => screenWidth <= AppDimensions.maxModalBottomSheetWidth;

//   void unfocusKeyboard() {
//     final currentFocus = FocusScope.of(this);
//     if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
//       FocusManager.instance.primaryFocus?.unfocus();
//     }
//   }

//   /// Displays a customizable SnackBar based on the [SnackBarType].
//   /// Defaults to [SnackBarType.success].
//   void showSnackBar(
//     String message, {
//     SnackBarType type = SnackBarType.success,
//   }) {
//     // Determine the background color based on the alert type
//     final backgroundColor = switch (type) {
//       SnackBarType.success =>
//         colorScheme
//             .primary, // Or colorScheme.secondary depending on your palette
//       SnackBarType.error => colorScheme.error,
//       SnackBarType.warning =>
//         Colors.orange[700] ?? Colors.orange, // Standard warning color fallback
//     };

//     // Optional: Determine an icon for a better user experience
//     final icon = switch (type) {
//       SnackBarType.success => Icons.check_circle_outline,
//       SnackBarType.error => Icons.error_outline,
//       SnackBarType.warning => Icons.warning_amber_rounded,
//     };

//     ScaffoldMessenger.of(this).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             Icon(icon, color: colorScheme.onPrimary),
//             const SizedBox(
//               width: AppDimensions.paddingS,
//             ), // Ensure this exists in your AppDimensions
//             Expanded(
//               child: Text(
//                 message,
//                 style: textTheme.bodyMedium?.copyWith(
//                   color: colorScheme.onPrimary,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: backgroundColor,
//         behavior: SnackBarBehavior.floating,
//         margin: const EdgeInsets.all(AppDimensions.paddingM),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.radiusS),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../constants/app_dimensions.dart';

// /// Defines the different alert types for custom snackbars.
// enum SnackBarType { success, error, warning }

// extension BuildContextX on BuildContext {
//   ThemeData get theme => Theme.of(this);
//   TextTheme get textTheme => theme.textTheme;
//   ColorScheme get colorScheme => theme.colorScheme;

//   double get screenWidth => MediaQuery.of(this).size.width;
//   double get screenHeight => MediaQuery.of(this).size.height;
//   double get viewPaddingTop => MediaQuery.of(this).viewPadding.top;
//   double get viewInsetsBottom => MediaQuery.of(this).viewInsets.bottom;

//   bool get isTablet => screenWidth > AppDimensions.maxModalBottomSheetWidth;
//   bool get isMobile => screenWidth <= AppDimensions.maxModalBottomSheetWidth;

//   void unfocusKeyboard() {
//     final currentFocus = FocusScope.of(this);
//     if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
//       FocusManager.instance.primaryFocus?.unfocus();
//     }
//   }

//   /// 🌟 GLOBAL TARGET: Displays the custom snackbar directly over the root messenger key channel
//   void showGlobalSnackBar(
//     String message, {
//     required GlobalKey<ScaffoldMessengerState> key,
//     SnackBarType type = SnackBarType.success,
//   }) {
//     final messengerState = key.currentState;
//     if (messengerState == null) return;

//     messengerState.hideCurrentSnackBar();
//     messengerState.showSnackBar(_buildSnackBarForm(message, type));
//   }

//   /// Displays a customizable SnackBar based on the [SnackBarType] via local Tree Lookup.
//   void showSnackBar(
//     String message, {
//     SnackBarType type = SnackBarType.success,
//   }) {
//     final messengerState = ScaffoldMessenger.maybeOf(this);
//     if (messengerState == null) return;

//     messengerState.hideCurrentSnackBar();
//     messengerState.showSnackBar(_buildSnackBarForm(message, type));
//   }

//   /// Internal builder engine protecting layout uniformity across local and global variants
//   SnackBar _buildSnackBarForm(String message, SnackBarType type) {
//     final backgroundColor = switch (type) {
//       SnackBarType.success => colorScheme.primary,
//       SnackBarType.error => colorScheme.error,
//       SnackBarType.warning => Colors.orange[700] ?? Colors.orange,
//     };

//     final icon = switch (type) {
//       SnackBarType.success => Icons.check_circle_outline,
//       SnackBarType.error => Icons.error_outline,
//       SnackBarType.warning => Icons.warning_amber_rounded,
//     };

//     return SnackBar(
//       content: Row(
//         children: [
//           Icon(icon, color: colorScheme.onPrimary),
//           const SizedBox(width: AppDimensions.paddingS),
//           Expanded(
//             child: Text(
//               message,
//               style: textTheme.bodyMedium?.copyWith(
//                 color: colorScheme.onPrimary,
//               ),
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: backgroundColor,
//       behavior: SnackBarBehavior.floating,
//       margin: const EdgeInsets.all(AppDimensions.paddingM),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppDimensions.radiusS),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';
import '../l10n/arb/app_localizations.dart';

/// Defines the different alert types for custom snackbars.
enum SnackBarType {
  success,
  error,
  warning,
  info,
} // 🚀 FIXED: Added info constant tier here

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  AppLocalizations get l10n => AppLocalizations.of(this)!;

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get viewPaddingTop => MediaQuery.of(this).viewPadding.top;
  double get viewInsetsBottom => MediaQuery.of(this).viewInsets.bottom;

  bool get isTablet => screenWidth > AppDimensions.maxModalBottomSheetWidth;
  bool get isMobile => screenWidth <= AppDimensions.maxModalBottomSheetWidth;

  // bool get isMobile => screenWidth < 600;
  // // A standard tablet breakpoint is usually between 600px and 900px
  // bool get isTablet => screenWidth >= 600 && screenWidth < 900;
  // bool get isDesktop => screenWidth >= 900;

  void unfocusKeyboard() {
    final currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  /// Displays a standardized offline error message using your custom UI design
  void showOfflineSnackBar() {
    showSnackBar(
      // 🎯 You can replace this string with l10n.offlineError if you add it to your ARB file!
      'Still offline. Please check your connection and try again.',
      type: SnackBarType.error,
    );
  }

  /// 🌟 GLOBAL TARGET: Displays the custom snackbar directly over the root messenger key channel
  void showGlobalSnackBar(
    String message, {
    required GlobalKey<ScaffoldMessengerState> key,
    SnackBarType type = SnackBarType.success,
  }) {
    final messengerState = key.currentState;
    if (messengerState == null) return;

    messengerState.hideCurrentSnackBar();
    messengerState.showSnackBar(_buildSnackBarForm(message, type));
  }

  /// Displays a customizable SnackBar based on the [SnackBarType] via local Tree Lookup.
  void showSnackBar(
    String message, {
    SnackBarType type = SnackBarType.success,
  }) {
    final messengerState = ScaffoldMessenger.maybeOf(this);
    if (messengerState == null) return;

    messengerState.hideCurrentSnackBar();
    messengerState.showSnackBar(_buildSnackBarForm(message, type));
  }

  /// Internal builder engine protecting layout uniformity across local and global variants
  SnackBar _buildSnackBarForm(String message, SnackBarType type) {
    // 🎨 RESOLVE DYNAMIC BACKDROP COLORS
    final backgroundColor = switch (type) {
      SnackBarType.success => colorScheme.primary,
      SnackBarType.error => colorScheme.error,
      SnackBarType.warning => Colors.orange[700] ?? Colors.orange,
      SnackBarType.info => colorScheme.secondary, // 🚀 FIXED: Maps info to theme secondary or surface tint accents cleanly
    };

    // 🎨 RESOLVE CONTEXTUAL INDICATOR ICONS
    final icon = switch (type) {
      SnackBarType.success => Icons.check_circle_outline,
      SnackBarType.error => Icons.error_outline,
      SnackBarType.warning => Icons.warning_amber_rounded,
      SnackBarType.info => Icons.info_outline_rounded, // 🚀 FIXED: System descriptive outline icon asset
    };

    return SnackBar(
      content: Row(
        children: [
          Icon(icon, color: colorScheme.onPrimary),
          const SizedBox(width: AppDimensions.paddingS),
          Expanded(
            child: Text(
              message,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(AppDimensions.paddingM),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
      ),
    );
  }
}
