// lib/features/notification/domain/usecases/params/toggle_notification_params.dart
import 'package:equatable/equatable.dart';

class ToggleNotificationParams extends Equatable {
  final bool isEnabled;

  const ToggleNotificationParams({required this.isEnabled});

  Map<String, dynamic> toJson() => {'enabled': isEnabled};

  @override
  List<Object?> get props => [isEnabled];
}
