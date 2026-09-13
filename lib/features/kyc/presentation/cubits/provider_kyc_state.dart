// lib/features/kyc/presentation/cubit/provider_kyc_state.dart
import 'package:equatable/equatable.dart';

import '../../../../core/errors/app_error.dart';
import '../../domain/entities/provider_kyc_entity.dart';

abstract class ProviderKycState extends Equatable {
  const ProviderKycState();

  @override
  List<Object?> get props => [];
}

class ProviderKycInitial extends ProviderKycState {}

class ProviderKycLoading extends ProviderKycState {}

class ProviderKycLoaded extends ProviderKycState {
  final ProviderKycEntity kycData;
  const ProviderKycLoaded(this.kycData);

  @override
  List<Object?> get props => [kycData];
}

class ProviderKycFailure extends ProviderKycState {
  final AppError error;
  const ProviderKycFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class ProviderKycActionSuccess extends ProviderKycState {
  final String message;
  final ProviderKycEntity updatedKyc;

  const ProviderKycActionSuccess(this.message, this.updatedKyc);

  @override
  List<Object?> get props => [message, updatedKyc];
}
