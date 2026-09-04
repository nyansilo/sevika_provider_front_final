import 'package:equatable/equatable.dart';

import '../../../../core/errors/app_error.dart';
import '../../domain/entities/open_job_request_entity.dart';

abstract class ExploreJobsState extends Equatable {
  const ExploreJobsState();
  @override
  List<Object?> get props => [];
}

class ExploreJobsInitial extends ExploreJobsState {}

class ExploreJobsLoading extends ExploreJobsState {}

class ExploreJobsSuccess extends ExploreJobsState {
  final List<OpenJobRequestEntity> jobs;
  const ExploreJobsSuccess(this.jobs);
  @override
  List<Object?> get props => [jobs];
}

class ExploreJobsFailure extends ExploreJobsState {
  final AppError error;
  const ExploreJobsFailure(this.error);
  @override
  List<Object?> get props => [error];
}
