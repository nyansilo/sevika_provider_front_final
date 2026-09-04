import 'package:equatable/equatable.dart';

import 'booking_summary_entity.dart';

class BookingMetaEntity extends Equatable {
  final String currency;
  final String language;
  final String systemStatus;
  final BookingSummaryEntity summary;

  const BookingMetaEntity({
    required this.currency,
    required this.language,
    required this.systemStatus,
    required this.summary,
  });

  @override
  List<Object?> get props => [currency, language, systemStatus, summary];
}
