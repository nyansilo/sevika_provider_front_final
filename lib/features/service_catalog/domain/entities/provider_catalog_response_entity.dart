import 'package:equatable/equatable.dart';

import '../../../../core/global/domain/entities/pagination_entity.dart';
import 'provider_service_entity.dart';

class ProviderCatalogResponseEntity extends Equatable {
  final List<ProviderServiceEntity> catalog;
  final int totalServiceItems;
  final int activeServicesCount;
  final int disabledServicesItems;
  final int pausedServicesCount;
  final PaginationEntity pagination;

  const ProviderCatalogResponseEntity({
    required this.catalog,
    required this.totalServiceItems,
    required this.activeServicesCount,
    required this.disabledServicesItems,
    required this.pausedServicesCount,
    required this.pagination,
  });

  @override
  List<Object?> get props => [
    catalog,
    totalServiceItems,
    activeServicesCount,
    disabledServicesItems,
    pausedServicesCount,
    pagination,
  ];
}
