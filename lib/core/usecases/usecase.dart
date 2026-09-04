// lib/core/usecases/usecase.dart
import 'package:dartz/dartz.dart';
import '../../core/errors/app_error.dart';

abstract class UseCase<ResultType, Params> {
  Future<Either<AppError, ResultType>> call(Params params);
}

class NoParams {
  const NoParams();
}

//Handle Void type internally by dartz
// class Unit {
//   const Unit();
// }

// // A single, globally shared instance of the Unit object
// const Unit unit = Unit();
