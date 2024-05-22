import 'package:equatable/equatable.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/jobreal/jobreal2cari_model.dart';
import 'package:esalesapp/repositories/jobreal/jobreal2cari_repository.dart';

part 'jobreal2cari_event.dart';
part 'jobreal2cari_state.dart';

class JobReal2CariBloc extends Bloc<JobReal2CariEvents, JobReal2CariState> {
  JobReal2CariBloc() : super(const JobReal2CariState()) {
    on<FetchJobReal2CariEvent>(onFetchJobReal2Cari);
    on<RefreshJobReal2CariEvent>(onRefreshJobReal2Cari);
    on<Update2ApiJobReal2Event>(onUpdate2ApiJobReal2);
    //on<Update2StateJobReal2Event>(onUpdate2StateJobReal2);
    on<RequestToUpdateJobReal2Event>(onRequestToUpdate);
    on<UpdateCheckboxJobReal2Event>(onUpdateCheckboxChanged);
    on<ResetStateJobReal2CariEvent>(onResetState);
  }

  Future<void> onResetState(ResetStateJobReal2CariEvent event,
      Emitter<JobReal2CariState> emit) async {
    emit(state.copyWith(
        status: ListStatus.initial,
        items: <JobReal2CariModel>[],
        hasReachedMax: false,
        isSaving: false,
        isSaved: false,
        hasFailure: false,
        requestToUpdate: false));
  }

  Future<void> onRefreshJobReal2Cari(
      RefreshJobReal2CariEvent event, Emitter<JobReal2CariState> emit) async {
    debugPrint("onRefreshJobReal2Cari");

    emit(const JobReal2CariState());

    //await Future.delayed(const Duration(seconds: 1));

    add(FetchJobReal2CariEvent(
        custId: event.custId, jobreal1Id: event.jobreal1Id));
  }

  Future<void> onFetchJobReal2Cari(
      FetchJobReal2CariEvent event, Emitter<JobReal2CariState> emit) async {
    debugPrint("onFetchJobReal2Cari");

    if (state.hasReachedMax) return;

    JobReal2CariRepository repo = JobReal2CariRepository();
    if (state.status == ListStatus.initial) {
      List<JobReal2CariModel> items =
          await repo.getJobReal2Cari(event.custId, event.jobreal1Id);

      return emit(state.copyWith(
          items: items, hasReachedMax: false, status: ListStatus.success));
    }
    List<JobReal2CariModel> items =
        await repo.getJobReal2Cari(event.custId, event.jobreal1Id);
    if (items.isEmpty) {
      return emit(state.copyWith(hasReachedMax: true));
    } else {
      List<JobReal2CariModel> jobReal2Cari = List.of(state.items)
        ..addAll(items);

      final result = jobReal2Cari
          .whereWithIndex((e, index) =>
              jobReal2Cari.indexWhere((e2) => e2.jobreal2Id == e.jobreal2Id) ==
              index)
          .toList();

      return emit(state.copyWith(
          items: result, hasReachedMax: false, status: ListStatus.success));
    }
  }

  Future<void> onUpdate2StateJobReal2(
      Update2StateJobReal2Event event, Emitter<JobReal2CariState> emit) async {
    emit(state.copyWith(
        isSaving: true,
        isSaved: false,
        hasFailure: false,
        requestToUpdate: false));
    List<JobReal2CariModel> jobReal2List = state.items;
    List<JobReal2CariCheckboxModel> listCheckbox =
        List<JobReal2CariCheckboxModel>.generate(
            jobReal2List.length,
            (index) => JobReal2CariCheckboxModel(
                polis1Id: jobReal2List[index].polis1Id,
                isChecked: jobReal2List[index].isChecked));

    listCheckbox.removeWhere((element) => !element.isChecked);

    emit(state.copyWith(isSaving: false, isSaved: true));
  }

  Future<void> onUpdate2ApiJobReal2(
      Update2ApiJobReal2Event event, Emitter<JobReal2CariState> emit) async {

    debugPrint("onUpdate2ApiJobReal2 #10");

    emit(state.copyWith(
        isSaving: true,
        isSaved: false,
        hasFailure: false,
        requestToUpdate: false));
    bool hasFailure = false;

    if (event.jobreal1Id.isNotEmpty) {
      List<JobReal2CariModel> jobReal2List = state.items;
      List<JobReal2CariCheckboxModel> listCheckbox =
          List<JobReal2CariCheckboxModel>.generate(
              jobReal2List.length,
              (index) => JobReal2CariCheckboxModel(
                  polis1Id: jobReal2List[index].polis1Id,
                  isChecked: jobReal2List[index].isChecked));

      listCheckbox.removeWhere((element) => !element.isChecked);
      if (listCheckbox.isNotEmpty) {
        JobReal2CariRepository repo = JobReal2CariRepository();
        ReturnDataAPI returnApi =
            await repo.jobReal2UpdateList(event.jobreal1Id, listCheckbox);
        hasFailure = !returnApi.success;
      }
    }

    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onRequestToUpdate(RequestToUpdateJobReal2Event event,
      Emitter<JobReal2CariState> emit) async {
    debugPrint("onRequestToUpdate");
    emit(state.copyWith(requestToUpdate: false));
    emit(state.copyWith(requestToUpdate: true));
    debugPrint("onRequestToUpdate requestToUpdate : ${state.requestToUpdate}");
  }

  Future<void> onUpdateCheckboxChanged(UpdateCheckboxJobReal2Event event,
      Emitter<JobReal2CariState> emit) async {
    emit(state.copyWith(status: ListStatus.initial));

    JobReal2CariModel itemCheckbox = event.jobReal2Item;
    itemCheckbox.isChecked = event.isChecked;

    List<JobReal2CariModel> items = state.items;

    //debugPrint("before : items : ${jsonEncode(items)}");

    //debugPrint("itemCheckbox.polis1Id : ${itemCheckbox.polis1Id}");

    items[items.indexWhere(
        (element) => element.polis1Id == itemCheckbox.polis1Id)] = itemCheckbox;

    //debugPrint("after : state.items : ${jsonEncode(items)}");

    emit(state.copyWith(items: items, status: ListStatus.success));
  }
}
