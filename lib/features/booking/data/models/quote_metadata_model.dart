import '../../../../core/constants/api_endpoints.dart';
import '../../domain/entities/quote_metadata_entity.dart';

class QuoteMetadataModel extends QuoteMetadataEntity {
  const QuoteMetadataModel({
    required super.projectSize,
    required super.fulfillmentPreference,
    super.attachedPhotos = const [],
    super.bidId,
    super.originalRequestId,
    super.proposalText,
  });

  QuoteMetadataEntity toEntity() => this;

  factory QuoteMetadataModel.fromJson(Map<String, dynamic> json) {
    // 🎯 FIXED: Sanitize all quote photos safely
    final rawPhotos =
        (json['attachedPhotos'] as List?) ??
        (json['attached_photos'] as List?) ??
        [];
    final List<String> safePhotos = rawPhotos
        .map((e) => ApiEndpoints.sanitizeBackendUrl(e.toString()))
        .toList();

    return QuoteMetadataModel(
      projectSize: json['projectSize']?.toString() ?? 'medium',
      fulfillmentPreference:
          json['fulfillmentPreference']?.toString() ?? 'home',
      attachedPhotos: safePhotos, // 🎯 Use the sanitized list
      bidId: json['bidId']?.toString(),
      originalRequestId: json['originalRequestId']?.toString(),
      proposalText: json['proposalText']?.toString(),
    );
  }
}
