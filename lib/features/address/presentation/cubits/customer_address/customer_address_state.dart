// presentation/cubit/customer_address_state.dart
// import 'package:equatable/equatable.dart';

// import '../../../../../core/errors/app_error.dart';
// import '../../../domain/entities/customer_address_entity.dart';

// abstract class CustomerAddressState extends Equatable {
//   const CustomerAddressState();

//   @override
//   List<Object?> get props => [];
// }

// class CustomerAddressInitial extends CustomerAddressState {
//   const CustomerAddressInitial();
// }

// class CustomerAddressLoading extends CustomerAddressState {
//   const CustomerAddressLoading();
// }

// /// 🎯 PRIMARY FEED STATE: Holds your verified workbook listing
// class CustomerAddressLoaded extends CustomerAddressState {
//   final List<CustomerAddressEntity> addresses;

//   const CustomerAddressLoaded(this.addresses);

//   @override
//   List<Object?> get props => [addresses];
// }

// class CustomerAddressSubmitting extends CustomerAddressState {
//   const CustomerAddressSubmitting();
// }

// /// 🎉 ACTION SUCCESS STATE: Dispatched to trigger dynamic UI toast overlays or screen pops
// class CustomerAddressActionSuccess extends CustomerAddressState {
//   final String message;

//   const CustomerAddressActionSuccess(this.message);

//   @override
//   List<Object?> get props => [message];
// }

// /// ❌ CRITICAL FAULT STATE: Transmits standardized error messaging down to the screen views
// class CustomerAddressError extends CustomerAddressState {
//   final AppError error;

//   const CustomerAddressError(this.error);

//   @override
//   List<Object?> get props => [error];
// }

import 'package:equatable/equatable.dart';
import '../../../../../core/errors/app_error.dart';
import '../../../domain/entities/customer_address_entity.dart';

abstract class CustomerAddressState extends Equatable {
  const CustomerAddressState();

  @override
  List<Object?> get props => [];
}

class CustomerAddressInitial extends CustomerAddressState {
  const CustomerAddressInitial();
}

class CustomerAddressLoading extends CustomerAddressState {
  const CustomerAddressLoading();
}

class CustomerAddressLoaded extends CustomerAddressState {
  final List<CustomerAddressEntity> addresses;

  const CustomerAddressLoaded(this.addresses);

  @override
  List<Object?> get props => [addresses];
}

class CustomerAddressSubmitting extends CustomerAddressState {
  const CustomerAddressSubmitting();
}

class CustomerAddressActionSuccess extends CustomerAddressState {
  final String message;

  const CustomerAddressActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CustomerAddressError extends CustomerAddressState {
  final AppError error;

  const CustomerAddressError(this.error);

  @override
  List<Object?> get props => [error];
}
