import 'package:equatable/equatable.dart';
import '../../entities/reset_channel.dart';

class ResetPasswordParams extends Equatable {
  final ResetChannel channel;
  final String? email;
  final String? phoneNumber;
  final String code;
  final String newPassword;
  final String newPasswordConfirmation;

  const ResetPasswordParams({
    required this.channel,
    this.email,
    this.phoneNumber,
    required this.code,
    required this.newPassword,
    required this.newPasswordConfirmation,
  }) : assert(
         (channel == ResetChannel.email && email != null) ||
             (channel == ResetChannel.phone && phoneNumber != null),
         'You must provide an email if channel is email, or a phone number if channel is phone.',
       );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'channel': channel.name,
      'code': code,
      'newPassword': newPassword,
      'newPasswordConfirmation': newPasswordConfirmation,
    };

    if (channel == ResetChannel.email) {
      map['email'] = email;
    } else {
      map['phoneNumber'] = phoneNumber;
    }

    return map;
  }

  @override
  List<Object?> get props => [
    channel,
    email,
    phoneNumber,
    code,
    newPassword,
    newPasswordConfirmation,
  ];
}
