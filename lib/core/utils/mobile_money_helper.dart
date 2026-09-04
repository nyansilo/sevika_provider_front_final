import '../constants/app_assets.dart';
import '../constants/string_constants.dart';

class MobileMoneyHelper {
  const MobileMoneyHelper._();

  /// Determines the accurate mobile network carrier string from prefixes.
  static String detectChannel(String phoneNumber) {
    final clean = phoneNumber.replaceAll(RegExp(r'\s+|\+'), '');
    String prefix = '';

    if (clean.startsWith('255') && clean.length > 6) {
      prefix = clean.substring(3, 6); // Extract characters 4, 5, 6
    } else if (clean.startsWith('0') && clean.length > 3) {
      prefix = clean.substring(1, 3); // Extract characters 2, 3
    }

    // Comprehensive prefix match lists for Tanzanian MNO arrays
    if (['74', '75', '76'].contains(prefix)) {
      return StringConstants.channelVodacomMpesa;
    } else if (['65', '67', '71'].contains(prefix)) {
      return StringConstants.channelTigoPesa;
    } else if (['68', '69', '78'].contains(prefix)) {
      return StringConstants.channelAirtelMoney;
    } else if (['62', '61'].contains(prefix)) {
      return StringConstants.channelHalotelHaloPesa;
    }

    return StringConstants
        .channelBankTransfer; // Default systemic fallback fallback
  }

  /// Returns the structural SVG graphic resource path relative to the matched number.
  static String getAssetIconFromNumber(String phoneNumber) {
    final channel = detectChannel(phoneNumber);
    switch (channel) {
      case StringConstants.channelVodacomMpesa:
        return AppAssets.icons.mpesa; // Adjusted to namespace pattern
      case StringConstants.channelTigoPesa:
        return AppAssets.icons.tigoPesa;
      case StringConstants.channelAirtelMoney:
        return AppAssets.icons.airtelMoney;
      case StringConstants.channelHalotelHaloPesa:
        return AppAssets.icons.haloPesa;
      default:
        return AppAssets.icons.bankTransfer;
    }
  }
}
