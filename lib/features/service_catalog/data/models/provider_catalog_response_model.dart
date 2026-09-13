// 🎯 Ensure this points to your shared core folder where PaginationModel lives!

import '../../domain/entities/provider_catalog_response_entity.dart';
import '../../../../core/global/data/models/pagination_model.dart';
import 'provider_service_model.dart';

class ProviderCatalogResponseModel extends ProviderCatalogResponseEntity {
  const ProviderCatalogResponseModel({
    required super.catalog,
    required super.totalServiceItems,
    required super.activeServicesCount,
    required super.disabledServicesItems,
    required super.pausedServicesCount,
    required super.pagination,
  });

  factory ProviderCatalogResponseModel.fromJson(Map<String, dynamic> json) {
    final catalogList =
        (json['catalog'] as List?)
            ?.map(
              (e) => ProviderServiceModel.fromJson(e as Map<String, dynamic>),
            )
            .toList() ??
        [];

    final meta = json['meta'] ?? {};
    final analytics = meta['analytics'] ?? {};
    final paginationJson = meta['pagination'] ?? {};

    return ProviderCatalogResponseModel(
      catalog: catalogList,
      totalServiceItems: (analytics['totalServiceItems'] as num?)?.toInt() ?? 0,
      activeServicesCount:
          (analytics['activeServicesCount'] as num?)?.toInt() ?? 0,
      disabledServicesItems:
          (analytics['disabledServicesItems'] as num?)?.toInt() ?? 0,
      pausedServicesCount:
          (analytics['pausedServicesCount'] as num?)?.toInt() ?? 0,

      // 🚀 THE FIX: Explicitly cast it back to the Entity to satisfy the compiler
      pagination: PaginationModel.fromJson(paginationJson).toEntity(),
    );
  }

  ProviderCatalogResponseEntity toEntity() => this;
}
