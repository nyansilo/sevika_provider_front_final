import 'package:equatable/equatable.dart';

import '../enums/call_type.dart';

/// 📞 Call Entity
///
/// The core business object representing a secure call connection.
/// It relies on the [CallType] enum and uses a [String] for the UUID.
class CallEntity extends Equatable {
  final String driver;
  final String appId;
  final String channelName;
  final String token;
  final CallType callType; // Strict Enum
  final String uid; // String to hold the Laravel UUID
  final Map<String, dynamic> extra;
  final String receiverName;
  final String? avatarUrl;

  const CallEntity({
    required this.driver,
    required this.appId,
    required this.channelName,
    required this.token,
    required this.callType,
    required this.uid,
    required this.extra,
    required this.receiverName,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [
    driver,
    appId,
    channelName,
    token,
    callType,
    uid,
    extra,
    receiverName,
    avatarUrl,
  ];
}
