import 'package:equatable/equatable.dart';
import '../../domain/entities/call_entity.dart';

/// 📨 Active Call Screen Args
///
/// Strongly typed arguments required to navigate to the ActiveCallScreen.
/// This acts as a protective wrapper around the CallEntity, keeping your
/// routing pattern standardized across the entire application.
class ActiveCallScreenArgs extends Equatable {
  final CallEntity callData;

  const ActiveCallScreenArgs({required this.callData});

  @override
  List<Object?> get props => [callData];
}
