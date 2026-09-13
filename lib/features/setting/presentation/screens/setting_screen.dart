import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart'; // 🎯 Pulls in your extension!
import '../../../../core/routes/route_list.dart';

// 🧠 IMPORT AUTH CUBIT
import '../../../auth/presentation/cubits/auth/auth_cubit.dart';
import '../../../auth/presentation/cubits/auth/auth_state.dart';

// 🧠 IMPORT SYSTEM CONFIGURATION CUBITS
import '../../../../core/global/presentation/cubits/theme_cubit.dart';
import '../../../../core/global/presentation/cubits/language_cubit.dart';

// 📦 IMPORT EXTRACTED UI COMPONENTS
import '../../../notification/presentation/cubits/setting/notification_setting_cubit.dart';
import '../../../notification/presentation/cubits/setting/notification_settings_state.dart';
import '../widgets/dialog/delete_account_dialog.dart';
import '../widgets/dialog/logout_dialog.dart';
import '../widgets/setting/settings_navigation_tile.dart';
import '../widgets/setting/settings_section_card.dart';
import '../widgets/setting/settings_toggle_tile.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _biometricAuth = false;

  @override
  Widget build(BuildContext context) {
    final currentLanguageCode = context
        .watch<LanguageCubit>()
        .state
        .languageCode;
    final l10n = context.l10n; // 🎯 Cached for absolute UI cleanliness

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const PopScope(
              canPop: false,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (state is AuthUnauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteList.welcomePage,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        appBar: AppBar(
          title: Text(l10n.setting), // 🎯 Localized
          backgroundColor: context.colorScheme.surface,
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppDimensions.maxDashboardWidth,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                child: Column(
                  children: [
                    // SECTION 1: PREFERENCES
                    SettingsSectionCard(
                      title: l10n.appPreferences, // 🎯 Localized
                      children: [
                        // 🔔 NOTIFICATION TOGGLE TILE
                        BlocConsumer<
                          NotificationSettingsCubit,
                          NotificationSettingsState
                        >(
                          listener: (context, state) {
                            // 🚀 INTEGRATED EXTENSION: Clean, 1-line UI feedback!
                            if (state.successMessage != null) {
                              context.showSnackBar(
                                state.successMessage!,
                                type: SnackBarType.success,
                              );
                            }
                            if (state.errorMessage != null) {
                              context.showSnackBar(
                                state.errorMessage!,
                                type: SnackBarType.error,
                              );
                            }
                          },
                          builder: (context, state) {
                            return SettingsToggleTile(
                              icon: Icons.notifications_active_rounded,
                              title: l10n.notification,
                              subtitle: l10n
                                  .pushNotificationsSubtitle, // 🎯 Localized
                              value: state.isEnabled,
                              onChanged: (val) {
                                context
                                    .read<NotificationSettingsCubit>()
                                    .toggleNotifications(val);
                              },
                            );
                          },
                        ),

                        // 🎨 THEME TOGGLE TILE
                        BlocBuilder<ThemeCubit, ThemeMode>(
                          builder: (context, themeMode) {
                            final currentThemeText = switch (themeMode) {
                              ThemeMode.light => l10n.lightMode, // 🎯 Localized
                              ThemeMode.dark => l10n.darkMode, // 🎯 Localized
                              ThemeMode.system =>
                                l10n.systemDefault, // 🎯 Localized
                            };

                            return SettingsNavigationTile(
                              icon: Icons.palette_rounded,
                              title: l10n.theme,
                              subtitle: currentThemeText,
                              onTap: () => Navigator.pushNamed(
                                context,
                                RouteList.appThemePage,
                              ),
                            );
                          },
                        ),

                        // 🌍 LANGUAGE SELECTOR TILE
                        SettingsNavigationTile(
                          icon: Icons.translate_rounded,
                          title: l10n.language,
                          subtitle: switch (currentLanguageCode) {
                            'sw' => 'Kiswahili',
                            'zh' => '中文 (Chinese)',
                            _ => 'English (US)',
                          },
                          onTap: () => Navigator.pushNamed(
                            context,
                            RouteList.appLanguagePage,
                          ),
                        ),
                      ],
                    ),

                    AppDimensions.gapL,

                    // SECTION 2: PRIVACY & SYSTEM PROTECTION
                    SettingsSectionCard(
                      title: l10n.securityPrivacy, // 🎯 Localized
                      children: [
                        SettingsNavigationTile(
                          icon: Icons.lock_outline_rounded,
                          title: l10n.changePassword,
                          subtitle: l10n.changePasswordSubtitle, // 🎯 Localized
                          onTap: () => Navigator.pushNamed(
                            context,
                            RouteList.changePasswordPage,
                          ),
                        ),
                        SettingsToggleTile(
                          icon: Icons.fingerprint_rounded,
                          title: l10n.biometricSecurityLock, // 🎯 Localized
                          subtitle: l10n.biometricSubtitle, // 🎯 Localized
                          value: _biometricAuth,
                          onChanged: (val) =>
                              setState(() => _biometricAuth = val),
                        ),
                        SettingsNavigationTile(
                          icon: Icons.privacy_tip_outlined,
                          title: l10n.systemDataPermissions, // 🎯 Localized
                          subtitle: l10n.systemDataSubtitle, // 🎯 Localized
                          onTap: () => Navigator.pushNamed(
                            context,
                            RouteList.systemPermissionsPage,
                          ),
                        ),
                      ],
                    ),

                    AppDimensions.gapL,

                    // SECTION 3: SYSTEM EXIT MANAGEMENT SYSTEM (DANGER ZONE)
                    SettingsSectionCard(
                      title: l10n.accountActions, // 🎯 Localized
                      children: [
                        SettingsNavigationTile(
                          icon: Icons.logout_rounded,
                          title: l10n.signOut,
                          subtitle: l10n.signOutSubtitle, // 🎯 Localized
                          onTap: () => showLogoutConfirmationDialog(context),
                        ),
                        SettingsNavigationTile(
                          icon: Icons.delete_forever_rounded,
                          title: l10n.deleteCustomerProfile, // 🎯 Localized
                          subtitle: l10n.deleteProfileSubtitle, // 🎯 Localized
                          isDestructiveColor: context.colorScheme.error,
                          onTap: () => showDeleteAccountDialog(context),
                        ),
                      ],
                    ),
                    AppDimensions.gapXXL,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
