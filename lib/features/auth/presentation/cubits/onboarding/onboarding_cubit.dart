import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/storage/onboarding_storage_service.dart';

class OnboardingCubit extends Cubit<bool> {
  final OnboardingStorageService _storage;

  // Pass via constructor using GetIt injection
  OnboardingCubit(this._storage) : super(false);

  void checkOnboarding() {
    emit(_storage.isOnboardingDone());
  }

  Future<void> completeOnboarding() async {
    await _storage.setOnboardingDone();
    emit(true);
  }
}
