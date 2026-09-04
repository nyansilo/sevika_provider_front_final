import 'package:equatable/equatable.dart';

abstract class WithdrawalState extends Equatable {
  const WithdrawalState();
  @override
  List<Object?> get props => [];
}

class WithdrawalInitial extends WithdrawalState {}

class WithdrawalLoading extends WithdrawalState {}

class WithdrawalSuccess extends WithdrawalState {}

class WithdrawalFailure extends WithdrawalState {
  final String message;
  const WithdrawalFailure(this.message);
  @override
  List<Object?> get props => [message];
}
