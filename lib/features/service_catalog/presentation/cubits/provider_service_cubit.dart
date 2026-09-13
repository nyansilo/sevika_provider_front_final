import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_provider_catalog_usecase.dart';
import '../../domain/usecases/propose_service_usecase.dart';
import '../../domain/usecases/update_service_offering_usecase.dart';
import '../../domain/usecases/delete_service_offering_usecase.dart';
import '../../domain/usecases/params/catalog_pagination_params.dart';
import '../../domain/usecases/params/propose_service_params.dart';
import '../../domain/usecases/params/update_offering_params.dart';
import 'provider_service_state.dart';

class ProviderServiceCubit extends Cubit<ProviderServiceState> {
  final GetProviderCatalogUseCase getCatalogUseCase;
  final ProposeServiceUseCase proposeServiceUseCase;
  final UpdateServiceOfferingUseCase updateOfferingUseCase;
  final DeleteServiceOfferingUseCase deleteOfferingUseCase;

  ProviderServiceCubit({
    required this.getCatalogUseCase,
    required this.proposeServiceUseCase,
    required this.updateOfferingUseCase,
    required this.deleteOfferingUseCase,
  }) : super(ProviderServiceInitial());

  Future<void> fetchCatalog({int page = 1}) async {
    emit(ProviderServiceLoading());

    final result = await getCatalogUseCase.call(
      CatalogPaginationParams(page: page),
    );

    if (isClosed) return;

    result.fold(
      (error) => emit(ProviderServiceFailure(error)),
      (data) => emit(ProviderServiceLoaded(data)),
    );
  }

  Future<void> proposeService(ProposeServiceParams params) async {
    emit(ProviderServiceLoading());
    final result = await proposeServiceUseCase.call(params);
    if (isClosed) return;

    result.fold((error) => emit(ProviderServiceFailure(error)), (service) {
      emit(
        ProviderServiceActionSuccess(
          "Service proposed successfully. Pending Admin review.",
          modifiedService: service,
        ),
      );
      // Refresh the list seamlessly
      fetchCatalog();
    });
  }

  Future<void> updateService(UpdateOfferingParams params) async {
    emit(ProviderServiceLoading());
    final result = await updateOfferingUseCase.call(params);
    if (isClosed) return;

    result.fold((error) => emit(ProviderServiceFailure(error)), (service) {
      emit(
        ProviderServiceActionSuccess(
          "Service offering updated successfully.",
          modifiedService: service,
        ),
      );
      // Refresh to reflect the new price or active status
      fetchCatalog();
    });
  }

  Future<void> removeService(String serviceId) async {
    emit(ProviderServiceLoading());
    final result = await deleteOfferingUseCase.call(serviceId);
    if (isClosed) return;

    result.fold((error) => emit(ProviderServiceFailure(error)), (message) {
      emit(ProviderServiceActionSuccess(message));
      // Refresh to remove item from the UI catalog
      fetchCatalog();
    });
  }
}
