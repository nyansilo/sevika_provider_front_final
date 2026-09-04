// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../../core/usecases/usecase.dart';
// import '../../../domain/entities/customer_address_entity.dart';
// import '../../../domain/usecases/get_customer_addresses_usecase.dart';
// import '../../../domain/usecases/add_customer_address_usecase.dart';
// import '../../../domain/usecases/update_customer_address_usecase.dart';
// import '../../../domain/usecases/delete_customer_address_usecase.dart';
// import '../../../domain/usecases/params/address_payload_params.dart';
// import 'customer_address_state.dart'; // 🎯 FIX: Changed 'use' to 'import'

// class CustomerAddressCubit extends Cubit<CustomerAddressState> {
//   final GetCustomerAddressesUseCase getAddressesUseCase;
//   final AddCustomerAddressUseCase addAddressUseCase;
//   final UpdateCustomerAddressUseCase updateAddressUseCase;
//   final DeleteCustomerAddressUseCase deleteAddressUseCase;

//   List<CustomerAddressEntity> _cachedAddresses = [];

//   CustomerAddressCubit({
//     required this.getAddressesUseCase,
//     required this.addAddressUseCase,
//     required this.updateAddressUseCase,
//     required this.deleteAddressUseCase,
//   }) : super(const CustomerAddressInitial());

//   /// 📥 Fetch all user addresses from the API infrastructure
//   Future<void> loadAddresses() async {
//     emit(const CustomerAddressLoading());
//     final result = await getAddressesUseCase.call(const NoParams());

//     result.fold((failure) => emit(CustomerAddressError(failure)), (
//       addressesList,
//     ) {
//       _cachedAddresses = List.from(addressesList);
//       emit(CustomerAddressLoaded(_cachedAddresses));
//     });
//   }

//   /// ➕ Add a new destination node safely
//   Future<void> registerAddress(AddressPayloadParams params) async {
//     emit(const CustomerAddressSubmitting());
//     final result = await addAddressUseCase.call(params);

//     result.fold((failure) => emit(CustomerAddressError(failure)), (newAddress) {
//       _updateLocalCacheWith(newAddress);
//       emit(
//         const CustomerAddressActionSuccess('Address registered successfully!'),
//       );
//       emit(CustomerAddressLoaded(_cachedAddresses));
//     });
//   }

//   /// ✏️ Edit an existing configuration block
//   Future<void> editAddress({
//     required String addressId,
//     required AddressPayloadParams params,
//   }) async {
//     emit(const CustomerAddressSubmitting());
//     final result = await updateAddressUseCase.call(
//       UpdateCustomerAddressParams(addressId: addressId, params: params),
//     );

//     result.fold((failure) => emit(CustomerAddressError(failure)), (
//       updatedAddress,
//     ) {
//       _updateLocalCacheWith(updatedAddress);
//       emit(
//         const CustomerAddressActionSuccess(
//           'Address details updated successfully!',
//         ),
//       );
//       emit(CustomerAddressLoaded(_cachedAddresses));
//     });
//   }

//   /// 🗑️ Atomically destroy an address mapping node
//   Future<void> removeAddress(String addressId) async {
//     emit(const CustomerAddressSubmitting());
//     final result = await deleteAddressUseCase.call(addressId);

//     result.fold((failure) => emit(CustomerAddressError(failure)), (_) {
//       _cachedAddresses.removeWhere((element) => element.addressId == addressId);
//       emit(
//         const CustomerAddressActionSuccess(
//           'Address removed from your profile.',
//         ),
//       );
//       emit(CustomerAddressLoaded(_cachedAddresses));
//     });
//   }

//   /// Local State Cache management algorithm
//   void _updateLocalCacheWith(CustomerAddressEntity structuralItem) {
//     if (structuralItem.isDefault) {
//       _cachedAddresses = _cachedAddresses.map((addr) {
//         return CustomerAddressEntity(
//           addressId: addr.addressId,
//           label: addr.label,
//           addressLine1: addr.addressLine1,
//           addressLine2: addr.addressLine2,
//           regionId: addr.regionId,
//           regionName: addr.regionName,
//           districtId: addr.districtId,
//           districtName: addr.districtName,
//           postalCode: addr.postalCode,
//           country: addr.country,
//           coordinates: addr.coordinates,
//           isDefault: false, // Wipes previous default flag indicators safely
//           createdAt: addr.createdAt,
//         );
//       }).toList();
//     }

//     final elementIndex = _cachedAddresses.indexWhere(
//       (element) => element.addressId == structuralItem.addressId,
//     );

//     if (elementIndex != -1) {
//       _cachedAddresses[elementIndex] = structuralItem;
//     } else {
//       _cachedAddresses.add(structuralItem);
//     }

//     // Sort configurations so that the default location remains at index 0
//     _cachedAddresses.sort((a, b) {
//       if (a.isDefault && !b.isDefault) return -1;
//       if (!a.isDefault && b.isDefault) return 1;
//       return 0;
//     });
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/customer_address_entity.dart';
import '../../../domain/usecases/get_customer_addresses_usecase.dart';
import '../../../domain/usecases/add_customer_address_usecase.dart';
import '../../../domain/usecases/update_customer_address_usecase.dart';
import '../../../domain/usecases/delete_customer_address_usecase.dart';
import '../../../domain/usecases/params/address_payload_params.dart';
import 'customer_address_state.dart';

class CustomerAddressCubit extends Cubit<CustomerAddressState> {
  final GetCustomerAddressesUseCase getAddressesUseCase;
  final AddCustomerAddressUseCase addAddressUseCase;
  final UpdateCustomerAddressUseCase updateAddressUseCase;
  final DeleteCustomerAddressUseCase deleteAddressUseCase;

  List<CustomerAddressEntity> _cachedAddresses = [];

  CustomerAddressCubit({
    required this.getAddressesUseCase,
    required this.addAddressUseCase,
    required this.updateAddressUseCase,
    required this.deleteAddressUseCase,
  }) : super(const CustomerAddressInitial());

  Future<void> loadAddresses() async {
    emit(const CustomerAddressLoading());
    final result = await getAddressesUseCase.call(const NoParams());

    if (isClosed) return; // 🎯 ADDED GUARD

    result.fold((failure) => emit(CustomerAddressError(failure)), (
      addressesList,
    ) {
      _cachedAddresses = List.from(addressesList);
      emit(CustomerAddressLoaded(_cachedAddresses));
    });
  }

  Future<void> registerAddress(AddressPayloadParams params) async {
    emit(const CustomerAddressSubmitting());
    final result = await addAddressUseCase.call(params);

    if (isClosed) return; // 🎯 ADDED GUARD

    result.fold((failure) => emit(CustomerAddressError(failure)), (newAddress) {
      _updateLocalCacheWith(newAddress);
      emit(
        const CustomerAddressActionSuccess('Address registered successfully!'),
      );
      emit(CustomerAddressLoaded(_cachedAddresses));
    });
  }

  Future<void> editAddress({
    required String addressId,
    required AddressPayloadParams params,
  }) async {
    emit(const CustomerAddressSubmitting());
    final result = await updateAddressUseCase.call(
      UpdateCustomerAddressParams(addressId: addressId, params: params),
    );

    if (isClosed) return; // 🎯 ADDED GUARD

    result.fold((failure) => emit(CustomerAddressError(failure)), (
      updatedAddress,
    ) {
      _updateLocalCacheWith(updatedAddress);
      emit(
        const CustomerAddressActionSuccess(
          'Address details updated successfully!',
        ),
      );
      emit(CustomerAddressLoaded(_cachedAddresses));
    });
  }

  Future<void> removeAddress(String addressId) async {
    emit(const CustomerAddressSubmitting());
    final result = await deleteAddressUseCase.call(addressId);

    if (isClosed) return; // 🎯 ADDED GUARD

    result.fold((failure) => emit(CustomerAddressError(failure)), (_) {
      _cachedAddresses.removeWhere((element) => element.addressId == addressId);
      emit(
        const CustomerAddressActionSuccess(
          'Address removed from your profile.',
        ),
      );
      emit(CustomerAddressLoaded(_cachedAddresses));
    });
  }

  void _updateLocalCacheWith(CustomerAddressEntity structuralItem) {
    if (structuralItem.isDefault) {
      _cachedAddresses = _cachedAddresses.map((addr) {
        return CustomerAddressEntity(
          addressId: addr.addressId,
          label: addr.label,
          addressLine1: addr.addressLine1,
          addressLine2: addr.addressLine2,
          regionId: addr.regionId,
          regionName: addr.regionName,
          districtId: addr.districtId,
          districtName: addr.districtName,
          postalCode: addr.postalCode,
          country: addr.country,
          coordinates: addr.coordinates,
          isDefault: false,
          createdAt: addr.createdAt,
        );
      }).toList();
    }

    final elementIndex = _cachedAddresses.indexWhere(
      (element) => element.addressId == structuralItem.addressId,
    );

    if (elementIndex != -1) {
      _cachedAddresses[elementIndex] = structuralItem;
    } else {
      _cachedAddresses.add(structuralItem);
    }

    _cachedAddresses.sort((a, b) {
      if (a.isDefault && !b.isDefault) return -1;
      if (!a.isDefault && b.isDefault) return 1;
      return 0;
    });
  }
}
