import 'package:equatable/equatable.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/mstproject/projectlist_model.dart';
import 'package:esalesapp/repositories/mstproject/projectlist_repository.dart';

part 'projectlist_event.dart';
part 'projectlist_state.dart';

class ProjectListBloc extends Bloc<ProjectListEvents, ProjectListState> {
  ProjectListBloc() : super(const ProjectListState()) {
    on<FetchProjectListEvent>(onFetchProjectList);
    on<RefreshProjectListEvent>(onRefreshProjectList);
    on<UbahProjectListEvent>(onUbahProjectList);
    on<TambahProjectListEvent>(onTambahProjectList);
    on<HapusProjectListEvent>(onHapusProjectList);
    on<CloseDialogProjectListEvent>(onCloseDialogProjectList);
    on<StartProjectListEvent>(onStartProject);
  }

  Future<void> onRefreshProjectList(
      RefreshProjectListEvent event, Emitter<ProjectListState> emit) async {
    emit(const ProjectListState());

    emit(state.copyWith(searchText: event.searchText, rekanId: event.rekanId));
    add(FetchProjectListEvent());
  }

  Future<void> onFetchProjectList(
      FetchProjectListEvent event, Emitter<ProjectListState> emit) async {
    if (state.hasReachedMax) return;

    ProjectListRepository repo = ProjectListRepository();
    if (state.status == ListStatus.initial) {
      List<ProjectListModel> items =
          await repo.getProjectList(state.rekanId, state.searchText, 0);
      return emit(state.copyWith(
          items: items,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: 1));
    }
    List<ProjectListModel> items =
        await repo.getProjectList(state.rekanId, state.searchText, state.hal);
    if (items.isEmpty) {
      return emit(state.copyWith(hasReachedMax: true));
    } else {
      List<ProjectListModel> projectList = List.of(state.items)..addAll(items);

      final result = projectList
          .whereWithIndex((e, index) =>
              projectList.indexWhere((e2) => e2.mprojectId == e.mprojectId) ==
              index)
          .toList();

      return emit(state.copyWith(
          items: result,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: state.hal + 1));
    }
  }

  Future<void> onHapusProjectList(
      HapusProjectListEvent event, Emitter<ProjectListState> emit) async {
    emit(state.copyWith(viewMode: ""));
    emit(state.copyWith(viewMode: "hapus"));
  }

  Future<void> onCloseDialogProjectList(
      CloseDialogProjectListEvent event, Emitter<ProjectListState> emit) async {
    emit(state.copyWith(viewMode: ""));
  }

  Future<void> onTambahProjectList(
      TambahProjectListEvent event, Emitter<ProjectListState> emit) async {
    emit(state.copyWith(viewMode: ""));
    emit(state.copyWith(viewMode: "tambah"));
  }

  Future<void> onUbahProjectList(
      UbahProjectListEvent event, Emitter<ProjectListState> emit) async {
    emit(state.copyWith(viewMode: ""));
    emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
  }

  Future<void> onStartProject(
      StartProjectListEvent event, Emitter<ProjectListState> emit) async {
    //debugPrint("onStartProject");
    emit(state.copyWith(started: false, hasFailure: false));

    ProjectListRepository repository = ProjectListRepository();
    ReturnDataAPI returnData = await repository.projectStart(event.projectId);
    bool started = returnData.success;

    emit(state.copyWith(started: started, hasFailure: !started, errorMsg: returnData.data));

    //debugPrint("onStartProject -> started : $started");
    //debugPrint("onStartProject -> state.started : ${state.started}");
  }
}
