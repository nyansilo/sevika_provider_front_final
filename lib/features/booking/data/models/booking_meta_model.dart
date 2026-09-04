import '../../domain/entities/booking_meta_entity.dart';
import 'booking_summary_model.dart';

class BookingMetaModel extends BookingMetaEntity {
  const BookingMetaModel({
    required super.currency,
    required super.language,
    required super.systemStatus,
    required super.summary,
  });

  BookingMetaEntity toEntity() => this;

  factory BookingMetaModel.fromJson(Map<String, dynamic> json) {
    return BookingMetaModel(
      currency: json['currency']?.toString() ?? 'TSh',
      language: json['language']?.toString() ?? 'en',
      systemStatus: json['systemStatus']?.toString() ?? 'unknown',
      summary: BookingSummaryModel.fromJson(
        json['summary'] is Map<String, dynamic> ? json['summary'] : {},
      ).toEntity(),
    );
  }
}
