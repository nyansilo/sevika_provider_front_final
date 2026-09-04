import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/usecase.dart';

import '../../../domain/usecases/get_profile_use_case.dart';
import '../../../domain/usecases/params/update_profile_params.dart';
import '../../../domain/usecases/update_profile_use_case.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  ProfileCubit({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
  }) : super(const ProfileInitial());

  /// 🔄 Retrieves the complete nested profile model graph from the backend catalog
  Future<void> loadProfile() async {
    emit(const ProfileLoading());

    final result = await getProfileUseCase.call(const NoParams());

    // 🎯 OPTIMIZED: Guard clause prevents crashes if the user closes the screen
    // before the Laravel backend responds.
    if (isClosed) return;

    result.fold(
      (error) => emit(ProfileFailure(error)),
      (profile) => emit(ProfileLoaded(profile: profile)),
    );
  }

  /// 🚀 Mutates profile data parameters safely across server-side boundary tables
  Future<void> updateProfile(UpdateProfileParams params) async {
    // 🛡️ Guard against execution blocks if profile state isn't active
    if (state is! ProfileLoaded) return;
    final currentLoadedState = state as ProfileLoaded;

    // Trigger local inline loading while safely scrubbing trailing flash state messages
    emit(currentLoadedState.copyWith(isUpdating: true, clearAlerts: true));

    final result = await updateProfileUseCase.call(params);

    // 🎯 OPTIMIZED: Secondary guard clause for the mutation network pipeline
    if (isClosed) return;

    result.fold(
      (error) =>
          emit(currentLoadedState.copyWith(isUpdating: false, error: error)),
      (updatedProfile) => emit(
        ProfileLoaded(
          profile: updatedProfile,
          successMessage: 'Your profile settings have been successfully synchronized across data networks.',
        ),
      ),
    );
  }
}
