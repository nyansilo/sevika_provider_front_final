import 'package:equatable/equatable.dart';

/// 🎯 NOTIFICATION SETTINGS STATE
/// We use a dedicated State class instead of a simple boolean so we can
/// pass one-time messages (success/error) to the UI alongside the toggle value.
class NotificationSettingsState extends Equatable {
  final bool isEnabled;
  final String? successMessage;
  final String? errorMessage;

  const NotificationSettingsState({
    required this.isEnabled,
    this.successMessage,
    this.errorMessage,
  });

  /// 🔄 COPY WITH PATTERN
  /// Allows us to update specific fields without losing the others.
  NotificationSettingsState copyWith({
    bool? isEnabled,
    String? successMessage,
    String? errorMessage,
    // 🧹 Custom flag to wipe out old messages so they don't fire twice
    bool clearMessages = false,
  }) {
    return NotificationSettingsState(
      isEnabled: isEnabled ?? this.isEnabled,
      successMessage: clearMessages
          ? null
          : (successMessage ?? this.successMessage),
      errorMessage: clearMessages ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [isEnabled, successMessage, errorMessage];
}
