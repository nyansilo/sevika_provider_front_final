import 'package:equatable/equatable.dart';

class ProviderEntity extends Equatable {
  final String id;
  final String fullName;
  final String businessName;
  final String phone;
  final double rating;
  final String profileImageUrl;

  const ProviderEntity({
    required this.id,
    required this.fullName,
    required this.businessName,
    required this.phone,
    required this.profileImageUrl,
    required this.rating,
  });

  @override
  List<Object?> get props => [
    id,
    fullName,
    businessName,
    phone,
    rating,
    profileImageUrl,
  ];
}
