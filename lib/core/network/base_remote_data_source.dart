import 'package:flutter/foundation.dart';

abstract class BaseRemoteDataSource {
  /// 🧠 Global helper to safely drill into collection response data arrays consistently
  /// across any feature (Services, Reviews, Bookings, Addresses, etc.)
  List<Map<String, dynamic>> extractDataList(
    Map<String, dynamic> responseMap, {
    String? customKey,
  }) {
    try {
      // Prioritize explicit custom keys (like 'reviews'), fallback to 'data', or use root
      final dynamic targetData = (customKey != null)
          ? responseMap[customKey]
          : (responseMap['data'] ?? responseMap);

      if (targetData is List) {
        return List<Map<String, dynamic>>.from(
          targetData.map((item) => item as Map<String, dynamic>),
        );
      }
    } catch (e, stackTrace) {
      debugPrint(
        '❌ Core Global Parsing Error inside extractDataList: $e\n$stackTrace',
      );
    }

    return const [];
  }
}
