// import 'package:dartz/dartz.dart';
// import '../../../../core/errors/app_error.dart';
// import '../entities/service_category_entity.dart';
// import '../usecases/params/get_service_categories_params.dart';

// abstract class ServiceCategoryRepository {
//   /// Fetches service categories matching the filtering rules specified in [params].
//   Future<Either<AppError, List<ServiceCategoryEntity>>> getServiceCategories(
//     GetServiceCategoriesParams params,
//   );
// }

import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../entities/service_category_entity.dart';
import '../usecases/params/get_service_categories_params.dart';

abstract class ServiceCategoryRepository {
  Future<Either<AppError, List<ServiceCategoryEntity>>> getServiceCategories(
    GetServiceCategoriesParams params,
  );
}
