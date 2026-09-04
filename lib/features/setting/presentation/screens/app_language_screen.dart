// import 'package:flutter/material.dart';
// import '../../../../core/constants/app_dimensions.dart';
// import '../../../../core/extensions/build_context_extensions.dart'; // Imported context layer shortcuts
// import '../widgets/language/language_selector_tile.dart';

// class AppLanguageScreen extends StatefulWidget {
//   const AppLanguageScreen({super.key});

//   @override
//   State<AppLanguageScreen> createState() => _AppLanguageScreenState();
// }

// class _AppLanguageScreenState extends State<AppLanguageScreen> {
//   // Local active locale pipeline tracker (Defaulting to English)
//   String _selectedLanguageCode = 'en';

//   final List<Map<String, String>> _languages = [
//     {'code': 'en', 'name': 'English', 'nativeName': 'English (United Kingdom)'},
//     {'code': 'sw', 'name': 'Swahili', 'nativeName': 'Kiswahili (Tanzania)'},
//   ];

//   void _handleLanguageChange(String code) {
//     setState(() => _selectedLanguageCode = code);

//     // Quick interactive toast feedback before configuration syncs to engine state
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           code == 'sw'
//               ? 'Lugha imebadilishwa kuwa Kiswahili'
//               : 'Language updated to English',
//         ),
//         duration: const Duration(seconds: 1),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.colorScheme.surface,
//       appBar: AppBar(
//         backgroundColor: context.colorScheme.surface,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios_new_rounded,
//             size: AppDimensions.iconS,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'App Language',
//           style: context.textTheme.titleMedium?.copyWith(
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
//             child: ListView.separated(
//               padding: const EdgeInsets.all(AppDimensions.paddingM),
//               itemCount: _languages.length,
//               separatorBuilder: (context, index) => AppDimensions.gapM,
//               itemBuilder: (context, index) {
//                 final lang = _languages[index];
//                 final isSelected = _selectedLanguageCode == lang['code'];

//                 return LanguageSelectorTile(
//                   languageName: lang['name']!,
//                   nativeName: lang['nativeName']!,
//                   isSelected: isSelected,
//                   onTap: () => _handleLanguageChange(lang['code']!),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart'; // 🎯 ADDED: Bloc import

// import '../../../../core/constants/app_dimensions.dart';
// import '../../../../core/extensions/build_context_extensions.dart';
// import '../../../../core/presentation/cubits/language_cubit.dart'; // 🎯 ADDED: Language Cubit
// import '../widgets/language/language_selector_tile.dart';

// // 🚀 FIXED: Converted to StatelessWidget since Cubit handles the state now
// class AppLanguageScreen extends StatelessWidget {
//   const AppLanguageScreen({super.key});

//   static const List<Map<String, String>> _languages = [
//     {'code': 'en', 'name': 'English', 'nativeName': 'English (United Kingdom)'},
//     {'code': 'sw', 'name': 'Swahili', 'nativeName': 'Kiswahili (Tanzania)'},
//     {'code': 'zh', 'name': 'Chinese', 'nativeName': '中文 (Chinese)'}, // 🎯 ADDED
//   ];

//   @override
//   Widget build(BuildContext context) {
//     // 🎯 1. Watch the global language state natively
//     final selectedLanguageCode = context
//         .watch<LanguageCubit>()
//         .state
//         .languageCode;

//     return Scaffold(
//       backgroundColor: context.colorScheme.surface,
//       appBar: AppBar(
//         backgroundColor: context.colorScheme.surface,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios_new_rounded,
//             size: AppDimensions.iconS,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           // 🎯 2. Use your new BuildContext extension for instant translation
//           context.l10n.changeLanguage,
//           style: context.textTheme.titleMedium?.copyWith(
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
//             child: ListView.separated(
//               padding: const EdgeInsets.all(AppDimensions.paddingM),
//               itemCount: _languages.length,
//               separatorBuilder: (context, index) => AppDimensions.gapM,
//               itemBuilder: (context, index) {
//                 final lang = _languages[index];

//                 // Compare current language code with tile code
//                 final isSelected = selectedLanguageCode == lang['code'];

//                 return LanguageSelectorTile(
//                   languageName: lang['name']!,
//                   nativeName: lang['nativeName']!,
//                   isSelected: isSelected,
//                   onTap: () {
//                     // 🎯 3. Trigger global language change
//                     context.read<LanguageCubit>().changeLanguage(lang['code']!);

//                     // 🎯 4. Use your custom UI layer snackbar extension
//                     context.showSnackBar(
//                       lang['code'] == 'sw'
//                           ? 'Lugha imebadilishwa kuwa Kiswahili'
//                           : lang['code'] == 'zh'
//                           ? '语言已更新为中文'
//                           : 'Language updated to English',
//                       type: SnackBarType.success,
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/presentation/cubits/language_cubit.dart';
import '../widgets/language/language_selector_tile.dart';

class AppLanguageScreen extends StatelessWidget {
  const AppLanguageScreen({super.key});

  static const List<Map<String, String>> _languages = [
    {'code': 'en', 'name': 'English', 'nativeName': 'English (United Kingdom)'},
    {'code': 'sw', 'name': 'Swahili', 'nativeName': 'Kiswahili (Tanzania)'},
    {'code': 'zh', 'name': 'Chinese', 'nativeName': '中文 (Chinese)'},
  ];

  @override
  Widget build(BuildContext context) {
    final selectedLanguageCode = context
        .watch<LanguageCubit>()
        .state
        .languageCode;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: AppDimensions.iconS,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.changeLanguage,
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
            child: ListView.separated(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              itemCount: _languages.length,
              separatorBuilder: (context, index) => AppDimensions.gapM,
              itemBuilder: (context, index) {
                final lang = _languages[index];
                final isSelected = selectedLanguageCode == lang['code'];

                return LanguageSelectorTile(
                  languageName: lang['name']!,
                  nativeName: lang['nativeName']!,
                  isSelected: isSelected,
                  onTap: () {
                    context.read<LanguageCubit>().changeLanguage(lang['code']!);

                    // 🎯 Reads the translated success message directly!
                    context.showSnackBar(
                      l10n.languageChangedMsg,
                      type: SnackBarType.success,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
