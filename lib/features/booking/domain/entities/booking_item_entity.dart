import 'package:equatable/equatable.dart';

class BookingItemEntity extends Equatable {
  final int itemId;
  final String serviceId;
  final String title;
  final String image;
  final String? unitPrice;
  final int? rawPrice;

  const BookingItemEntity({
    required this.itemId,
    required this.serviceId,
    required this.title,
    required this.image,
    this.unitPrice,
    this.rawPrice,
  });

  @override
  List<Object?> get props => [
    itemId,
    serviceId,
    title,
    image,
    unitPrice,
    rawPrice,
  ];
}
