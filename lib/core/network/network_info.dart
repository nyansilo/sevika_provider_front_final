import '../utils/network_helper.dart'; // 🎯 Import your new helper!

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  // You can keep this empty constructor so your Service Locator (sl) doesn't break!
  NetworkInfoImpl();

  @override
  Future<bool> get isConnected async {
    // 🚀 UPGRADE: Now uses your enterprise-grade Gatekeeper ping test
    // instead of just checking if the Wi-Fi antenna is turned on!
    return await NetworkHelper.hasInternetAccess();
  }
}
