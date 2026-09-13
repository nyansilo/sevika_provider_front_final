import 'package:equatable/equatable.dart';

import '../../../../core/global/domain/entities/pagination_entity.dart';
import 'earning_entity.dart';
import 'earnings_analytics_entity.dart';

class EarningsResponseEntity extends Equatable {
  final List<EarningEntity> ledger;
  final EarningsAnalyticsEntity analytics;
  final PaginationEntity pagination;

  const EarningsResponseEntity({
    required this.ledger,
    required this.analytics,
    required this.pagination,
  });

  @override
  List<Object?> get props => [ledger, analytics, pagination];
}
