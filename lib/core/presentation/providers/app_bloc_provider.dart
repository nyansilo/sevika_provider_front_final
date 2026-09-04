import 'package:flutter_bloc/flutter_bloc.dart';

// =====================================================================
// FOUNDATIONAL PLATFORM INJECTIONS
// =====================================================================
import '../../../features/notification/presentation/cubits/notification/notifications_cubit.dart';
import '../../../features/notification/presentation/cubits/setting/notification_setting_cubit.dart';
import '../../../features/shared/location/presentation/cubits/location/location_cubit.dart';
import '../cubits/network_cubit.dart';
import '../cubits/theme_cubit.dart';
import '../cubits/language_cubit.dart';
import '../../di/service_locator.dart';
import '../../../features/auth/presentation/cubits/auth/auth_cubit.dart';
import '../../../features/auth/presentation/cubits/onboarding/onboarding_cubit.dart';

/// Central repository of absolute global core states.
/// Feature-specific states (Bookings, Payments, Catalog) are strictly route-scoped.
class AppBlocProvider {
  final List<BlocProvider> providers = [
    // 🎨 Platform UI State
    BlocProvider<ThemeCubit>(create: (_) => sl<ThemeCubit>()),

    // 🎯 ADDED: Inject LanguageCubit via service locator
    BlocProvider<LanguageCubit>(create: (_) => sl<LanguageCubit>()),

    // 🌐 🎯 FIXED: You MUST have <NetworkCubit> attached to the BlocProvider itself!
    BlocProvider<NetworkCubit>(
      create: (_) => sl<NetworkCubit>()..checkCurrentStatus(),
      lazy: false, // ✅ Safe: Only checks local device connectivity
    ),

    // 📍 Core Device Sensors & Environment
    // 🛑 REMOVED: ..fetchAdministrativeBoundaries() and lazy: false
    // This prevents the API from firing before the Force Update check completes.
    BlocProvider<LocationCubit>(create: (_) => sl<LocationCubit>()),

    // 🔐 Identity & Access Management
    // ✅ Safe: These only read from local Secure Storage / SharedPreferences (No APIs)
    BlocProvider<AuthCubit>(create: (_) => sl<AuthCubit>(), lazy: false),
    BlocProvider<OnboardingCubit>(
      create: (_) => sl<OnboardingCubit>()..checkOnboarding(),
      lazy: false,
    ),

    // 🔔 Global Background Sockets & Alerts
    // 🛑 REMOVED: ..loadNotifications() and lazy: false
    // This prevents the API and WebSocket from firing before the Force Update check completes.
    BlocProvider<NotificationsCubit>(create: (_) => sl<NotificationsCubit>()),

    // 🎯 ADDED: Global Notification Preferences
    // Injected at the root so any settings screen or auth interceptor can instantly access it!
    BlocProvider<NotificationSettingsCubit>(
      create: (_) => sl<NotificationSettingsCubit>(),
    ),
  ];
}
