import 'package:equatable/equatable.dart';

import '../../enums/call_type.dart';

/// 📨 Initiate Call Params
///
/// This is a Data Transfer Object (DTO) that carries the required data
/// from the Presentation layer (Cubit) into the Domain layer (UseCase).
///
/// 🏗️ CLEAN ARCHITECTURE NOTE:
/// By encapsulating parameters into a dedicated class, if we ever need to add
/// a new parameter (e.g., 'isEmergencyCall'), we only update this class instead
/// of breaking the method signatures across the Cubit, UseCase, and Repository.
class InitiateCallParams extends Equatable {
  /// 🛡️ STRICT IDENTITY: Uses the String UUID to match the Laravel Database
  final String receiverId;

  /// 🎯 STRICT TYPING: Uses the Enum to guarantee valid call types
  final CallType callType;

  const InitiateCallParams({
    required this.receiverId,
    this.callType =
        CallType.audio, // Defaults to audio if not explicitly provided
  });

  /// 🔄 Serialization for the Backend
  ///
  /// Maps the parameters safely to camelCase, which your Laravel `InitiateCallRequest`
  /// will automatically intercept and convert to snake_case for validation.
  Map<String, dynamic> toJson() => {
    'receiverId': receiverId,
    'callType': callType
        .toJson(), // Converts the Enum (e.g., CallType.video) to a String ('video')
  };

  /// Equatable implementation ensures that if two instances have the exact same
  /// receiverId and callType, they are considered equal in memory.
  @override
  List<Object?> get props => [receiverId, callType];
}
