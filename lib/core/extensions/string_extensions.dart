extension StringTransforms on String {
  /// Sanitizes phone inputs from variations to uniform system standards.
  /// Handles configurations like: "0764 000 111", "+255764000111" -> "255764000111"
  String toCleanMsisdn() {
    final clean = replaceAll(RegExp(r'\s+|\+'), '');
    if (clean.startsWith('0')) {
      return '255${clean.substring(1)}';
    }
    return clean;
  }

  /// Capitalizes only the initial character of a word string. Handy for dynamic names.
  String toCapitalized() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Converts a raw string gracefully to an integer fallback safely if parsing fails.
  int toIntOrDefault([int defaultValue = 0]) {
    return int.tryParse(this) ?? defaultValue;
  }

  /// Returns the last [n] characters of the string safely.
  /// Example: "SVK-JLWU-7454".takeLast(8) -> "JLWU-7454"
  String takeLast(int n) {
    if (length <= n) return this;
    return substring(length - n);
  }
}
