import 'package:equatable/equatable.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/jobreal/jobreal3cari_model.dart';
import 'package:esalesapp/repositories/jobreal/jobreal3cari_repository.dart';

import '../../common/constants.dart';

part 'jobreal3cari_event.dart';
part 'jobreal3cari_state.dart';

class JobReal3CariBloc extends Bloc<JobReal3CariEvents, JobReal3CariState> {
  JobReal3CariBloc() : super(const JobReal3CariState()) {
    on<FetchJobReal3CariEvent>(onFetchJobReal3Cari);
    on<RefreshJobReal3CariEvent>(onRefreshJobReal3Cari);
    on<Update2ApiJobReal3Event>(onUpdate2ApiJobReal3);
    on<RequestToUpdateJobReal3Event>(onRequestToUpdate);
    on<UpdateCheckboxJobReal3Event>(onUpdateCheckboxChanged);
    on<ResetStateJobReal3CariEvent>(onResetState);
    on<InitialSelectedCOBJobReal3Event>(onInitialSelectedCOB);
    on<ResetStateJobReal3ForLoadDataPurposeCariEvent>(onResetState4LoadData);
  }

  Future<void> onResetState(ResetStateJobReal3CariEvent event,
      Emitter<JobReal3CariState> emit) async {
    emit(state.copyWith(
        status: ListStatus.initial,
        items: <JobReal3CariModel>[],
        selectedItems: <JobReal3CariModel>[],
        hasReachedMax: false,
        isSaving: false,
        isSaved: false,
        hasFailure: false,
        requestToUpdate: false,
        hal: 0));
  }

    Future<void> onResetState4LoadData(
      ResetStateJobReal3ForLoadDataPurposeCariEvent event,
      Emitter<JobReal3CariState> emit) async {
      emit(state.copyWith(
        status: ListStatus.initial,
        items: <JobReal3CariModel>[],
        hasReachedMax: false,
        isSaving: false,
        isSaved: false,
        hasFailure: false,
        requestToUpdate: false,
        hal: 0));
  }

  Future<void> onRefreshJobReal3Cari(
      RefreshJobReal3CariEvent event, Emitter<JobReal3CariState> emit) async {

    //emit(const JobReal3CariState());    
    add(ResetStateJobReal3ForLoadDataPurposeCariEvent());

    debugPrint("onRefreshJobReal3Cari");
    //await Future.delayed(const Duration(seconds: 1));

    debugPrint("event.searchText : ${event.searchText}");

    add(FetchJobReal3CariEvent(
        jobreal1Id: event.jobreal1Id, searchText: event.searchText));
  }

  Future<void> onFetchJobReal3Cari(
      FetchJobReal3CariEvent event, Emitter<JobReal3CariState> emit) async {
    debugPrint("onFetchJobReal3Cari");

    if (state.hasReachedMax) return;

    debugPrint("state.status : ${state.status}");

    JobReal3CariRepository repo = JobReal3CariRepository();
    if (state.status == ListStatus.initial) {
      List<JobReal3CariModel> items =
          await repo.getJobReal3Cari(event.jobreal1Id, event.searchText, 0);

      items = await updateSelectedItem2List(state.selectedItems, items);

      return emit(state.copyWith(
          items: items,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: 1));
    }
    List<JobReal3CariModel> items = await repo.getJobReal3Cari(
        event.jobreal1Id, event.searchText, state.hal);
    if (items.isEmpty) {
      return emit(state.copyWith(hasReachedMax: true));
    } else {
      List<JobReal3CariModel> jobReal3Cari = List.of(state.items)
        ..addAll(items);

      var result = jobReal3Cari
          .whereWithIndex((e, index) =>
              jobReal3Cari.indexWhere((e2) => e2.jobreal3Id == e.jobreal3Id) ==
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

  Future<void> onUpdateCheckboxChanged(UpdateCheckboxJobReal3Event event,
      Emitter<JobReal3CariState> emit) async {
    //emit(state.copyWith(status: ListStatus.initial));

    debugPrint("onUpdateCheckboxChanged #10");

    JobReal3CariModel itemCheckbox = event.jobReal3Item;
    itemCheckbox.isChecked = event.isChecked;

    List<JobReal3CariModel> items = state.items;

    //debugPrint("before : items : ${jsonEncode(items)}");

    debugPrint("itemCheckbox.polis1Id : ${itemCheckbox.cobNama}");

    items[items.indexWhere(
      (element) => element.mcobId == itemCheckbox.mcobId)] = itemCheckbox;

    List<JobReal3CariModel> checked = [itemCheckbox];

    List<JobReal3CariModel>? selectedItems =
      await updateSelectedItem(state.selectedItems, checked);
    
    emit(state.copyWith(selectedItems: selectedItems));

    //debugPrint("after : state.items : ${jsonEncode(items)}");

    debugPrint("onUpdateCheckboxChanged #20");

    emit(state.copyWith(items: items, status: ListStatus.success));
  }

  Future<void> onRequestToUpdate(RequestToUpdateJobReal3Event event,
      Emitter<JobReal3CariState> emit) async {
    debugPrint("onRequestToUpdate");
    emit(state.copyWith(requestToUpdate: false));
    emit(state.copyWith(requestToUpdate: true));
    debugPrint("onRequestToUpdate requestToUpdate : ${state.requestToUpdate}");
  }

  Future<void> onUpdate2ApiJobReal3(
      Update2ApiJobReal3Event event, Emitter<JobReal3CariState> emit) async {
    debugPrint("onUpdate2ApiJobReal3 #10");

    emit(state.copyWith(
        isSaving: true,
        isSaved: false,
        hasFailure: false,
        requestToUpdate: false));
    bool hasFailure = false;

    if (event.jobreal1Id.isNotEmpty) {
      List<JobReal3CariModel> jobReal3List = state.selectedItems;
      List<JobReal3CariCheckboxModel> listCheckbox =
          List<JobReal3CariCheckboxModel>.generate(
              jobReal3List.length,
              (index) => JobReal3CariCheckboxModel(
                  mcobId: jobReal3List[index].mcobId,
                  isChecked: jobReal3List[index].isChecked));

      listCheckbox.removeWhere((element) => !element.isChecked);
      if (listCheckbox.isNotEmpty) {
        JobReal3CariRepository repo = JobReal3CariRepository();
        ReturnDataAPI returnApi =
            await repo.jobReal3UpdateList(event.jobreal1Id, listCheckbox);
        hasFailure = !returnApi.success;
      }
    }

    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onInitialSelectedCOB(InitialSelectedCOBJobReal3Event event,
      Emitter<JobReal3CariState> emit) async {
    ///debugPrint("initialSelectedCOB");

    //debugPrint("event.selectedCOB : ${jsonEncode(event.selectedCOB)}");
    //set item as checked
    for (int i = 0; i < event.selectedCOB.length; i++) {
      event.selectedCOB[i].isChecked = true;
    }

    emit(state.copyWith(selectedItems: event.selectedCOB));

    //debugPrint("state.selectedItems after initialing : ${jsonEncode(state.selectedItems)}");
  }

  Future<List<JobReal3CariModel>> updateSelectedItem2List(
      List<JobReal3CariModel> selectedIems,
      List<JobReal3CariModel> listItems) async {
    //debugPrint("updateSelectedItem2List");
    for (var item in selectedIems) {
      var index = listItems.indexWhere((e) {
        return e.mcobId == item.mcobId;
      });
      //debugPrint("index : $index");
      if (index >= 0) {
        listItems[listItems.indexWhere((e) {
          return e.mcobId == item.mcobId;
        })] = item;
      }
    }

    return listItems;
  }

  Future<List<JobReal3CariModel>> updateSelectedItem(
      List<JobReal3CariModel> selectedItems,
      List<JobReal3CariModel> newItems) async {
    //debugPrint("updateSelectedItem");

    //debugPrint("selectedItems : ${jsonEncode(selectedItems)}");

    List<JobReal3CariModel> result = <JobReal3CariModel>[];
    result.addAll(selectedItems);

    List<JobReal3CariModel> newSelectedItems = newItems
        .where(
          (element) => element.isChecked,
        )
        .toList();

    //debugPrint("new SelectedItems : ${jsonEncode(newSelectedItems)}");
    if (newSelectedItems.isNotEmpty) {
      //debugPrint("newSelectedItems.isNotEmpty : ${newSelectedItems.isNotEmpty}");
      result.addAll(newSelectedItems);
    }

    List<JobReal3CariModel> removedItems = newItems
        .where(
          (element) => !element.isChecked,
        )
        .toList();

    if (removedItems.isNotEmpty) {
      for (var element in removedItems) {
        result.removeWhere((e) => e.mcobId == element.mcobId);
      }
    }

    //debugPrint("removedItems : ${jsonEncode(removedItems)}");

    //debugPrint("result selectedItems : ${jsonEncode(result)}");
    //}
    return result;
  }

}
