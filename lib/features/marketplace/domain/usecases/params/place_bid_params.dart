import 'package:equatable/equatable.dart';

class PlaceBidParams extends Equatable {
  final int jobRequestId;
  final double bidAmount;
  final String proposalText;

  const PlaceBidParams({
    required this.jobRequestId,
    required this.bidAmount,
    required this.proposalText,
  });

  Map<String, dynamic> toJson() => {
    'jobRequestId': jobRequestId,
    'bidAmount': bidAmount,
    'proposalText': proposalText,
  };

  @override
  List<Object?> get props => [jobRequestId, bidAmount, proposalText];
}
