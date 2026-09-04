/// 📞 Call Type Enum
///
/// Strictly defines the types of internet calls available in the app.
/// Prevents typos and ensures type safety across the domain.
enum CallType {
  audio,
  video;

  /// Converts the enum to a JSON string for the backend API payload
  String toJson() => name;

  /// Safely parses the JSON string from the backend into the Enum.
  /// Defaults to [CallType.audio] if an unknown value is received.
  static CallType fromJson(String json) {
    return values.firstWhere(
      (e) => e.name.toLowerCase() == json.toLowerCase(),
      orElse: () => CallType.audio,
    );
  }
}
