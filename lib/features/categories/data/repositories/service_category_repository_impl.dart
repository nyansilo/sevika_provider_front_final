// import 'package:dartz/dartz.dart';
// import '../../../../core/errors/app_error.dart';
// import '../../../../core/errors/error_handler.dart';
// import '../../domain/entities/service_category_entity.dart';
// import '../../domain/repositories/service_category_repository.dart';
// import '../../domain/usecases/params/get_service_categories_params.dart';
// import '../datasources/service_category_remote_data_source.dart';

// class ServiceCategoryRepositoryImpl implements ServiceCategoryRepository {
//   final ServiceCategoryRemoteDataSource remoteDataSource;

//   ServiceCategoryRepositoryImpl({required this.remoteDataSource});

//   @override
//   Future<Either<AppError, List<ServiceCategoryEntity>>> getServiceCategories(
//     GetServiceCategoriesParams params,
//   ) async {
//     try {
//       // 1. Fetch the raw transport response model from the API source
//       final responseModel = await remoteDataSource.fetchServiceCategories(
//         params,
//       );

//       // 2. Extract the data models and translate them directly into clean domain entities
//       final List<ServiceCategoryEntity> entities = responseModel.categories
//           .map((model) => model.toEntity())
//           .toList();

//       // 3. Return the domain-ready list cleanly packaged inside the Right side of the Either
//       return Right(entities);
//     } catch (e) {
//       return Left(await ErrorHandler.handle(e));
//     }
//   }
// }

import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_handler.dart';
import '../../domain/entities/service_category_entity.dart';
import '../../domain/repositories/service_category_repository.dart';
import '../../domain/usecases/params/get_service_categories_params.dart';
import '../datasources/service_category_remote_data_source.dart';

class ServiceCategoryRepositoryImpl implements ServiceCategoryRepository {
  final ServiceCategoryRemoteDataSource remoteDataSource;

  ServiceCategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppError, List<ServiceCategoryEntity>>> getServiceCategories(
    GetServiceCategoriesParams params,
  ) async {
    try {
      final responseModel = await remoteDataSource.fetchServiceCategories(
        params,
      );
      final entities = responseModel.categories
          .map((model) => model.toEntity())
          .toList();
      return Right(entities);
    } catch (e) {
      return Left(await ErrorHandler.handle(e));
    }
  }
}
