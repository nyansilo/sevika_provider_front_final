// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../core/presentation/cubits/theme_cubit.dart';
// import '../widgets/theme/theme_radio_tile.dart'; // 👈 Adjust this import to wherever you saved the file

// class AppThemeScreen extends StatelessWidget {
//   const AppThemeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('App Appearance'), centerTitle: true),
//       body: BlocBuilder<ThemeCubit, ThemeMode>(
//         builder: (context, currentThemeMode) {
//           // 🎯 ADDED: RadioGroup ancestor to manage the values of all Radio children
//           return RadioGroup<ThemeMode>(
//             groupValue: currentThemeMode,
//             onChanged: (ThemeMode? newMode) {
//               if (newMode != null) {
//                 context.read<ThemeCubit>().updateTheme(newMode);
//               }
//             },
//             child: ListView(
//               padding: const EdgeInsets.all(16.0),
//               // 🎯 BONUS: Because RadioGroup handles the dynamic state,
//               // all the children inside this ListView can now be 'const'
//               children: const [
//                 Padding(
//                   padding: EdgeInsets.only(bottom: 16.0, left: 8.0),
//                   child: Text(
//                     'Theme Preferences',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),

//                 // --- System Default Option ---
//                 ThemeRadioTile(
//                   title: 'System Default',
//                   subtitle: 'Matches your device settings',
//                   icon: Icons.brightness_auto,
//                   value: ThemeMode.system,
//                 ),
//                 Divider(),

//                 // --- Light Mode Option ---
//                 ThemeRadioTile(
//                   title: 'Light Mode',
//                   subtitle: 'Clean and bright',
//                   icon: Icons.light_mode,
//                   value: ThemeMode.light,
//                 ),
//                 Divider(),

//                 // --- Dark Mode Option ---
//                 ThemeRadioTile(
//                   title: 'Dark Mode',
//                   subtitle: 'Easy on the eyes',
//                   icon: Icons.dark_mode,
//                   value: ThemeMode.dark,
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/global/presentation/cubits/theme_cubit.dart';
// 🎯 ADDED: Import your build context extensions for l10n
import '../../../../core/extensions/build_context_extensions.dart';
import '../widgets/theme/theme_radio_tile.dart';

class AppThemeScreen extends StatelessWidget {
  const AppThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🎯 Cache the localization instance
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appAppearance), // 🎯 Localized
        centerTitle: true,
      ),
      body: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, currentThemeMode) {
          return RadioGroup<ThemeMode>(
            groupValue: currentThemeMode,
            onChanged: (ThemeMode? newMode) {
              if (newMode != null) {
                context.read<ThemeCubit>().updateTheme(newMode);
              }
            },
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              // 🚀 FIXED: Removed 'const' here because l10n is dynamic at runtime
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, left: 8.0),
                  child: Text(
                    l10n.themePreferences, // 🎯 Localized
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // --- System Default Option ---
                ThemeRadioTile(
                  title: l10n.systemDefault, // 🎯 Localized
                  subtitle: l10n.systemDefaultSubtitle, // 🎯 Localized
                  icon: Icons.brightness_auto,
                  value: ThemeMode.system,
                ),
                const Divider(),

                // --- Light Mode Option ---
                ThemeRadioTile(
                  title: l10n.lightMode, // 🎯 Localized
                  subtitle: l10n.lightModeSubtitle, // 🎯 Localized
                  icon: Icons.light_mode,
                  value: ThemeMode.light,
                ),
                const Divider(),

                // --- Dark Mode Option ---
                ThemeRadioTile(
                  title: l10n.darkMode, // 🎯 Localized
                  subtitle: l10n.darkModeSubtitle, // 🎯 Localized
                  icon: Icons.dark_mode,
                  value: ThemeMode.dark,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
