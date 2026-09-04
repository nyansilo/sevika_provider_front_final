import 'package:equatable/equatable.dart';

import '../../../../core/errors/app_error.dart';
import '../../../booking/domain/entities/booking_entity.dart';

abstract class AcceptEmergencyState extends Equatable {
  const AcceptEmergencyState();
  @override
  List<Object?> get props => [];
}

class AcceptEmergencyInitial extends AcceptEmergencyState {}

class AcceptEmergencyLoading extends AcceptEmergencyState {}

class AcceptEmergencySuccess extends AcceptEmergencyState {
  final BookingEntity booking;
  const AcceptEmergencySuccess(this.booking);
  @override
  List<Object?> get props => [booking];
}

class AcceptEmergencyFailure extends AcceptEmergencyState {
  final AppError error;
  const AcceptEmergencyFailure(this.error);
  @override
  List<Object?> get props => [error];
}
