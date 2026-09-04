import 'package:equatable/equatable.dart';

class QuoteMetadataEntity extends Equatable {
  final String projectSize;
  final String fulfillmentPreference;
  final List<String> attachedPhotos;
  final String? bidId;
  final String? originalRequestId;
  final String? proposalText;

  const QuoteMetadataEntity({
    required this.projectSize,
    required this.fulfillmentPreference,
    this.attachedPhotos = const [],
    this.bidId,
    this.originalRequestId,
    this.proposalText,
  });

  @override
  List<Object?> get props => [
    projectSize,
    fulfillmentPreference,
    attachedPhotos,
    bidId,
    originalRequestId,
    proposalText,
  ];
}
