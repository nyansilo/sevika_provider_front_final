import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart'; // 📦 Required for opening the store URL

import '../../../../core/di/service_locator.dart';
import '../../../../core/global/presentation/widgets/sevika_alert_dialog.dart';
import '../../../../core/routes/route_list.dart';
import '../../../../core/storage/onboarding_storage_service.dart';
import '../../../app_config/presentation/cubit/app_config_cubit.dart';
import '../../../app_config/presentation/cubit/app_config_state.dart';
import '../../../app_config/presentation/screens/force_update_screen.dart';
import '../../../notification/presentation/cubits/notification/notifications_cubit.dart';
import '../../../shared/location/presentation/cubits/location/location_cubit.dart';
import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';

// 🎯 IMPORT YOUR OTHER CUBITS HERE (e.g., ProfileCubit, BoundariesCubit, etc.)

class StartUpScreen extends StatefulWidget {
  const StartUpScreen({super.key});

  @override
  State<StartUpScreen> createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> {
  late final AppConfigCubit _appConfigCubit;

  @override
  void initState() {
    super.initState();
    _appConfigCubit = sl<AppConfigCubit>();

    // 🚀 1. Trigger ONLY the version check immediately on startup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _appConfigCubit.checkAppVersion();
    });
  }

  @override
  void dispose() {
    _appConfigCubit.close();
    super.dispose();
  }

  /// 💬 Shows a dismissible dialog for optional updates
  void _showSoftUpdateDialog(BuildContext context, String storeUrl) {
    showSevikaAlertDialog(
      context: context,
      barrierDismissible: false,
      title: 'Update Available',
      content: 'A new version of Sevika is available with improvements and fixes. Would you like to update now?',
      icon:
          Icons.system_update_rounded, // Optional: Adds a nice icon at the top
      // Secondary Action (Later)
      secondaryActionText: 'Later',
      onSecondaryAction: () {
        Navigator.pop(context);
        _executeRouteRedirection(context, context.read<AuthCubit>().state);
      },

      // Primary Action (Update Now)
      primaryActionText: 'Update Now',
      primaryIsFilled: true, // Makes it a solid prominent button
      onPrimaryAction: () async {
        final url = Uri.parse(storeUrl);
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }

        if (context.mounted) {
          Navigator.pop(context);
          _executeRouteRedirection(context, context.read<AuthCubit>().state);
        }
      },
    );
  }

  /// 🔄 Handles Auth/Onboarding routing AFTER AppConfig says it's safe
  void _executeRouteRedirection(BuildContext context, AuthState state) {
    if (!context.mounted) return;

    if (state is AuthAuthenticated) {
      // 🚀 2. NOW IT IS SAFE TO LOAD DATA!
      // Trigger data fetches safely now!
      context.read<LocationCubit>().fetchAdministrativeBoundaries();
      context.read<NotificationsCubit>().loadNotifications();

      // 🛡️ Note on KYC: We deliberately DO NOT fetch KYC status during
      // app startup to keep the boot sequence ultra-fast. It is fetched
      // silently in the background when the ProfileDashboard screen builds!

      Navigator.pushReplacementNamed(context, RouteList.mainPage);
    } else if (state is AuthUnauthenticated || state is AuthError) {
      final bool onboardingDone = sl<OnboardingStorageService>()
          .isOnboardingDone();

      if (onboardingDone) {
        Navigator.pushReplacementNamed(context, RouteList.loginPage);
      } else {
        Navigator.pushReplacementNamed(context, RouteList.onBoardingPage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // 1️⃣ FIRST LISTENER: Waits for the App Version Check
        BlocListener<AppConfigCubit, AppConfigState>(
          bloc: _appConfigCubit,
          listener: (context, state) {
            if (state is AppConfigUpdateRequired) {
              // 🛑 FORCE UPDATE REQUIRED: Bypass everything and trap them on this screen
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) =>
                      ForceUpdateScreen(storeUrl: state.storeUrl),
                ),
                (route) => false,
              );
            } else if (state is AppConfigUpToDate) {
              // 🟡 SOFT UPDATE: Show the dialog instead of instantly routing
              if (state.isSoftUpdateAvailable && state.storeUrl != null) {
                _showSoftUpdateDialog(context, state.storeUrl!);
              }
              // ✅ UP TO DATE: Hand control directly over to Auth logic
              else {
                _executeRouteRedirection(
                  context,
                  context.read<AuthCubit>().state,
                );
              }
            } else if (state is AppConfigFailure) {
              // 🛡️ API FAILED: Let them into the app safely
              _executeRouteRedirection(
                context,
                context.read<AuthCubit>().state,
              );
            }
          },
        ),

        // 2️⃣ SECOND LISTENER: Listens for Auth changes
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            // Only respond to Auth changes IF the version check has already cleared them
            final configState = _appConfigCubit.state;
            if (configState is AppConfigUpToDate ||
                configState is AppConfigFailure) {
              _executeRouteRedirection(context, state);
            }
          },
        ),
      ],
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
