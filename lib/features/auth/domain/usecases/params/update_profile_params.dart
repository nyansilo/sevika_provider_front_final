import 'dart:io';
import 'package:equatable/equatable.dart';

/// Parameters required to execute a profile mutation layer context
class UpdateProfileParams extends Equatable {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final File? imageFile;

  const UpdateProfileParams({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.imageFile,
  });

  /// 🚀 ALIGNED: Maps perfectly to your UpdateCustomerProfileRequest array schema keys
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
    };
  }

  @override
  List<Object?> get props => [firstName, lastName, phoneNumber, imageFile];
}
