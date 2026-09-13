import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/network_helper.dart';

enum NetworkState { initial, online, offline }

// 1. Added <NetworkState> to strongly type the Cubit
class NetworkCubit extends Cubit<NetworkState> {
  // 2. Fixed the generic type for StreamSubscription
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  NetworkCubit() : super(NetworkState.initial) {
    _monitorNetwork();
  }

  void _monitorNetwork() {
    // 3. Strongly typed the results parameter
    _subscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) async {
      final hasInternet = await NetworkHelper.hasInternetAccess();

      if (hasInternet) {
        emit(NetworkState.online);
      } else {
        emit(NetworkState.offline);
      }
    });
  }

  /// Manually trigger a check (useful for app boot and pull-to-refresh)
  // 4. Added <void> to the Future return type
  Future<void> checkCurrentStatus() async {
    final hasInternet = await NetworkHelper.hasInternetAccess();
    emit(hasInternet ? NetworkState.online : NetworkState.offline);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
