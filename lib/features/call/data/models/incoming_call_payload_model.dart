import '../../domain/enums/call_type.dart';

/// 📦 Incoming Call Payload Model
///
/// Safely intercepts the raw Firebase Data Message and strictly types it
/// before passing it to the native CallKit UI.
class IncomingCallPayloadModel {
  final String type;
  final String channelName;
  final String callerName;
  final String avatarUrl;
  final CallType callType;
  final String token;
  final String appId;
  final String uid;

  const IncomingCallPayloadModel({
    required this.type,
    required this.channelName,
    required this.callerName,
    required this.avatarUrl,
    required this.callType,
    required this.token,
    required this.appId,
    required this.uid,
  });

  /// Factory method to safely deserialize incoming Firebase payload.
  factory IncomingCallPayloadModel.fromJson(Map<String, dynamic> json) {
    return IncomingCallPayloadModel(
      type: json['type']?.toString() ?? '',
      channelName: json['channelName']?.toString() ?? '',
      callerName: json['callerName']?.toString() ?? 'Unknown Caller',
      avatarUrl: json['avatarUrl']?.toString() ?? '',
      // Safely parse the enum, default to audio if corrupted
      callType: CallType.fromJson(json['callType']?.toString() ?? 'audio'),
      token: json['token']?.toString() ?? '',
      appId: json['appId']?.toString() ?? '',
      uid: json['uid']?.toString() ?? '',
    );
  }

  /// Converts back to a Map so CallKit can store it in the 'extra' parameter
  /// and hand it back to the app when the user answers.
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'channelName': channelName,
      'callerName': callerName,
      'avatarUrl': avatarUrl,
      'callType': callType.name, // Converts enum back to string
      'token': token,
      'appId': appId,
      'uid': uid,
    };
  }

  bool get isVideo => callType == CallType.video;
}
