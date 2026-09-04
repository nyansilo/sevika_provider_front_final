// import 'package:equatable/equatable.dart';
// import '../../../../core/errors/app_error.dart';

// abstract class AppConfigState extends Equatable {
//   const AppConfigState();

//   @override
//   List<Object?> get props => [];
// }

// class AppConfigInitial extends AppConfigState {}

// class AppConfigChecking extends AppConfigState {}

// // 🚀 ADDED: Dedicated Maintenance State
// class AppConfigUnderMaintenance extends AppConfigState {
//   final String? estimatedCompletionTime;

//   const AppConfigUnderMaintenance({this.estimatedCompletionTime});

//   @override
//   List<Object?> get props => [estimatedCompletionTime];
// }

// class AppConfigUpToDate extends AppConfigState {
//   // 🚀 ADDED: Flags for soft optional updates
//   final bool isSoftUpdateAvailable;
//   final String? storeUrl;

//   const AppConfigUpToDate({this.isSoftUpdateAvailable = false, this.storeUrl});

//   @override
//   List<Object?> get props => [isSoftUpdateAvailable, storeUrl];
// }

// class AppConfigUpdateRequired extends AppConfigState {
//   final String storeUrl;

//   const AppConfigUpdateRequired({required this.storeUrl});

//   @override
//   List<Object?> get props => [storeUrl];
// }

// class AppConfigFailure extends AppConfigState {
//   final AppError error;

//   const AppConfigFailure(this.error);

//   @override
//   List<Object?> get props => [error];
// }

import 'package:equatable/equatable.dart';
import '../../../../core/errors/app_error.dart';

abstract class AppConfigState extends Equatable {
  const AppConfigState();

  @override
  List<Object?> get props => [];
}

class AppConfigInitial extends AppConfigState {}

class AppConfigChecking extends AppConfigState {}

// 🚀 ADDED: Dedicated Maintenance State with support contact overrides
class AppConfigUnderMaintenance extends AppConfigState {
  final String? estimatedCompletionTime;
  final String? supportPhone;
  final String? supportWhatsapp;

  const AppConfigUnderMaintenance({
    this.estimatedCompletionTime,
    this.supportPhone,
    this.supportWhatsapp,
  });

  @override
  List<Object?> get props => [
    estimatedCompletionTime,
    supportPhone,
    supportWhatsapp,
  ];
}

class AppConfigUpToDate extends AppConfigState {
  // 🚀 ADDED: Flags for soft optional updates & support channels
  final bool isSoftUpdateAvailable;
  final String? storeUrl;
  final String? supportPhone;
  final String? supportWhatsapp;

  const AppConfigUpToDate({
    this.isSoftUpdateAvailable = false,
    this.storeUrl,
    this.supportPhone,
    this.supportWhatsapp,
  });

  @override
  List<Object?> get props => [
    isSoftUpdateAvailable,
    storeUrl,
    supportPhone,
    supportWhatsapp,
  ];
}

class AppConfigUpdateRequired extends AppConfigState {
  final String storeUrl;

  const AppConfigUpdateRequired({required this.storeUrl});

  @override
  List<Object?> get props => [storeUrl];
}

class AppConfigFailure extends AppConfigState {
  final AppError error;

  const AppConfigFailure(this.error);

  @override
  List<Object?> get props => [error];
}
