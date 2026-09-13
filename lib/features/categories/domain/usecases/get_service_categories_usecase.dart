import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/service_category_entity.dart';
import '../repositories/service_category_repository.dart';
import 'params/get_service_categories_params.dart';

class GetServiceCategoriesUseCase
    implements
        UseCase<List<ServiceCategoryEntity>, GetServiceCategoriesParams> {
  final ServiceCategoryRepository repository;

  GetServiceCategoriesUseCase(this.repository);

  @override
  Future<Either<AppError, List<ServiceCategoryEntity>>> call(
    GetServiceCategoriesParams params,
  ) async {
    return await repository.getServiceCategories(params);
  }
}
