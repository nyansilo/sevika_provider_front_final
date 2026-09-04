// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:path_provider/path_provider.dart';

// import '../../../../core/constants/api_endpoints.dart';
// import '../../../../core/network/base_remote_data_source.dart';
// import '../../../../core/network/dio_client.dart';
// import '../../domain/usecases/params/update_booking_status_params.dart';
// import '../../domain/usecases/params/confirm_cash_receipt_params.dart';
// import '../../domain/usecases/params/booking_pagination_params.dart';
// import '../../domain/usecases/params/download_invoice_params.dart';
// import '../../domain/usecases/params/cancel_booking_params.dart'; // 🎯 ADDED
// import '../models/booking_model.dart';
// import '../models/booking_response_model.dart';

// abstract class BookingRemoteDataSource {
//   Future<BookingResponseModel> fetchProviderBookings(
//     BookingPaginationParams params,
//   );
//   Future<BookingModel> updateBookingStatus(UpdateBookingStatusParams params);
//   Future<BookingModel> confirmCashReceipt(ConfirmCashReceiptParams params);
//   Future<BookingModel> acceptEmergencyDispatch(String dispatchId);

//   // 👨‍🔧 ADDED: Abstract method for cancelling
//   Future<BookingModel> cancelBooking(CancelBookingParams params);

//   Future<String> downloadInvoice(DownloadInvoiceParams params);
// }

// class BookingRemoteDataSourceImpl extends BaseRemoteDataSource
//     implements BookingRemoteDataSource {
//   final DioClient dioClient;

//   BookingRemoteDataSourceImpl(this.dioClient);

//   @override
//   Future<BookingResponseModel> fetchProviderBookings(
//     BookingPaginationParams params,
//   ) async {
//     // 👨‍🔧 Calls ProviderBookingController@index
//     final response = await dioClient.get(
//       ApiEndpoints.providerBookings,
//       queryParameters: params.toQueryParameters(),
//     );
//     return BookingResponseModel.fromJson(response.data);
//   }

//   @override
//   Future<BookingModel> updateBookingStatus(
//     UpdateBookingStatusParams params,
//   ) async {
//     // 👨‍🔧 Calls ProviderBookingController@update using the REFERENCE in the URL
//     final response = await dioClient.put(
//       // Or .patch, depending on your Laravel Route setup
//       '${ApiEndpoints.providerBookings}/${params.bookingReference}/status',
//       data: params.toJson(),
//     );
//     return BookingModel.fromJson(response.data['data'] ?? response.data);
//   }

//   @override
//   Future<BookingModel> confirmCashReceipt(
//     ConfirmCashReceiptParams params,
//   ) async {
//     // 👨‍🔧 Calls ProviderBookingController@confirmCashReceipt
//     final response = await dioClient.post(
//       '${ApiEndpoints.providerBookings}/${params.bookingReference}/confirm-cash',
//     );
//     return BookingModel.fromJson(response.data['data'] ?? response.data);
//   }

//   @override
//   Future<BookingModel> acceptEmergencyDispatch(String dispatchId) async {
//     // 👨‍🔧 Calls ProviderEmergencyController@accept
//     final response = await dioClient.post(
//       '${ApiEndpoints.providerEmergencies}/$dispatchId/accept',
//     );
//     return BookingModel.fromJson(response.data['data'] ?? response.data);
//   }

//   // 👨‍🔧 ADDED: Executes the API call to cancel the assigned job
//   @override
//   Future<BookingModel> cancelBooking(CancelBookingParams params) async {
//     final response = await dioClient.post(
//       '${ApiEndpoints.providerBookings}/${params.bookingReference}/cancel',
//       data: params.toJson(),
//     );
//     return BookingModel.fromJson(response.data['data'] ?? response.data);
//   }

//   @override
//   Future<String> downloadInvoice(DownloadInvoiceParams params) async {
//     String targetUrl = params.invoiceUrl;

//     if (targetUrl.startsWith('/')) {
//       final String cleanBaseUrl = ApiEndpoints.baseUrl.endsWith('/')
//           ? ApiEndpoints.baseUrl.substring(0, ApiEndpoints.baseUrl.length - 1)
//           : ApiEndpoints.baseUrl;
//       targetUrl = '$cleanBaseUrl$targetUrl';
//     } else if (targetUrl.contains('127.0.0.1:8000') ||
//         targetUrl.contains('localhost:8000')) {
//       targetUrl = targetUrl.replaceAll(':8000', ':8001');
//     }

//     targetUrl = ApiEndpoints.sanitizeBackendUrl(targetUrl);

//     try {
//       final response = await dioClient.get(
//         targetUrl,
//         options: Options(
//           responseType: ResponseType.bytes,
//           headers: {
//             'Accept': 'application/pdf',
//             'ngrok-skip-browser-warning': 'true',
//           },
//         ),
//       );

//       final Directory tempDir = await getTemporaryDirectory();
//       final String filePath =
//           '${tempDir.path}/SVK_Payout_${params.bookingReference}.pdf';
//       final File file = File(filePath);

//       await file.writeAsBytes(response.data);
//       return filePath;
//     } catch (e) {
//       debugPrint('❌ Error downloading invoice: $e');
//       rethrow;
//     }
//   }
// }

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/base_remote_data_source.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/usecases/params/update_booking_status_params.dart';
import '../../domain/usecases/params/confirm_cash_receipt_params.dart';
import '../../domain/usecases/params/booking_pagination_params.dart';
import '../../domain/usecases/params/download_invoice_params.dart';
import '../../domain/usecases/params/cancel_booking_params.dart'; // 🎯 ADDED
import '../models/booking_model.dart';
import '../models/booking_response_model.dart';

abstract class BookingRemoteDataSource {
  Future<BookingResponseModel> fetchProviderBookings(
    BookingPaginationParams params,
  );
  Future<BookingModel> updateBookingStatus(UpdateBookingStatusParams params);
  Future<BookingModel> confirmCashReceipt(ConfirmCashReceiptParams params);
  Future<BookingModel> acceptEmergencyDispatch(String dispatchId);

  // 👨‍🔧 ADDED: Abstract method for cancelling
  Future<BookingModel> cancelBooking(CancelBookingParams params);

  // 🎯 ADDED: Abstract method for fetching single job details
  Future<BookingModel> fetchJobDetails(String reference);

  Future<String> downloadInvoice(DownloadInvoiceParams params);
}

class BookingRemoteDataSourceImpl extends BaseRemoteDataSource
    implements BookingRemoteDataSource {
  final DioClient dioClient;

  BookingRemoteDataSourceImpl(this.dioClient);

  @override
  Future<BookingResponseModel> fetchProviderBookings(
    BookingPaginationParams params,
  ) async {
    // 👨‍🔧 Calls ProviderBookingController@index
    final response = await dioClient.get(
      ApiEndpoints.providerBookings,
      queryParameters: params.toQueryParameters(),
    );
    return BookingResponseModel.fromJson(response.data);
  }

  // 🎯 ADDED: Executes the actual API call to Laravel's show() method
  @override
  Future<BookingModel> fetchJobDetails(String reference) async {
    final response = await dioClient.get(
      '${ApiEndpoints.providerBookings}/$reference',
    );
    return BookingModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<BookingModel> updateBookingStatus(
    UpdateBookingStatusParams params,
  ) async {
    // 👨‍🔧 Calls ProviderBookingController@update using the REFERENCE in the URL
    final response = await dioClient.put(
      // Or .patch, depending on your Laravel Route setup
      '${ApiEndpoints.providerBookings}/${params.bookingReference}/status',
      data: params.toJson(),
    );
    return BookingModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<BookingModel> confirmCashReceipt(
    ConfirmCashReceiptParams params,
  ) async {
    // 👨‍🔧 Calls ProviderBookingController@confirmCashReceipt
    final response = await dioClient.post(
      '${ApiEndpoints.providerBookings}/${params.bookingReference}/confirm-cash',
    );
    return BookingModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<BookingModel> acceptEmergencyDispatch(String dispatchId) async {
    // 👨‍🔧 Calls ProviderEmergencyController@accept
    final response = await dioClient.post(
      '${ApiEndpoints.providerEmergencies}/$dispatchId/accept',
    );
    return BookingModel.fromJson(response.data['data'] ?? response.data);
  }

  // 👨‍🔧 ADDED: Executes the API call to cancel the assigned job
  @override
  Future<BookingModel> cancelBooking(CancelBookingParams params) async {
    final response = await dioClient.post(
      '${ApiEndpoints.providerBookings}/${params.bookingReference}/cancel',
      data: params.toJson(),
    );
    return BookingModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<String> downloadInvoice(DownloadInvoiceParams params) async {
    String targetUrl = params.invoiceUrl;

    if (targetUrl.startsWith('/')) {
      final String cleanBaseUrl = ApiEndpoints.baseUrl.endsWith('/')
          ? ApiEndpoints.baseUrl.substring(0, ApiEndpoints.baseUrl.length - 1)
          : ApiEndpoints.baseUrl;
      targetUrl = '$cleanBaseUrl$targetUrl';
    } else if (targetUrl.contains('127.0.0.1:8000') ||
        targetUrl.contains('localhost:8000')) {
      targetUrl = targetUrl.replaceAll(':8000', ':8001');
    }

    targetUrl = ApiEndpoints.sanitizeBackendUrl(targetUrl);

    try {
      final response = await dioClient.get(
        targetUrl,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            'Accept': 'application/pdf',
            'ngrok-skip-browser-warning': 'true',
          },
        ),
      );

      final Directory tempDir = await getTemporaryDirectory();
      final String filePath =
          '${tempDir.path}/SVK_Payout_${params.bookingReference}.pdf';
      final File file = File(filePath);

      await file.writeAsBytes(response.data);
      return filePath;
    } catch (e) {
      debugPrint('❌ Error downloading invoice: $e');
      rethrow;
    }
  }
}
