// import 'package:flutter/material.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';

// class ThemeCubit extends HydratedCubit<ThemeMode> {
//   // 1. Set System Default as the fallback initial state
//   ThemeCubit() : super(ThemeMode.system);

//   /// Updates the application's active theme
//   void updateTheme(ThemeMode themeMode) => emit(themeMode);

//   /// 2. Restore state from local storage on app initialization
//   @override
//   ThemeMode? fromJson(Map<String, dynamic> json) {
//     try {
//       final index = json['themeIndex'] as int;
//       return ThemeMode.values[index];
//     } catch (_) {
//       return ThemeMode.system;
//     }
//   }

//   /// 3. Automatically cache state changes to local storage
//   @override
//   Map<String, dynamic>? toJson(ThemeMode state) {
//     return {'themeIndex': state.index};
//   }
// }

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  // 1. Set System Default as the fallback initial state
  ThemeCubit() : super(ThemeMode.system);

  /// Updates the application's active theme
  void updateTheme(ThemeMode themeMode) => emit(themeMode);

  /// 2. Restore state from local storage on app initialization
  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    try {
      // 🎯 UPDATED: Read the exact string name instead of an integer index
      final themeName = json['theme_mode'] as String?;

      return switch (themeName) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system, // Fallback to system if null or unknown
      };
    } catch (_) {
      return ThemeMode.system;
    }
  }

  /// 3. Automatically cache state changes to local storage
  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    // 🎯 UPDATED: Store the enum's string name (e.g., 'light', 'dark', 'system')
    return {'theme_mode': state.name};
  }
}
