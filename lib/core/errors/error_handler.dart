// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'app_error.dart';
// import 'error_messages.dart';
// import 'app_exception.dart';

// class ErrorHandler {
//   static Future<AppError> handle(dynamic error) async {
//     /// 🚀 1. Handle Graceful User Cancellations (OAuth Modals)
//     if (error is UserCancelledException) {
//       return AppError(AppErrorType.cancelled, message: error.message);
//     }

//     /// 2. Handle explicitly thrown custom AppExceptions coming out of DioClient
//     if (error is AppException) {
//       return AppError(
//         error.type ?? _mapStatusCodeToType(error.statusCode),
//         message: error.message,
//         statusCode: error.statusCode,
//         validationErrors:
//             error.validationErrors, // 🚀 FIXED: Seamless structural forwarding
//       );
//     }

//     /// 3. Handle Dio Exceptions
//     if (error is DioException) {
//       final response = error.response;
//       final data = response?.data;
//       final statusCode = response?.statusCode;

//       switch (error.type) {
//         case DioExceptionType.connectionTimeout:
//         case DioExceptionType.receiveTimeout:
//         case DioExceptionType.sendTimeout:
//           return const AppError(
//             AppErrorType.timeout,
//             message: ErrorMessages.timeout,
//           );

//         case DioExceptionType.connectionError:
//           try {
//             // 🚀 THE FIX: Put a strict 2-second timeout boundary around DNS Lookups to prevent freezing on unstable mobile towers
//             final lookupResult = await InternetAddress.lookup(
//               'google.com',
//             ).timeout(const Duration(seconds: 2));

//             if (lookupResult.isNotEmpty &&
//                 lookupResult[0].rawAddress.isNotEmpty) {
//               return const AppError(
//                 AppErrorType.server,
//                 message: 'Unable to reach the server. Please try again later.',
//               );
//             }
//           } catch (_) {
//             // Fall through safely if network lookup drops completely
//           }
//           return const AppError(
//             AppErrorType.network,
//             message: ErrorMessages.noInternet,
//           );

//         case DioExceptionType.badResponse:
//           break; // Let the status code switch block evaluate the payload below

//         case DioExceptionType.cancel:
//           return AppError(
//             AppErrorType.unknown,
//             message: 'Request context was cancelled.',
//             statusCode: statusCode,
//           );

//         default:
//           if (response == null) {
//             return AppError(
//               AppErrorType.unknown,
//               message: ErrorMessages.unknown,
//               statusCode: statusCode,
//             );
//           }
//           break;
//       }

//       // Check common REST API status returns
//       switch (statusCode) {
//         case 400:
//           return AppError(
//             AppErrorType.badRequest,
//             message: _extractMessage(data) ?? 'Bad request',
//             statusCode: statusCode,
//           );

//         case 401:
//           return AppError(
//             AppErrorType.unauthorized,
//             message: _extractMessage(data) ?? ErrorMessages.unauthorized,
//             statusCode: statusCode,
//           );

//         case 403:
//           return AppError(
//             AppErrorType.forbidden,
//             message: _extractMessage(data) ?? 'Forbidden access',
//             statusCode: statusCode,
//           );

//         case 404:
//           return AppError(
//             AppErrorType.notFound,
//             message: _extractMessage(data) ?? 'Resource not found',
//             statusCode: statusCode,
//           );

//         case 422:
//           // 🚀 FIX: Safely parse validationErrors only if 'errors' is genuinely a Map
//           Map<String, dynamic>? parsedErrors;

//           if (data is Map<String, dynamic>) {
//             final rawErrors = data['errors'] ?? data['validationErrors'];
//             if (rawErrors is Map<String, dynamic>) {
//               parsedErrors = rawErrors;
//             } else if (rawErrors is List && rawErrors.isEmpty) {
//               parsedErrors = null; // Ignore empty lists completely
//             } else {
//               // If the entire fallback structure is the error map, use it
//               parsedErrors = data;
//             }
//           }

//           return AppError(
//             AppErrorType.validation,
//             message: _extractMessage(data) ?? 'Validation failed',
//             statusCode: statusCode,
//             validationErrors: parsedErrors, // 100% Type-Safe Now!
//           );

//         case 500:
//           return AppError(
//             AppErrorType.server,
//             message: _extractMessage(data) ?? ErrorMessages.serverError,
//             statusCode: statusCode,
//           );

//         default:
//           return AppError(
//             AppErrorType.api,
//             message: _extractMessage(data) ?? ErrorMessages.unknown,
//             statusCode: statusCode,
//           );
//       }
//     }

//     /// 3. Raw Socket Exception
//     if (error is SocketException) {
//       return const AppError(
//         AppErrorType.network,
//         message: ErrorMessages.noInternet,
//       );
//     }

//     /// 4. Structural Parsing Error
//     if (error is FormatException) {
//       return const AppError(
//         AppErrorType.parsing,
//         message: 'Data processing parsing anomaly.',
//       );
//     }

//     /// 5. Complete System Fallback
//     return AppError(AppErrorType.unknown, message: error.toString());
//   }

//   static AppErrorType _mapStatusCodeToType(int? statusCode) {
//     switch (statusCode) {
//       case 400:
//         return AppErrorType.badRequest;
//       case 401:
//         return AppErrorType.unauthorized;
//       case 403:
//         return AppErrorType.forbidden;
//       case 404:
//         return AppErrorType.notFound;
//       case 422:
//         return AppErrorType.validation;
//       case 500:
//         return AppErrorType.server;
//       default:
//         return AppErrorType.api;
//     }
//   }

//   static String? _extractMessage(dynamic data) {
//     if (data is Map<String, dynamic>) {
//       return data['message'] ?? data['error'];
//     }
//     return null;
//   }
// }

import 'dart:io';
import 'package:dio/dio.dart';
import 'app_error.dart';
import 'error_messages.dart';
import 'app_exception.dart';

class ErrorHandler {
  static Future<AppError> handle(dynamic error) async {
    /// 1. Handle Graceful User Cancellations
    if (error is UserCancelledException) {
      return AppError(AppErrorType.cancelled, message: error.message);
    }

    /// 2. Handle Custom AppExceptions
    if (error is AppException) {
      return AppError(
        error.type ?? _mapStatusCodeToType(error.statusCode),
        message: error.message,
        statusCode: error.statusCode,
        validationErrors: error.validationErrors,
      );
    }

    /// 3. Handle Dio Exceptions
    if (error is DioException) {
      final response = error.response;
      final data = response?.data;
      final statusCode = response?.statusCode;

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return const AppError(
            AppErrorType.timeout,
            message: ErrorMessages.timeout,
          );

        case DioExceptionType.connectionError:
          try {
            final lookupResult = await InternetAddress.lookup(
              'google.com',
            ).timeout(const Duration(seconds: 2));
            if (lookupResult.isNotEmpty &&
                lookupResult[0].rawAddress.isNotEmpty) {
              return const AppError(
                AppErrorType.server,
                message: 'Unable to reach the server. Please try again later.',
              );
            }
          } catch (_) {}
          return const AppError(
            AppErrorType.network,
            message: ErrorMessages.noInternet,
          );

        case DioExceptionType.badResponse:
          break;

        case DioExceptionType.cancel:
          return AppError(
            AppErrorType.unknown,
            message: 'Request context was cancelled.',
            statusCode: statusCode,
          );

        default:
          if (response == null) {
            return AppError(
              AppErrorType.unknown,
              message: ErrorMessages.unknown,
              statusCode: statusCode,
            );
          }
          break;
      }

      switch (statusCode) {
        case 400:
          return AppError(
            AppErrorType.badRequest,
            message: _extractMessage(data) ?? 'Bad request',
            statusCode: statusCode,
          );
        case 401:
          return AppError(
            AppErrorType.unauthorized,
            message: _extractMessage(data) ?? ErrorMessages.unauthorized,
            statusCode: statusCode,
          );
        case 403:
          return AppError(
            AppErrorType.forbidden,
            message: _extractMessage(data) ?? 'Forbidden access',
            statusCode: statusCode,
          );
        case 404:
          return AppError(
            AppErrorType.notFound,
            message: _extractMessage(data) ?? 'Resource not found',
            statusCode: statusCode,
          );

        case 422:
          // 🚀 INTERCEPT SOCIAL AUTH PASSWORD REQUIREMENT
          if (data is Map<String, dynamic> &&
              data['status'] == 'PASSWORD_REQUIRED') {
            return AppError(
              AppErrorType.socialAuthPasswordRequired,
              message:
                  _extractMessage(data) ?? 'Password required to link account.',
              statusCode: statusCode,
              validationErrors: data,
            );
          }

          // Standard Validation Parsing
          Map<String, dynamic>? parsedErrors;
          if (data is Map<String, dynamic>) {
            final rawErrors = data['errors'] ?? data['validationErrors'];
            if (rawErrors is Map<String, dynamic>) {
              parsedErrors = rawErrors;
            } else if (rawErrors is List && rawErrors.isEmpty) {
              parsedErrors = null;
            } else {
              parsedErrors = data;
            }
          }
          return AppError(
            AppErrorType.validation,
            message: _extractMessage(data) ?? 'Validation failed',
            statusCode: statusCode,
            validationErrors: parsedErrors,
          );

        case 500:
          return AppError(
            AppErrorType.server,
            message: _extractMessage(data) ?? ErrorMessages.serverError,
            statusCode: statusCode,
          );
        default:
          return AppError(
            AppErrorType.api,
            message: _extractMessage(data) ?? ErrorMessages.unknown,
            statusCode: statusCode,
          );
      }
    }

    if (error is SocketException) {
      return const AppError(
        AppErrorType.network,
        message: ErrorMessages.noInternet,
      );
    }
    if (error is FormatException) {
      return const AppError(
        AppErrorType.parsing,
        message: 'Data processing parsing anomaly.',
      );
    }

    return AppError(AppErrorType.unknown, message: error.toString());
  }

  static AppErrorType _mapStatusCodeToType(int? statusCode) {
    switch (statusCode) {
      case 400:
        return AppErrorType.badRequest;
      case 401:
        return AppErrorType.unauthorized;
      case 403:
        return AppErrorType.forbidden;
      case 404:
        return AppErrorType.notFound;
      case 422:
        return AppErrorType.validation;
      case 500:
        return AppErrorType.server;
      default:
        return AppErrorType.api;
    }
  }

  static String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) return data['message'] ?? data['error'];
    return null;
  }
}
