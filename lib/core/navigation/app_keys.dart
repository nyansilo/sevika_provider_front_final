import 'package:flutter/material.dart';

abstract class AppKeys {
  /// 🌟 GLOBAL MESSENGER KEY: Emits floating notifications globally without contextual locks
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  /// 🧠 GLOBAL NAVIGATOR KEY: Manages root route transitions outside the widget tree
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}
