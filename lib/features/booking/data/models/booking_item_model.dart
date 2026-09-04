import '../../domain/entities/booking_item_entity.dart';

class BookingItemModel extends BookingItemEntity {
  const BookingItemModel({
    required super.itemId,
    required super.serviceId,
    required super.title,
    required super.image,
    super.unitPrice,
    super.rawPrice,
  });

  BookingItemEntity toEntity() => this;

  factory BookingItemModel.fromJson(Map<String, dynamic> json) {
    return BookingItemModel(
      itemId: json['itemId'] != null
          ? (num.tryParse(json['itemId'].toString())?.toInt() ?? 0)
          : 0,
      serviceId: json['serviceId']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Unknown Service',
      image: json['image']?.toString() ?? '',
      unitPrice: json['price']?.toString() ?? json['unitPrice']?.toString(),
      rawPrice: (json['price'] != null || json['unitPrice'] != null)
          ? num.tryParse((json['price'] ?? json['unitPrice']).toString())
                ?.toInt()
          : null,
    );
  }
}
