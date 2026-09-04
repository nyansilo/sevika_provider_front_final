import '../../../booking/data/models/pagination_model.dart';
import '../../domain/entities/earning_response_entity.dart';
import 'earning_analytics_model.dart';
import 'earning_model.dart';

class EarningsResponseModel extends EarningsResponseEntity {
  const EarningsResponseModel({
    required super.ledger,
    required super.analytics,
    required super.pagination,
  });

  factory EarningsResponseModel.fromJson(
    Map<String, dynamic> json,
    List<Map<String, dynamic>> rawLedger,
  ) {
    final meta = json['meta'] as Map<String, dynamic>? ?? {};
    final analyticsJson = meta['analytics'] as Map<String, dynamic>? ?? {};

    return EarningsResponseModel(
      ledger: rawLedger.map((e) => EarningModel.fromJson(e)).toList(),
      analytics: EarningsAnalyticsModel.fromJson(analyticsJson),
      pagination: PaginationModel.fromJson(
        meta['pagination'] is Map
            ? Map<String, dynamic>.from(meta['pagination'])
            : {},
      ).toEntity(),
    );
  }
}
