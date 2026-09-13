import 'package:equatable/equatable.dart';

import '../../../../core/errors/app_error.dart';
import '../../domain/entities/service_category_entity.dart';

abstract class ServiceCategoryState extends Equatable {
  const ServiceCategoryState();

  @override
  List<Object?> get props => [];
}

class ServiceCategoryInitial extends ServiceCategoryState {
  const ServiceCategoryInitial();
}

class ServiceCategoryLoading extends ServiceCategoryState {
  const ServiceCategoryLoading();
}

class ServiceCategoryLoadSuccess extends ServiceCategoryState {
  final List<ServiceCategoryEntity> categories;

  const ServiceCategoryLoadSuccess({required this.categories});

  @override
  List<Object?> get props => [categories];
}

class ServiceCategoryLoadFailure extends ServiceCategoryState {
  final AppError error;

  const ServiceCategoryLoadFailure(this.error);

  @override
  List<Object?> get props => [error];
}
