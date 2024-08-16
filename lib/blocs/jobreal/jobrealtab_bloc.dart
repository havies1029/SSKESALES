import 'package:equatable/equatable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/models/combobox/combojobcatgroup_model.dart';
import 'package:esalesapp/repositories/combobox/combojobcatgroup_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'jobrealtab_event.dart';
part 'jobrealtab_state.dart';

class JobRealTabBloc extends Bloc<JobRealTabEvents, JobRealTabState> {
  JobRealTabBloc() : super(const JobRealTabState()) {
    on<RefreshJobRealTabEvent>(onRefreshJobRealTab);
    on<SelectedJobRealTabEvent>(onSelectedTab);
  }

  Future<void> onRefreshJobRealTab(
      RefreshJobRealTabEvent event, Emitter<JobRealTabState> emit) async {
    debugPrint("onRefreshJobRealTab");

    emit(const JobRealTabState());

    ComboJobcatgroupRepository repo = ComboJobcatgroupRepository();
    if (state.status == ListStatus.initial) {
      List<ComboJobcatgroupModel> items =
          await repo.getComboJobCatGroupByPersonId(event.personId);
      return emit(state.copyWith(items: items, status: ListStatus.success));
    }
  }

  Future<void> onSelectedTab(
      SelectedJobRealTabEvent event, Emitter<JobRealTabState> emit) async {
    emit(state.copyWith(jobCatGroupId: event.jobCatGroupId));
  }
}
