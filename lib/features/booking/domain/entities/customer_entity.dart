import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  final String fullName;
  final String phoneNumber;
  final String avatar;

  const CustomerEntity({
    required this.fullName,
    required this.phoneNumber,
    required this.avatar,
  });

  @override
  List<Object?> get props => [fullName, phoneNumber, avatar];
}
