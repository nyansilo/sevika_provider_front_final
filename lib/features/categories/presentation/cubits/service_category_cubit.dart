import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_service_categories_usecase.dart';
import '../../domain/usecases/params/get_service_categories_params.dart';
import 'service_category_state.dart';

class ServiceCategoryCubit extends Cubit<ServiceCategoryState> {
  final GetServiceCategoriesUseCase getServiceCategoriesUseCase;

  ServiceCategoryCubit({required this.getServiceCategoriesUseCase})
    : super(const ServiceCategoryInitial());

  /// Fetches all service categories (Used by the Home Page)
  Future<void> loadServiceCategories({bool forceRefresh = false}) async {
    if (state is ServiceCategoryLoading && !forceRefresh) return;

    emit(const ServiceCategoryLoading());

    final result = await getServiceCategoriesUseCase.call(
      // 🎯 isEmergencyOnly is null, so the API returns everything
      const GetServiceCategoriesParams(onlyActive: true),
    );

    if (isClosed) return;

    result.fold(
      (appError) => emit(ServiceCategoryLoadFailure(appError)),
      (categoriesList) =>
          emit(ServiceCategoryLoadSuccess(categories: categoriesList)),
    );
  }

  /// 🎯 NEW: Fetches ONLY emergency categories (Used by Emergency Screen)
  Future<void> loadEmergencyCategories({bool forceRefresh = false}) async {
    if (state is ServiceCategoryLoading && !forceRefresh) return;

    emit(const ServiceCategoryLoading());

    final result = await getServiceCategoriesUseCase.call(
      // 🎯 explicitly request only emergency categories
      const GetServiceCategoriesParams(onlyActive: true, isEmergencyOnly: true),
    );

    if (isClosed) return;

    result.fold(
      (appError) => emit(ServiceCategoryLoadFailure(appError)),
      (categoriesList) =>
          emit(ServiceCategoryLoadSuccess(categories: categoriesList)),
    );
  }
}
