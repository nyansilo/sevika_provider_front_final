import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/explore_open_jobs_usecase.dart';
import '../../domain/usecases/params/marketplace_pagination_params.dart';
import 'explore_jobs_state.dart';

class ExploreJobsCubit extends Cubit<ExploreJobsState> {
  final ExploreOpenJobsUseCase useCase;
  ExploreJobsCubit({required this.useCase}) : super(ExploreJobsInitial());

  Future<void> fetchJobs() async {
    emit(ExploreJobsLoading());
    final result = await useCase.call(
      const MarketplacePaginationParams(page: 1, perPage: 15),
    );
    if (isClosed) return;
    result.fold(
      (error) => emit(ExploreJobsFailure(error)),
      (jobs) => emit(ExploreJobsSuccess(jobs)),
    );
  }
}
