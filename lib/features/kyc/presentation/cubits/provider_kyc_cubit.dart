// lib/features/kyc/presentation/cubit/provider_kyc_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_kyc_status_usecase.dart';
import '../../domain/usecases/submit_basic_kyc_usecase.dart';
import '../../domain/usecases/upgrade_to_pro_usecase.dart';
import '../../domain/usecases/params/submit_basic_kyc_params.dart';
import '../../domain/usecases/params/upgrade_to_pro_params.dart';
import 'provider_kyc_state.dart';

class ProviderKycCubit extends Cubit<ProviderKycState> {
  final GetKycStatusUseCase getKycStatusUseCase;
  final SubmitBasicKycUseCase submitBasicKycUseCase;
  final UpgradeToProUseCase upgradeToProUseCase;

  ProviderKycCubit({
    required this.getKycStatusUseCase,
    required this.submitBasicKycUseCase,
    required this.upgradeToProUseCase,
  }) : super(ProviderKycInitial());

  Future<void> fetchKycStatus() async {
    emit(ProviderKycLoading());

    final result = await getKycStatusUseCase.call(NoParams());
    if (isClosed) return;

    result.fold(
      (error) => emit(ProviderKycFailure(error)),
      (data) => emit(ProviderKycLoaded(data)),
    );
  }

  Future<void> submitBasicKyc(SubmitBasicKycParams params) async {
    emit(ProviderKycLoading());
    final result = await submitBasicKycUseCase.call(params);
    if (isClosed) return;

    result.fold((error) => emit(ProviderKycFailure(error)), (kycData) {
      emit(ProviderKycActionSuccess("Basic verification submitted.", kycData));
      // Soft refresh the UI state with the returned data
      emit(ProviderKycLoaded(kycData));
    });
  }

  Future<void> submitProUpgrade(UpgradeToProParams params) async {
    emit(ProviderKycLoading());
    final result = await upgradeToProUseCase.call(params);
    if (isClosed) return;

    result.fold(
      (error) => emit(
        ProviderKycFailure(error),
      ), // Will catch the 403 access restricted error
      (kycData) {
        emit(
          ProviderKycActionSuccess(
            "Professional documents submitted.",
            kycData,
          ),
        );
        emit(ProviderKycLoaded(kycData));
      },
    );
  }
}
