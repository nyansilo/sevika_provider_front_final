import 'package:equatable/equatable.dart';

import '../../../../core/errors/app_error.dart';
import '../../domain/entities/provider_catalog_response_entity.dart';
import '../../domain/entities/provider_service_entity.dart';

abstract class ProviderServiceState extends Equatable {
  const ProviderServiceState();

  @override
  List<Object?> get props => [];
}

class ProviderServiceInitial extends ProviderServiceState {}

class ProviderServiceLoading extends ProviderServiceState {}

class ProviderServiceLoaded extends ProviderServiceState {
  final ProviderCatalogResponseEntity response;

  const ProviderServiceLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class ProviderServiceFailure extends ProviderServiceState {
  final AppError error;

  const ProviderServiceFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class ProviderServiceActionSuccess extends ProviderServiceState {
  final String message;
  final ProviderServiceEntity? modifiedService;

  const ProviderServiceActionSuccess(this.message, {this.modifiedService});

  @override
  List<Object?> get props => [message, modifiedService];
}
