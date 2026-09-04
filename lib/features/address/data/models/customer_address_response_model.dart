// data/models/customer_address_response_model.dart
// import '../../domain/entities/customer_address_entity.dart';
// import 'customer_address_model.dart';

// class CustomerAddressResponseModel {
//   final List<CustomerAddressModel> addresses;
//   final bool success;

//   CustomerAddressResponseModel({
//     required this.addresses,
//     required this.success,
//   });

//   List<CustomerAddressEntity> toEntityList() {
//     return addresses.map((model) => model.toEntity()).toList();
//   }

//   factory CustomerAddressResponseModel.fromJson(Map<String, dynamic> json) {
//     // Gracefully unwraps nested 'data' packet arrays vs root collections
//     final Map<String, dynamic> targetJson =
//         (json['data'] is Map<String, dynamic>) ? json['data'] : json;

//     final List<CustomerAddressModel> list = [];
//     final dynamic addressesData = targetJson['addresses'] ?? targetJson['data'];

//     if (addressesData is List) {
//       for (var element in addressesData) {
//         if (element is Map<String, dynamic>) {
//           list.add(CustomerAddressModel.fromJson(element));
//         }
//       }
//     }

//     return CustomerAddressResponseModel(
//       addresses: list,
//       success:
//           json['success'] as bool? ??
//           (json['data']?['success'] as bool? ?? true),
//     );
//   }
// }

import 'customer_address_model.dart';

class CustomerAddressResponseModel {
  final List<CustomerAddressModel> addresses;
  final bool success;

  CustomerAddressResponseModel({
    required this.addresses,
    required this.success,
  });

  factory CustomerAddressResponseModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> targetJson =
        (json['data'] is Map<String, dynamic>)
        ? json['data'] as Map<String, dynamic>
        : json;

    final List<CustomerAddressModel> list = [];
    final dynamic addressesData = targetJson['addresses'] ?? targetJson['data'];

    if (addressesData is List) {
      for (var element in addressesData) {
        if (element is Map<String, dynamic>) {
          list.add(CustomerAddressModel.fromJson(element));
        }
      }
    }

    return CustomerAddressResponseModel(
      addresses: list,
      success:
          json['success'] as bool? ??
          (json['data']?['success'] as bool? ?? true),
    );
  }
}
