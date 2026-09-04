// lib/features/emergency/domain/entities/emergency_entity.dart

import 'package:equatable/equatable.dart';

class EmergencyServiceEntity extends Equatable {
  final String id;
  final String title;
  final String? image;
  final String pricingType;

  const EmergencyServiceEntity({
    required this.id,
    required this.title,
    this.image,
    required this.pricingType,
  });

  @override
  List<Object?> get props => [id, title, image, pricingType];
}

class EmergencyEntity extends Equatable {
  final String id;
  final int? bookingId;
  final String? bookingReference;
  final String serviceId;
  final EmergencyServiceEntity? service;
  final String? category;
  final String status;
  final double latitude;
  final double longitude;
  final String? addressText;
  final String dispatchedAt;
  final String? acceptedAt;

  const EmergencyEntity({
    required this.id,
    this.bookingId,
    this.bookingReference,
    required this.serviceId,
    this.service,
    this.category,
    required this.status,
    required this.latitude,
    required this.longitude,
    this.addressText,
    required this.dispatchedAt,
    this.acceptedAt,
  });

  @override
  List<Object?> get props => [
    id,
    bookingId,
    bookingReference,
    serviceId,
    service,
    category,
    status,
    latitude,
    longitude,
    addressText,
    dispatchedAt,
    acceptedAt,
  ];
}
