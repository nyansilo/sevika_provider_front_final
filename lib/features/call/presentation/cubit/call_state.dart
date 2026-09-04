import 'package:equatable/equatable.dart';
import '../../../../core/errors/app_error.dart';
import '../../domain/entities/call_entity.dart';

/// 🌊 Call State Base
abstract class CallState extends Equatable {
  const CallState();

  @override
  List<Object?> get props => [];
}

/// 🟢 Initial State
class CallInitial extends CallState {
  const CallInitial();
}

/// ⏳ Loading State
class CallLoading extends CallState {
  const CallLoading();
}

/// ✅ Success State
class CallInitiatedSuccess extends CallState {
  final CallEntity callData;

  const CallInitiatedSuccess(this.callData);

  @override
  List<Object?> get props => [callData];
}

/// ❌ Failure State
class CallFailure extends CallState {
  final AppError error;

  const CallFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
