import 'package:equatable/equatable.dart';

class AcceptEmergencyParams extends Equatable {
  final String dispatchId;
  const AcceptEmergencyParams({required this.dispatchId});

  @override
  List<Object?> get props => [dispatchId];
}
