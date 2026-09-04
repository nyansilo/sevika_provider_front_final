import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final AppErrorType type;

  final String? message;

  final int? statusCode;

  final Map<String, dynamic>? validationErrors;

  const AppError(
    this.type, {
    this.message,
    this.statusCode,
    this.validationErrors,
  });

  @override
  String toString() {
    return '''err
AppError(
  type: $type,
  message: $message,
  statusCode: $statusCode,
  validationErrors: $validationErrors
)
''';
  }

  @override
  List<Object?> get props => [type, message, statusCode, validationErrors];
}

enum AppErrorType {
  /// Response parsing error
  parsing,

  /// 403
  forbidden,

  /// 400
  badRequest,

  /// Dio/API related
  api,

  /// No internet
  network,

  /// Local DB/cache
  database,

  /// 401
  unauthorized,

  /// 422
  validation,

  /// 404
  notFound,

  /// 500
  server,

  /// Timeout
  timeout,

  /// Unknown
  unknown,

  /// 🚀 ADDED: Represents a graceful user cancellation (prevents red error UI)
  cancelled,

  /// 🚀 Intercepts the 422 flow for social account linking
  socialAuthPasswordRequired,
}
