import 'package:equatable/equatable.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/jobreal/jobreal2cari_model.dart';
import 'package:esalesapp/repositories/jobreal/jobreal2cari_repository.dart';

import '../../common/constants.dart';

part 'jobreal2cari_event.dart';
part 'jobreal2cari_state.dart';

class JobReal2CariBloc extends Bloc<JobReal2CariEvents, JobReal2CariState> {
  JobReal2CariBloc() : super(const JobReal2CariState()) {
    
    on<FetchJobReal2CariEvent>(onFetchJobReal2Cari);
    on<RefreshJobReal2CariEvent>(onRefreshJobReal2Cari);
    on<Update2ApiJobReal2Event>(onUpdate2ApiJobReal2);
    on<RequestToUpdateJobReal2Event>(onRequestToUpdate);
    on<UpdateCheckboxJobReal2Event>(onUpdateCheckboxChanged);
    on<ResetStateJobReal2CariEvent>(onResetState);
    on<InitialSelectedSPPAJobReal2Event>(onInitialSelectedSPPA);
    on<ResetStateJobReal2ForLoadDataPurposeCariEvent>(onResetState4LoadData);
    on<ReplaceSelectedSppaJobReal2CariEvent>(
        onReplaceSelectedSppaJobReal2CariEvent);
  }

  Future<void> onResetState(ResetStateJobReal2CariEvent event,
      Emitter<JobReal2CariState> emit) async {
    emit(state.copyWith(
        status: ListStatus.initial,
        items: <JobReal2CariModel>[],
        selectedItems: <JobReal2CariModel>[],
        hasReachedMax: false,
        isSaving: false,
        isSaved: false,
        hasFailure: false,
        requestToUpdate: false));
  }

  Future<void> onResetState4LoadData(
      ResetStateJobReal2ForLoadDataPurposeCariEvent event,
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

    //debugPrint("state.selectedItems before refreshing : ${jsonEncode(state.selectedItems)}");

    add(ResetStateJobReal2ForLoadDataPurposeCariEvent());

    //debugPrint("state.selectedItems after resetState4Loading : ${jsonEncode(state.selectedItems)}");

    //await Future.delayed(const Duration(seconds: 1));

    add(FetchJobReal2CariEvent(
        custId: event.custId,
        jobreal1Id: event.jobreal1Id,
        searchText: event.searchText));

    //debugPrint("state.selectedItems after refreshing : ${jsonEncode(state.selectedItems)}");
  }

  Future<void> onFetchJobReal2Cari(
      FetchJobReal2CariEvent event, Emitter<JobReal2CariState> emit) async {
    debugPrint("onFetchJobReal2Cari");

    if (state.hasReachedMax) return;

    JobReal2CariRepository repo = JobReal2CariRepository();
    if (state.status == ListStatus.initial) {
      List<JobReal2CariModel> items = await repo.getJobReal2Cari(
          event.custId, event.jobreal1Id, event.searchText, 0);

      items = await updateSelectedItem2List(state.selectedItems, items);

      return emit(state.copyWith(
          items: items,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: 1));
    }
    List<JobReal2CariModel> items = await repo.getJobReal2Cari(
        event.custId, event.jobreal1Id, event.searchText, state.hal);
    if (items.isEmpty) {
      return emit(state.copyWith(hasReachedMax: true));
    } else {
      debugPrint("onFetchJobReal2Cari #stage2");

      List<JobReal2CariModel> jobReal2Cari = List.of(state.items)
        ..addAll(items);

      //debugPrint("items : ${jsonEncode(items)}");

      var result = jobReal2Cari
          .whereWithIndex((e, index) =>
              jobReal2Cari.indexWhere((e2) => e2.jobreal2Id == e.jobreal2Id) ==
              index)
          .toList();

      result = await updateSelectedItem2List(state.selectedItems, result);

      return emit(state.copyWith(
          items: result,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: state.hal + 1));
    }
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
      debugPrint("onUpdate2ApiJobReal2 #20");

      /*
      debugPrint(
          "state.selectedItems before save : ${jsonEncode(state.selectedItems)}");
      */

      List<JobReal2CariModel> jobReal2List = state.selectedItems;
      List<JobReal2CariCheckboxModel> listCheckbox =
          List<JobReal2CariCheckboxModel>.generate(
              jobReal2List.length,
              (index) => JobReal2CariCheckboxModel(
                  polis1Id: jobReal2List[index].polis1Id,
                  isChecked: jobReal2List[index].isChecked));

      listCheckbox.removeWhere((element) => !element.isChecked);

      //debugPrint("listCheckbox : ${jsonEncode(listCheckbox)}");

      if (listCheckbox.isNotEmpty) {
        debugPrint("onUpdate2ApiJobReal2 #30");
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
    //debugPrint("onRequestToUpdate");
    emit(state.copyWith(requestToUpdate: false));
    emit(state.copyWith(requestToUpdate: true));
    //debugPrint("onRequestToUpdate requestToUpdate : ${state.requestToUpdate}");
  }

  Future<void> onUpdateCheckboxChanged(UpdateCheckboxJobReal2Event event,
      Emitter<JobReal2CariState> emit) async {
    debugPrint("onUpdateCheckboxChanged");

    debugPrint("onUpdateCheckboxChanged #10");

    JobReal2CariModel itemCheckbox = event.jobReal2Item;
    itemCheckbox.isChecked = event.isChecked;

    //debugPrint("onUpdateCheckboxChanged #20");

    List<JobReal2CariModel> items = state.items;

    items[items.indexWhere(
        (element) => element.polis1Id == itemCheckbox.polis1Id)] = itemCheckbox;

    debugPrint("onUpdateCheckboxChanged #30");

    /*
    debugPrint(
        "state.selectedItems before add : ${jsonEncode(state.selectedItems)}");
    */

    List<JobReal2CariModel> checked = [itemCheckbox];

    //debugPrint("onUpdateCheckboxChanged #40");

    //debugPrint("checked : ${jsonEncode(checked)}");

    List<JobReal2CariModel>? selectedItems =
        await updateSelectedItem(state.selectedItems, checked);

    //debugPrint("onUpdateCheckboxChanged #50");

    emit(state.copyWith(selectedItems: selectedItems));

    //debugPrint("onUpdateCheckboxChanged #60");

    //debugPrint("state.selectedItems after add : ${jsonEncode(state.selectedItems)}");

    emit(state.copyWith(items: items, status: ListStatus.success));
  }

  Future<List<JobReal2CariModel>> updateSelectedItem(
      List<JobReal2CariModel> selectedItems,
      List<JobReal2CariModel> newItems) async {
    //debugPrint("updateSelectedItem");

    //debugPrint("selectedItems : ${jsonEncode(selectedItems)}");

    List<JobReal2CariModel> result = <JobReal2CariModel>[];
    result.addAll(selectedItems);

    List<JobReal2CariModel> newSelectedItems = newItems
        .where(
          (element) => element.isChecked,
        )
        .toList();

    //debugPrint("new SelectedItems : ${jsonEncode(newSelectedItems)}");
    if (newSelectedItems.isNotEmpty) {
      //debugPrint("newSelectedItems.isNotEmpty : ${newSelectedItems.isNotEmpty}");
      result.addAll(newSelectedItems);
    }

    List<JobReal2CariModel> removedItems = newItems
        .where(
          (element) => !element.isChecked,
        )
        .toList();

    if (removedItems.isNotEmpty) {
      for (var element in removedItems) {
        result.removeWhere((e) => e.polis1Id == element.polis1Id);
      }
    }

    //debugPrint("removedItems : ${jsonEncode(removedItems)}");

    //debugPrint("result selectedItems : ${jsonEncode(result)}");
    //}
    return result;
  }

  Future<List<JobReal2CariModel>> updateSelectedItem2List(
      List<JobReal2CariModel> selectedIems,
      List<JobReal2CariModel> listItems) async {
    //debugPrint("updateSelectedItem2List");
    for (var item in selectedIems) {
      var index = listItems.indexWhere((e) {
        return e.polis1Id == item.polis1Id;
      });
      //debugPrint("index : $index");
      if (index >= 0) {
        listItems[listItems.indexWhere((e) {
          return e.polis1Id == item.polis1Id;
        })] = item;
      }
    }

    return listItems;
  }

  Future<void> onInitialSelectedSPPA(InitialSelectedSPPAJobReal2Event event,
      Emitter<JobReal2CariState> emit) async {
    debugPrint("initialSelectedSPPA");

    //debugPrint("event.selectedSPPA : ${jsonEncode(event.selectedSPPA)}");
    //set item as checked
    for (int i = 0; i < event.selectedSPPA.length; i++) {
      event.selectedSPPA[i].isChecked = true;
    }

    emit(state.copyWith(selectedItems: event.selectedSPPA));

    //debugPrint("state.selectedItems after initialing : ${jsonEncode(state.selectedItems)}");
  }

  Future<void> onReplaceSelectedSppaJobReal2CariEvent(
      ReplaceSelectedSppaJobReal2CariEvent event,
      Emitter<JobReal2CariState> emit) async {
    debugPrint("onReplaceSelectedSppaJobReal2CariEvent");

    emit(state.copyWith(selectedItems: event.selectedSPPA));
  }
}
