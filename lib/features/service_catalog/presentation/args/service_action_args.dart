import '../../domain/entities/provider_service_entity.dart';

/// Arguments for previewing or editing a service.
class ServiceActionArgs {
  final ProviderServiceEntity? service; // Null means "Create New" mode
  final String? categoryName; // Optional context for the UI

  ServiceActionArgs({
    this.service,
    this.categoryName,
  });
}