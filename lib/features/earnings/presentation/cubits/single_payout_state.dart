import 'package:equatable/equatable.dart';

import '../../domain/entities/earning_entity.dart';

abstract class SinglePayoutState extends Equatable {
  const SinglePayoutState();
  @override
  List<Object?> get props => [];
}

class SinglePayoutInitial extends SinglePayoutState {}

class SinglePayoutLoading extends SinglePayoutState {}

class SinglePayoutLoaded extends SinglePayoutState {
  final EarningEntity payout;
  const SinglePayoutLoaded(this.payout);
  @override
  List<Object?> get props => [payout];
}

class SinglePayoutFailure extends SinglePayoutState {
  final String message;
  const SinglePayoutFailure(this.message);
  @override
  List<Object?> get props => [message];
}
