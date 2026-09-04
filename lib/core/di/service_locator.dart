import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core imports
import '../../features/notification/presentation/cubits/setting/notification_setting_cubit.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../presentation/cubits/network_cubit.dart';
import '../services/push_notification_service.dart';
import '../services/permission_service.dart'; // 🎯 ADDED: Import the Permission Service
import '../storage/auth_token_manager.dart';
import '../storage/local_storage_service.dart';
import '../storage/onboarding_storage_service.dart';
import '../storage/token_storage_service.dart';
import '../storage/search_history_manager.dart';
import '../presentation/cubits/theme_cubit.dart';
// 🎯 ADDED: Import the new Language Cubit
import '../presentation/cubits/language_cubit.dart';
import '../../features/auth/presentation/cubits/onboarding/onboarding_cubit.dart';

// 🚀 IMPORT YOUR NEW INJECTORS HERE
import 'injectors/app_config_injector.dart';
import 'injectors/auth_injector.dart';
import 'injectors/address_injector.dart';
import 'injectors/booking_injector.dart';
import 'injectors/chat_injector.dart';
import 'injectors/emergency_injector.dart';
import 'injectors/injection_container.dart';
import 'injectors/location_injector.dart';
import 'injectors/marketplace_injector.dart';
import 'injectors/profile_injector.dart';
import 'injectors/notification_injector.dart';

// 💰 NEW FINANCIAL INJECTORS
import 'injectors/wallet_injector.dart';
import 'injectors/earnings_injector.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  await sl.reset();

  // ---------------------------------------------------------------------------
  // 1. EXTERNAL / THIRD-PARTY DEPENDENCIES
  // ---------------------------------------------------------------------------
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  // ---------------------------------------------------------------------------
  // 2. CORE UTILITIES & CORE SERVICES
  // ---------------------------------------------------------------------------
  // 🎯 Cleaned up: No longer needs sl() passed in!
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton<LocalStorageService>(
    () => LocalStorageServiceImpl(sl()),
  );
  sl.registerLazySingleton<TokenStorageService>(
    () => TokenStorageServiceImpl(sl()),
  );
  sl.registerLazySingleton<AuthTokenManager>(() => AuthTokenManager(sl()));
  sl.registerLazySingleton<OnboardingStorageService>(
    () => OnboardingStorageService(sl()),
  );

  sl.registerLazySingleton<SearchHistoryManager>(
    () => SearchHistoryManager(sl()),
  );

  sl.registerLazySingleton<DioClient>(() => DioClient(sl()));

  // 🎯 FCM Push Notification Service
  sl.registerLazySingleton<PushNotificationService>(
    () => PushNotificationService(updateFcmTokenUseCase: sl()),
  );

  // 🎯 ADDED: Permission Service
  // Abstracted hardware/OS permission logic globally available for injection
  sl.registerLazySingleton<PermissionService>(() => PermissionService());

  // ---------------------------------------------------------------------------
  // APP-LEVEL GLOBALS
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

  // 🎯 Register the Language Cubit as a singleton so the entire app shares one instance
  sl.registerLazySingleton<LanguageCubit>(() => LanguageCubit());

  // 🎯 Register the Network Cubit as a singleton
  sl.registerLazySingleton<NetworkCubit>(() => NetworkCubit());

  // 🎯 ADDED: Register the NotificationSettingsCubit as a global singleton
  // so the Settings Page and Auth system share the same preference cache
  sl.registerLazySingleton<NotificationSettingsCubit>(
    () => NotificationSettingsCubit(
      localStorage: sl(),
      toggleUseCase: sl(), // Note: Make sure ToggleNotificationPreferenceUseCase is registered in notification_injector.dart!
      pushNotificationService: sl(),
    ),
  );

  sl.registerFactory<OnboardingCubit>(() => OnboardingCubit(sl()));

  // ---------------------------------------------------------------------------
  // 3. INITIALIZE FEATURE MODULES
  // ---------------------------------------------------------------------------
  initAppConfig(sl);
  initLocation(sl);
  initAuth(sl);
  initAddress(sl);
  initNotification(sl);
  initProfile(sl);
  initCall(sl);
  initBooking(sl);
  initChat(sl);
  initEmergency(sl);
  initMarketplace(sl);
  initWallet(sl);
  initEarnings(sl);
}
