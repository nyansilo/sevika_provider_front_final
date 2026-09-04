import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// =====================================================================
// STATE MANAGEMENT & BUSINESS UTILITY INJECTIONS
// =====================================================================
import '../../features/notification/presentation/cubits/notification/notifications_cubit.dart'; // Ensure this is imported
import '../../features/notification/presentation/cubits/notification/notifications_state.dart';
import '../di/service_locator.dart';
import '../navigation/app_keys.dart';

// =====================================================================
// GLOBAL SYSTEM ERROR, ROUTE, & STORAGE SCHEMAS
// =====================================================================
import '../errors/app_error.dart';
import '../errors/error_messages.dart';
import '../extensions/build_context_extensions.dart';
import '../routes/route_list.dart';
import '../../features/auth/presentation/cubits/auth/auth_cubit.dart';
import '../../features/auth/presentation/cubits/auth/auth_state.dart';
import '../storage/auth_token_manager.dart';
import '../storage/onboarding_storage_service.dart';
import '../usecases/usecase.dart';
import 'cubits/network_cubit.dart';

class GlobalAppListener extends StatelessWidget {
  // 1. FIXED: Restored <NavigatorState> so Dart knows about pushNamed, popUntil, etc.
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;

  const GlobalAppListener({
    super.key,
    required this.navigatorKey,
    required this.child,
  });

  void _triggerGlobalToast(
    BuildContext context,
    String message, {
    required SnackBarType type,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final BuildContext? safeContext = navigatorKey.currentContext;
      if (safeContext != null && safeContext.mounted) {
        safeContext.showGlobalSnackBar(
          message,
          key: AppKeys.messengerKey,
          type: type,
        );
      }
    });
  }

  void _startNotificationBridge(BuildContext context, AuthAuthenticated state) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final tokenManager = sl<AuthTokenManager>();
      final String? token = await tokenManager.getAccessToken();
      if (token != null && token.isNotEmpty && context.mounted) {
        // 2. FIXED: Added <NotificationsCubit> type
        context.read<NotificationsCubit>().initLiveNotificationListener(
          userId: state.user.userId.toString(),
          token: token,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // =====================================================================
        // SECTION 1: GLOBAL NETWORK INTERCEPTOR (NEW)
        // =====================================================================
        // 3. FIXED: Added <NetworkCubit, NetworkState> types
        BlocListener<NetworkCubit, NetworkState>(
          listener: (context, state) {
            // 🎯 FIXED: Wait for Flutter to finish building the screen before navigating!
            // This completely prevents the White Screen timing crash on real devices.
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final navigator = navigatorKey.currentState;
              if (navigator == null) return;

              if (state == NetworkState.offline) {
                // 🛡️ Ensure we don't push the No Internet screen if it's already showing
                final currentRoute = ModalRoute.of(navigatorKey.currentContext!)
                    ?.settings
                    .name;
                if (currentRoute != RouteList.noInternetPage) {
                  navigator.pushNamed(RouteList.noInternetPage);
                }
              } else if (state == NetworkState.online) {
                // ✅ Automatically remove the No Internet screen if it is active!
                navigator.popUntil(
                  (route) => route.settings.name != RouteList.noInternetPage,
                );
              }
            });
          },
        ),

        // =====================================================================
        // SECTION 2: AUTHENTICATION LIFECYCLE MECHANICS
        // =====================================================================
        // 4. FIXED: Added <AuthCubit, AuthState> types
        BlocListener<AuthCubit, AuthState>(
          listenWhen: (previous, current) {
            if (current is AuthUnauthenticated || current is AuthError) {
              return true;
            }
            return (previous is! AuthAuthenticated &&
                    current is AuthAuthenticated) ||
                (previous is AuthAuthenticated &&
                    current is AuthAuthenticated &&
                    (current.error != previous.error ||
                        current.successMessage != previous.successMessage));
          },
          listener: (context, state) async {
            if (state is AuthAuthenticated) {
              _startNotificationBridge(context, state);

              if (state.successMessage != null) {
                _triggerGlobalToast(
                  context,
                  state.successMessage!,
                  type: SnackBarType.success,
                );
              }
              if (state.error != null) _handleAppError(context, state.error!);

              // 🛑 🚀 REMOVED: The logic that automatically pushed RouteList.mainPage has been deleted.
              // Startup routing is now strictly handled by the StartUpScreen!
            }

            if (state is AuthUnauthenticated) {
              try {
                // 5. FIXED: Added <NotificationsCubit> type
                context
                    .read<NotificationsCubit>()
                    .disconnectLiveNotificationsUseCase
                    .call(const NoParams());
              } catch (e) {
                debugPrint('⚠️ WebSocket disposal hook failed: $e');
              }

              // 🎯 CRITICAL NEW FIX: Display messages passed during unauthentication
              // If the user permanently deletes their account, this ensures the confirmation toast appears!
              if (state.message != null && state.message!.isNotEmpty) {
                _triggerGlobalToast(
                  context,
                  state.message!,
                  type: SnackBarType.success,
                );
              }

              // 🛡️ ✅ KEPT: We still want to kick users back to Login globally if their token expires mid-session.
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final bool onboardingDone = sl<OnboardingStorageService>()
                    .isOnboardingDone();
                final targetRoute = onboardingDone
                    ? RouteList.loginPage
                    : RouteList.onBoardingPage;
                navigatorKey.currentState?.pushNamedAndRemoveUntil(
                  targetRoute,
                  (route) => false,
                );
              });
            }

            if (state is AuthError) _handleAppError(context, state.error);
          },
        ),

        // =====================================================================
        // SECTION 3: REACTIVE SOCKET DISPATCH SYSTEM ACCELERATORS
        // =====================================================================
        // 6. FIXED: Added <NotificationsCubit, NotificationsState> types
        BlocListener<NotificationsCubit, NotificationsState>(
          listenWhen: (previous, current) =>
              current is NotificationActionFailure,
          listener: (context, state) {
            if (state is NotificationActionFailure) {
              _handleAppError(context, state.error);
            }
          },
        ),
      ],
      child: child,
    );
  }

  void _handleAppError(BuildContext context, AppError appError) {
    if (appError.type == AppErrorType.validation &&
        appError.validationErrors != null) {
      // 7. FIXED: Added <String> to the List type
      final List<String> allErrors = [];
      appError.validationErrors!.forEach((field, value) {
        if (value is List) {
          allErrors.addAll(value.map((msg) => msg.toString()));
        } else if (value is String) {
          allErrors.add(value);
        } else if (value != null) {
          allErrors.add(value.toString());
        }
      });
      final combinedMessage = allErrors.isNotEmpty
          ? allErrors.join('\n')
          : (appError.message ?? ErrorMessages.unknown);
      _triggerGlobalToast(context, combinedMessage, type: SnackBarType.error);
    } else {
      _triggerGlobalToast(
        context,
        appError.message ?? ErrorMessages.unknown,
        type: SnackBarType.error,
      );
    }
  }
}
