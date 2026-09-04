import 'package:equatable/equatable.dart';

class ProviderProfileEntity extends Equatable {
  // 🎯 FIXED: Changed from int to String for UUIDs
  final String id;
  final String defaultAddress;
  final String city;
  final String? alternativePhone;
  final String createdAt;
  final String updatedAt;

  const ProviderProfileEntity({
    required this.id,
    required this.defaultAddress,
    required this.city,
    this.alternativePhone,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    defaultAddress,
    city,
    alternativePhone,
    createdAt,
    updatedAt,
  ];
}
