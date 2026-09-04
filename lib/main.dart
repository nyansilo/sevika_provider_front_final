import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/l10n/arb/app_localizations.dart';
import 'core/presentation/app_global_listener_current.dart';
import 'core/di/service_locator.dart';

import 'core/presentation/cubits/language_cubit.dart';
import 'core/presentation/providers/app_bloc_provider.dart';
import 'core/presentation/screens/not_found_screen.dart';
import 'core/routes/route_list.dart';
import 'core/routes/routes.dart';
import 'core/routes/transitions.dart';

import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/navigation/app_keys.dart';
import 'core/config/app_theme.dart';
import 'core/presentation/cubits/theme_cubit.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_options.dart';

// 🎯 ADDED: Import our new background call handler service
import 'core/services/call_handler_service.dart';

/// 🚨 CRITICAL: MUST BE A TOP-LEVEL FUNCTION
///
/// When the app is in the background or killed, the OS spins up a headless
/// Flutter Isolate (a completely separate memory space) just to run this function.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // 1. Initialize Firebase for the isolated background thread
  // This is required before doing anything else in the background!
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint('🌙 [BACKGROUND FCM] Handled message: ${message.messageId}');

  // 2. 📞 DELEGATE TO NATIVE CALLKIT HANDLER
  // We pass the raw Firebase message to our cleanly architected Call Service.
  //If the payload is a call, this will wake the phone up and trigger the ringing UI.
  await handleBackgroundCall(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🎯 Initialize Firebase First for the main foreground application
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 🎯 Register the background handler with Firebase
  // This tells the OS to route invisible data-only payloads directly to the function above.
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // 💉 Setup Dependency Injection (GetIt)
  await setupServiceLocator();

  // 💾 Initialize HydratedBloc for persistent state (Theme, Language, etc.)
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory(
            (await getApplicationDocumentsDirectory()).path,
          ),
  );

  final appBlocs = AppBlocProvider();

  runApp(
    MultiBlocProvider(
      providers: appBlocs.providers,
      // 🎯 GlobalAppListener wraps the baseline to handle top-level events
      // (like pushing the user to the active call screen when they hit "Accept" in CallKit)
      child: Builder(
        builder: (context) {
          return GlobalAppListener(
            navigatorKey: AppKeys.navigatorKey,
            child: const SevikaApp(),
          );
        },
      ),
    ),
  );
}

class SevikaApp extends StatelessWidget {
  const SevikaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final locale = context.watch<LanguageCubit>().state;

    return MaterialApp(
      navigatorKey: AppKeys.navigatorKey,
      scaffoldMessengerKey: AppKeys.messengerKey,
      debugShowCheckedModeBanner: false,

      // 🚀 ENFORCE STARTUP SCREEN AS THE ONLY ENTRY POINT
      initialRoute: RouteList.initial,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      // 🌍 Localization settings
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate, // Your custom words (from ARB files)
        GlobalMaterialLocalizations.delegate, // Material widgets
        GlobalWidgetsLocalizations.delegate, // Text direction (LTR/RTL)
        GlobalCupertinoLocalizations.delegate, // Apple/iOS widgets
      ],

      // 🔀 Route Generation Engine
      onGenerateRoute: (RouteSettings settings) {
        final routes = Routes.getRoutes(settings);
        final WidgetBuilder? builder = routes[settings.name];

        if (builder != null) {
          return FadePageRouteBuilder(builder: builder, settings: settings);
        }

        // 🛑 Fallback 404 Route
        return FadePageRouteBuilder(
          builder: (_) => NotFoundScreen(attemptedRoute: settings.name),
          settings: settings,
        );
      },
    );
  }
}
