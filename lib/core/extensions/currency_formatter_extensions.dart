import 'package:intl/intl.dart';

extension CurrencyExtensions on num? {
  /// Converts a nullable number to a clean Tanzanian Shilling format.
  /// Handles null values safely by returning a fallback structure.
  ///
  /// 🎯 UPDATED: Now enforces exactly 2 decimal places (e.g., "32,000.00")
  /// to match standard accounting/invoice displays across the platform.
  ///
  /// Examples:
  /// * `150000.toTzs()` -> "TZS 150,000.00"
  /// * `150000.toTzs(symbol: "TSh")` -> "TSh 150,000.00"
  /// * `null.toTzs()` -> "TZS 0.00"
  String toTzs({String symbol = 'TZS ', bool includeSymbol = true}) {
    if (this == null) {
      // 🎯 FIXED: Updated the fallback to also show two decimal places
      return includeSymbol ? '${symbol.trim()} 0.00' : '0.00';
    }

    final formatter = NumberFormat.currency(
      locale: 'en_TZ',
      symbol: includeSymbol ? '$symbol ' : '',
      // 🎯 FIXED: Changed from 0 to 2.
      // This forces Dart's NumberFormat to ALWAYS append .00 or the exact cents!
      decimalDigits: 2,
    );

    // Clean up any double spaces created by the symbol injection
    return formatter.format(this).replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  String toHoursDisplay({int decimalPlaces = 1}) {
    if (this == null) return '0.0h';
    return '${this!.toStringAsFixed(decimalPlaces)}h';
  }

  /// Converts a number to standard financial decimal format: "2,500.00"
  String toFinancialDisplay() {
    if (this == null) return '0.00';
    return NumberFormat('#,##0.00', 'en_US').format(this);
  }

  /// 🎯 ADDED: Converts a number to a compact financial display (e.g., 150000 -> "TSh 150K")
  /// Perfect for tight UI spaces like the Profile Quick Actions!
  String toCompactTzs({String symbol = 'TSh'}) {
    if (this == null || this == 0) return '$symbol 0';

    // Uses the US locale which natively supports K (thousands), M (millions), etc.
    final formatter = NumberFormat.compact(locale: 'en_US');
    return '$symbol ${formatter.format(this)}';
  }
}

extension StringCurrencyExtensions on String? {
  /// Safely parses a nullable string number and converts it to TZS currency format.
  /// Automatically strips alphabetical characters, spaces, and commas prior to evaluation.
  ///
  /// 🎯 NOTE: Routes into the updated num.toTzs() above, inheriting the 2 decimal places rule.
  String toTzs({String symbol = 'TZS ', bool includeSymbol = true}) {
    if (this == null || this!.trim().isEmpty) {
      // 🎯 FIXED: Updated the fallback string to match the 2-decimal format
      return includeSymbol ? '${symbol.trim()} 0.00' : '0.00';
    }

    // 🛡️ DEFENSIVE STRIPPING: Cleanses mutations like "15,000", "25000 TZS", or " 30000 "
    final String sanitizedString = this!
        .replaceAll(',', '') // Removes thousands-separating commas
        .replaceAll(
          RegExp(r'[a-zA-Z]'),
          '',
        ) // Removes leaked currency codes/text labels
        .trim(); // Trims dangling edge spaces

    final parsedNum = num.tryParse(sanitizedString);
    return parsedNum.toTzs(symbol: symbol, includeSymbol: includeSymbol);
  }

  /// 🎯 ADDED: Safely parses a string and formats it to the compact "100K" style
  String toCompactTzs({String symbol = 'TSh'}) {
    if (this == null || this!.trim().isEmpty) return '$symbol 0';

    final sanitizedString = this!
        .replaceAll(',', '')
        .replaceAll(RegExp(r'[a-zA-Z]'), '')
        .trim();

    return num.tryParse(sanitizedString).toCompactTzs(symbol: symbol);
  }
}
