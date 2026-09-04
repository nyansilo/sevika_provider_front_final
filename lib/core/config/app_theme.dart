// This file brings together your global Material 3 configurations, assigning your functional brand colors and
// integrating layout metrics directly

// import 'package:flutter/material.dart';
// import '../constants/app_colors.dart';
// import '../constants/app_dimensions.dart';

// class AppTheme {
//   /// LIGHT THEME CONFIGURATION MATRIX
//   static ThemeData get lightTheme {
//     final baseColorScheme = ColorScheme.fromSeed(
//       seedColor: AppColors.primary,
//       brightness: Brightness.light,
//       surface: AppColors.surface,
//       onSurface: AppColors.onSurface,
//       onSurfaceVariant: AppColors.onSurfaceVariant,
//       outlineVariant: AppColors.outlineVariant,
//     );

//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.light,
//       colorScheme: baseColorScheme,
//       scaffoldBackgroundColor: baseColorScheme.surface,

//       // AppBar Custom Layout Styles
//       appBarTheme: AppBarTheme(
//         backgroundColor: baseColorScheme.surface,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         centerTitle: true,
//         iconTheme: IconThemeData(
//           color: baseColorScheme.onSurface,
//           size: AppDimensions.iconS,
//         ),
//         titleTextStyle: TextStyle(
//           color: baseColorScheme.onSurface,
//           fontSize: 16.0,
//           fontWeight: FontWeight.bold,
//         ),
//       ),

//       // Input Decoration (TextFields & Forms)
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: baseColorScheme.surfaceContainerLow,
//         contentPadding: const EdgeInsets.all(AppDimensions.paddingM),
//         labelStyle: TextStyle(color: baseColorScheme.onSurfaceVariant),
//         prefixStyle: TextStyle(
//           color: baseColorScheme.primary,
//           fontWeight: FontWeight.bold,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//           borderSide: BorderSide(color: baseColorScheme.outlineVariant),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//           borderSide: BorderSide(
//             color: baseColorScheme.outlineVariant.withValues(alpha: 0.5),
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//           borderSide: BorderSide(
//             color: baseColorScheme.primary,
//             width: AppDimensions.borderThicknessMedium,
//           ),
//         ),
//       ),

//       // Buttons Design Token Enforcements
//       filledButtonTheme: FilledButtonThemeData(
//         style: FilledButton.styleFrom(
//           backgroundColor: baseColorScheme.primary,
//           foregroundColor: baseColorScheme.onPrimary,
//           padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//           ),
//           textStyle: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 15.0,
//           ),
//         ),
//       ),

//       // Chips UI Design Patterns (Filter & Preset Balances)
//       chipTheme: ChipThemeData(
//         labelPadding: const EdgeInsets.symmetric(
//           horizontal: AppDimensions.paddingS,
//         ),
//         padding: EdgeInsets.zero,
//         side: BorderSide(color: baseColorScheme.outlineVariant),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.radiusS),
//         ),
//       ),

//       // FIXED: Swapped out CardTheme for CardThemeData configuration structure
//       cardTheme: CardThemeData(
//         color: baseColorScheme.surfaceContainerLow,
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//         ),
//       ),

//       // Radio & RadioListTile Configuration Accent mapping
//       radioTheme: RadioThemeData(
//         fillColor: WidgetStateProperty.resolveWith<Color>((states) {
//           if (states.contains(WidgetState.selected)) {
//             return baseColorScheme.primary;
//           }
//           return baseColorScheme.onSurfaceVariant;
//         }),
//       ),
//     );
//   }

//   /// DARK THEME CONFIGURATION MATRIX
//   static ThemeData get darkTheme {
//     final baseColorScheme = ColorScheme.fromSeed(
//       seedColor: AppColors.primary,
//       brightness: Brightness.dark,
//       surface: const Color(0xFF12131A),
//       onSurface: const Color(0xFFE4E1E9),
//       onSurfaceVariant: const Color(0xFFC5C6D0),
//       outlineVariant: const Color(0xFF45464F),
//     );

//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.dark,
//       colorScheme: baseColorScheme,
//       scaffoldBackgroundColor: baseColorScheme.surface,

//       // AppBar Custom Layout Styles (Dark Mode)
//       appBarTheme: AppBarTheme(
//         backgroundColor: baseColorScheme.surface,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         centerTitle: true,
//         iconTheme: IconThemeData(
//           color: baseColorScheme.onSurface,
//           size: AppDimensions.iconS,
//         ),
//         titleTextStyle: TextStyle(
//           color: baseColorScheme.onSurface,
//           fontSize: 16.0,
//           fontWeight: FontWeight.bold,
//         ),
//       ),

//       // Input Decoration (TextFields & Forms)
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: baseColorScheme.surfaceContainerLow,
//         contentPadding: const EdgeInsets.all(AppDimensions.paddingM),
//         labelStyle: TextStyle(color: baseColorScheme.onSurfaceVariant),
//         prefixStyle: TextStyle(
//           color: baseColorScheme.primaryContainer,
//           fontWeight: FontWeight.bold,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//           borderSide: BorderSide(color: baseColorScheme.outlineVariant),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//           borderSide: BorderSide(
//             color: baseColorScheme.outlineVariant.withValues(alpha: 0.4),
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//           borderSide: BorderSide(
//             color: baseColorScheme.primaryContainer,
//             width: AppDimensions.borderThicknessMedium,
//           ),
//         ),
//       ),

//       // Buttons Design Token Enforcements
//       filledButtonTheme: FilledButtonThemeData(
//         style: FilledButton.styleFrom(
//           backgroundColor: baseColorScheme.primaryContainer,
//           foregroundColor: baseColorScheme.onPrimaryContainer,
//           padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//           ),
//           textStyle: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 15.0,
//           ),
//         ),
//       ),

//       // Chips UI Design Patterns (Dark Mode)
//       chipTheme: ChipThemeData(
//         backgroundColor: baseColorScheme.surfaceContainerLow,
//         labelPadding: const EdgeInsets.symmetric(
//           horizontal: AppDimensions.paddingS,
//         ),
//         padding: EdgeInsets.zero,
//         side: BorderSide(color: baseColorScheme.outlineVariant),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.radiusS),
//         ),
//       ),

//       // FIXED: Swapped out CardTheme for CardThemeData configuration structure
//       cardTheme: CardThemeData(
//         color: baseColorScheme.surfaceContainerLow,
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//         ),
//       ),

//       // Radio Component Context Accent mapping
//       radioTheme: RadioThemeData(
//         fillColor: WidgetStateProperty.resolveWith<Color>((states) {
//           if (states.contains(WidgetState.selected)) {
//             return baseColorScheme.primaryContainer;
//           }
//           return baseColorScheme.onSurfaceVariant;
//         }),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class AppTheme {
  const AppTheme._(); // Prevents instantiation

  /// LIGHT THEME CONFIGURATION MATRIX
  static ThemeData get lightTheme {
    final baseColorScheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ).copyWith(
          surface: AppColors.lightSurface,
          onSurface: AppColors.lightOnSurface,
          onSurfaceVariant: AppColors.lightOnSurfaceVariant,
          outline: AppColors.lightOutline,
          outlineVariant: AppColors.lightOutlineVariant,
          error: AppColors.errorLight,
          surfaceContainerLow: AppColors.lightSurfaceContainerLow,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: baseColorScheme,
      scaffoldBackgroundColor: baseColorScheme.surface,

      // AppBar Custom Layout Styles
      appBarTheme: AppBarTheme(
        backgroundColor: baseColorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: baseColorScheme.onSurface,
          size: AppDimensions.iconS,
        ),
        titleTextStyle: TextStyle(
          color: baseColorScheme.onSurface,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Input Decoration (TextFields & Forms)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: baseColorScheme.surfaceContainerLow,
        contentPadding: const EdgeInsets.all(AppDimensions.paddingM),
        labelStyle: TextStyle(color: baseColorScheme.onSurfaceVariant),
        prefixStyle: TextStyle(
          color: baseColorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(color: baseColorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(
            color: baseColorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(
            color: baseColorScheme.primary,
            width: AppDimensions.borderThicknessMedium,
          ),
        ),
      ),

      // Buttons Design Token Enforcements
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: baseColorScheme.primary,
          foregroundColor: AppColors.lightOnPrimary,
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
      ),

      // Chips UI Design Patterns (Filter & Preset Balances)
      chipTheme: ChipThemeData(
        labelPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingS,
        ),
        padding: EdgeInsets.zero,
        side: BorderSide(color: baseColorScheme.outlineVariant),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        ),
      ),

      // Card Container System Layout Architecture
      cardTheme: CardThemeData(
        color: baseColorScheme.surfaceContainerLow,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
      ),

      // Radio & RadioListTile Configuration Accent mapping
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return baseColorScheme.primary;
          }
          return baseColorScheme.onSurfaceVariant;
        }),
      ),
    );
  }

  /// DARK THEME CONFIGURATION MATRIX
  static ThemeData get darkTheme {
    final baseColorScheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ).copyWith(
          surface: AppColors.darkSurface,
          onSurface: AppColors.darkOnSurface,
          onSurfaceVariant: AppColors.darkOnSurfaceVariant,
          outline: AppColors.darkOutline,
          outlineVariant: AppColors.darkOutlineVariant,
          error: AppColors.errorDark,
          surfaceContainerLow: AppColors.darkSurfaceContainerLow,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: baseColorScheme,
      scaffoldBackgroundColor: baseColorScheme.surface,

      // AppBar Custom Layout Styles (Dark Mode)
      appBarTheme: AppBarTheme(
        backgroundColor: baseColorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: baseColorScheme.onSurface,
          size: AppDimensions.iconS,
        ),
        titleTextStyle: TextStyle(
          color: baseColorScheme.onSurface,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Input Decoration (TextFields & Forms)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: baseColorScheme.surfaceContainerLow,
        contentPadding: const EdgeInsets.all(AppDimensions.paddingM),
        labelStyle: TextStyle(color: baseColorScheme.onSurfaceVariant),
        prefixStyle: TextStyle(
          color: baseColorScheme.primaryContainer,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(color: baseColorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(
            color: baseColorScheme.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(
            color: baseColorScheme.primaryContainer,
            width: AppDimensions.borderThicknessMedium,
          ),
        ),
      ),

      // Buttons Design Token Enforcements
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: baseColorScheme.primaryContainer,
          foregroundColor: baseColorScheme.onPrimaryContainer,
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
      ),

      // Chips UI Design Patterns (Dark Mode)
      chipTheme: ChipThemeData(
        backgroundColor: baseColorScheme.surfaceContainerLow,
        labelPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingS,
        ),
        padding: EdgeInsets.zero,
        side: BorderSide(color: baseColorScheme.outlineVariant),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        ),
      ),

      // Card Container System Layout Architecture
      cardTheme: CardThemeData(
        color: baseColorScheme.surfaceContainerLow,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
      ),

      // Radio Component Context Accent mapping
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return baseColorScheme.primaryContainer;
          }
          return baseColorScheme.onSurfaceVariant;
        }),
      ),
    );
  }
}
