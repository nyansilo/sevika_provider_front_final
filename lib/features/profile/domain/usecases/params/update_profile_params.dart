import 'dart:io';

import 'package:equatable/equatable.dart';

class UpdateProfileParams extends Equatable {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String defaultAddress;
  final String city;
  final String? alternativePhone;
  final File? imageFile;

  const UpdateProfileParams({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.defaultAddress,
    required this.city,
    this.alternativePhone,
    this.imageFile,
  });

  Map<String, dynamic> toMap() => {
    'firstName': firstName,
    'lastName': lastName,
    'phoneNumber': phoneNumber,
    'defaultAddress': defaultAddress,
    'city': city,
    'alternativePhone': alternativePhone,
  };

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    phoneNumber,
    defaultAddress,
    city,
    alternativePhone,
    imageFile,
  ];
}
