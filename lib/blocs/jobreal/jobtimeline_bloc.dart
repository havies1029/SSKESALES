import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/jobreal/jobtimeline_model.dart';
import 'package:esalesapp/repositories/jobreal/jobtimeline_repository.dart';

part 'jobtimeline_event.dart';
part 'jobtimeline_state.dart';

class JobtimelineBloc extends Bloc<JobtimelineEvents, JobtimelineState> {
  JobtimelineBloc() : super(const JobtimelineState()) {
    on<FetchJobtimelineEvent>(onFetchJobtimeline);
    on<RefreshJobtimelineEvent>(onRefreshJobtimeline);
  }

  Future<void> onRefreshJobtimeline(
      RefreshJobtimelineEvent event, Emitter<JobtimelineState> emit) async {
    debugPrint("onRefreshJobtimeline");

    emit(const JobtimelineState());

    emit(state.copyWith(
        jobRealId: event.jobRealId, polisId: event.polisId, hal: 0));

    add(const FetchJobtimelineEvent());
  }

  Future<void> onFetchJobtimeline(
      FetchJobtimelineEvent event, Emitter<JobtimelineState> emit) async {
    
    debugPrint("onFetchJobtimeline");

    if (state.hasReachedMax) return;

    JobtimelineRepository repo = JobtimelineRepository();
    if (state.status == ListStatus.initial) {
      List<JobtimelineModel> items = state.polisId.isNotEmpty
          ? await repo.getJobtimelineBySppa(state.jobRealId, state.polisId, 0)
          : await repo.getJobtimelineNonSppa(state.jobRealId, 0);

      items.sort((a, b) => b.jobTgl.compareTo(a.jobTgl));

      return emit(state.copyWith(
          items: items,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: 1));
    }
    List<JobtimelineModel> items = state.polisId.isNotEmpty
        ? await repo.getJobtimelineBySppa(
            state.jobRealId, state.polisId, state.hal)
        : await repo.getJobtimelineNonSppa(state.jobRealId, state.hal);
    if (items.isEmpty) {
      return emit(state.copyWith(hasReachedMax: true));
    } else {
      List<JobtimelineModel> jobtimeline = List.of(state.items)..addAll(items);

      final result = jobtimeline
          .whereWithIndex((e, index) =>
              jobtimeline.indexWhere((e2) => e2.jobName == e.jobName) == index)
          .toList();

      result.sort((a, b) => b.jobTgl.compareTo(a.jobTgl));

      return emit(state.copyWith(
          items: result,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: state.hal + 1));
    }
  }
}
