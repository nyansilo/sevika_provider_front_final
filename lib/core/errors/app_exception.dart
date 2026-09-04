// class AppException implements Exception {
//   final String message;

//   final int? statusCode;

//   final Map<String, dynamic>? validationErrors;

//   AppException({required this.message, this.statusCode, this.validationErrors});
// }

import 'app_error.dart';

class AppException implements Exception {
  final String message;
  final int? statusCode;
  final AppErrorType?
  type; // 🚀 OPTIMIZATION: Holds type explicitly to prevent redundant parsing loops
  final Map<String, dynamic>? validationErrors;

  AppException({
    required this.message,
    this.statusCode,
    this.type,
    this.validationErrors,
  });
}

/// 🚀 ADDED: Specific exception to handle when a user manually closes
/// the Google, Apple, or Facebook native login modals.
class UserCancelledException implements Exception {
  final String message;
  UserCancelledException([
    this.message = 'The action was cancelled by the user.',
  ]);
}
