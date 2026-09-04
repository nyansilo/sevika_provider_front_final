// import 'package:flutter/foundation.dart';
// import '../../domain/entities/call_entity.dart';
// import '../../domain/enums/call_type.dart';

// /// 📦 Call Model
// ///
// /// Intercepts the raw JSON from Laravel and maps it safely to our Domain.
// class CallModel extends CallEntity {
//   const CallModel({
//     required super.driver,
//     required super.appId,
//     required super.channelName,
//     required super.token,
//     required super.callType,
//     required super.uid,
//     required super.extra,
//     required super.receiverName,
//     super.avatarUrl,
//   });

//   /// Factory method to safely deserialize incoming API payload.
//   factory CallModel.fromJson(Map<String, dynamic> json) {
//     try {
//       return CallModel(
//         driver: json['driver']?.toString() ?? 'agora',
//         appId: json['appId']?.toString() ?? '',
//         channelName: json['channelName']?.toString() ?? '',
//         token: json['token']?.toString() ?? '',

//         // 🎯 UPDATED: Parses string into CallType Enum
//         callType: CallType.fromJson(json['callType']?.toString() ?? 'audio'),

//         // 🎯 UPDATED: Safely casts UUID to a String
//         uid: json['uid']?.toString() ?? '',

//         extra: json['extra'] as Map<String, dynamic>? ?? {},
//         receiverName: json['receiverName']?.toString() ?? 'Unknown User',
//         avatarUrl: json['avatarUrl']?.toString(),
//       );
//     } catch (e, stackTrace) {
//       debugPrint('Parsing Exception inside CallModel: $e\n$stackTrace');
//       throw FormatException('Invalid Call structural model mapping: $e');
//     }
//   }

//   /// Converts the Data Model back into a pure Domain Entity for the UI.
//   CallEntity toEntity() => this;
// }

import 'package:flutter/foundation.dart';
import '../../domain/entities/call_entity.dart';
import '../../domain/enums/call_type.dart';

/// 📦 Call Model
///
/// Intercepts the raw JSON from Laravel and maps it safely to our Domain.
class CallModel extends CallEntity {
  const CallModel({
    required super.driver,
    required super.appId,
    required super.channelName,
    required super.token,
    required super.callType,
    required super.uid,
    required super.extra,
    required super.receiverName,
    super.avatarUrl,
  });

  /// Factory method to safely deserialize incoming API payload.
  factory CallModel.fromJson(Map<String, dynamic> json) {
    try {
      return CallModel(
        driver: json['driver']?.toString() ?? 'agora',
        appId: json['appId']?.toString() ?? '',
        channelName: json['channelName']?.toString() ?? '',
        token: json['token']?.toString() ?? '',

        // 🎯 UPDATED: Parses string into CallType Enum
        callType: CallType.fromJson(json['callType']?.toString() ?? 'audio'),

        // 🎯 UPDATED: Safely casts UUID to a String
        uid: json['uid']?.toString() ?? '',

        // 🛡️ DEFENSIVE FIX: Checks if it's actually a Map before casting.
        // If PHP sends an empty list [], it safely falls back to an empty Map {}.
        extra: (json['extra'] is Map)
            ? Map<String, dynamic>.from(json['extra'] as Map)
            : <String, dynamic>{},

        receiverName: json['receiverName']?.toString() ?? 'Unknown User',
        avatarUrl: json['avatarUrl']?.toString(),
      );
    } catch (e, stackTrace) {
      debugPrint('Parsing Exception inside CallModel: $e\n$stackTrace');
      throw FormatException('Invalid Call structural model mapping: $e');
    }
  }

  /// Converts the Data Model back into a pure Domain Entity for the UI.
  CallEntity toEntity() => this;
}
