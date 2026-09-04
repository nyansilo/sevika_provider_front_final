// import 'package:equatable/equatable.dart';

// class UpdateFcmTokenParams extends Equatable {
//   final String token;
//   final String deviceType; // 🎯 ADDED: e.g., 'android' or 'ios'

//   const UpdateFcmTokenParams({required this.token, required this.deviceType});

//   // 🎯 Encapsulates the JSON mapping here!
//   Map<String, dynamic> toJson() {
//     return {'fcm_token': token, 'device_type': deviceType};
//   }

//   @override
//   List<Object?> get props => [token, deviceType];
// }

// lib/features/notification/domain/usecases/params/update_fcm_token_params.dart
import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class UpdateFcmTokenParams extends Equatable {
  final String token;
  final String deviceType; // 🎯 ADDED

  const UpdateFcmTokenParams({required this.token, required this.deviceType});

  /// 🎯 Helper factory to automatically detect the device OS
  factory UpdateFcmTokenParams.withAutoDevice({required String token}) {
    String osType = 'web';
    if (!kIsWeb) {
      osType = Platform.isIOS ? 'ios' : 'android';
    }
    return UpdateFcmTokenParams(token: token, deviceType: osType);
  }

  // 🎯 Encapsulates the JSON mapping here!
  Map<String, dynamic> toJson() {
    return {'fcm_token': token, 'device_type': deviceType};
  }

  @override
  List<Object?> get props => [token, deviceType];
}
