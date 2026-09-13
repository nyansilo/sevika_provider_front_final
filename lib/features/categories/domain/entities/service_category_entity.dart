import 'package:equatable/equatable.dart';

class ServiceCategoryEntity extends Equatable {
  final int categoryId;
  final String name;
  final String slug;
  final String iconUrl;
  final bool isActive;
  final bool isEmergency;

  const ServiceCategoryEntity({
    required this.categoryId,
    required this.name,
    required this.slug,
    required this.iconUrl,
    required this.isActive,
    required this.isEmergency,
  });

  @override
  List<Object?> get props => [
    categoryId,
    name,
    slug,
    iconUrl,
    isActive,
    isEmergency,
  ];
}
