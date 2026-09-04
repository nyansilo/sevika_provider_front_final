import 'package:equatable/equatable.dart';

class UpdatePhoneParams extends Equatable {
  final String phoneNumber;

  const UpdatePhoneParams({required this.phoneNumber});

  Map<String, dynamic> toMap() => {
    'phoneNumber':
        phoneNumber, // 🚀 Changed to camelCase for the network payload
  };

  @override
  List<Object?> get props => [phoneNumber];
}
