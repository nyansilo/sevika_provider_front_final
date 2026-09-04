import 'package:equatable/equatable.dart';

import '../../../../core/errors/app_error.dart';

abstract class PlaceBidState extends Equatable {
  const PlaceBidState();
  @override
  List<Object?> get props => [];
}

class PlaceBidInitial extends PlaceBidState {}

class PlaceBidLoading extends PlaceBidState {}

class PlaceBidSuccess extends PlaceBidState {}

class PlaceBidFailure extends PlaceBidState {
  final AppError error;
  const PlaceBidFailure(this.error);
  @override
  List<Object?> get props => [error];
}
