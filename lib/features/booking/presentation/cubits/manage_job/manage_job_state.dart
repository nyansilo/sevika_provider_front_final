// import 'package:equatable/equatable.dart';

// import '../../../../../core/errors/app_error.dart';
// import '../../../domain/entities/booking_entity.dart';

// abstract class ManageJobState extends Equatable {
//   const ManageJobState();

//   @override
//   List<Object?> get props => [];
// }

// class ManageJobInitial extends ManageJobState {
//   const ManageJobInitial();
// }

// class ManageJobLoading extends ManageJobState {
//   const ManageJobLoading();
// }

// class ManageJobSuccess extends ManageJobState {
//   final BookingEntity booking;
//   const ManageJobSuccess(this.booking);

//   @override
//   List<Object?> get props => [booking];
// }

// class ManageJobFailure extends ManageJobState {
//   final AppError error;
//   const ManageJobFailure(this.error);

//   @override
//   List<Object?> get props => [error];
// }

import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_error.dart';
import '../../../domain/entities/booking_entity.dart';

abstract class ManageJobState extends Equatable {
  const ManageJobState();

  @override
  List<Object?> get props => [];
}

class ManageJobInitial extends ManageJobState {
  const ManageJobInitial();
}

class ManageJobLoading extends ManageJobState {
  const ManageJobLoading();
}

class ManageJobSuccess extends ManageJobState {
  final BookingEntity booking;
  const ManageJobSuccess(this.booking);

  @override
  List<Object?> get props => [booking];
}

// 🎯 ADDED: Specific state for silent data refreshing!
class ManageJobFetchSuccess extends ManageJobState {
  final BookingEntity booking;
  const ManageJobFetchSuccess(this.booking);

  @override
  List<Object?> get props => [booking];
}

class ManageJobFailure extends ManageJobState {
  final AppError error;
  const ManageJobFailure(this.error);

  @override
  List<Object?> get props => [error];
}
