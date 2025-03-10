import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:esalesapp/models/combobox/combocob_model.dart';
import 'package:esalesapp/models/combobox/combommstjobcat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/models/mstproject/projectcrud_model.dart';
import 'package:esalesapp/repositories/mstproject/projectcrud_repository.dart';

part 'projectcrud_event.dart';
part 'projectcrud_state.dart';

class ProjectCrudBloc extends Bloc<ProjectCrudEvents, ProjectCrudState> {
  final ProjectCrudRepository repository;
  ProjectCrudBloc({required this.repository})
      : super(const ProjectCrudState()) {
    on<ProjectCrudUbahEvent>(onUbahProjectCrud);
    on<ProjectCrudTambahEvent>(onTambahProjectCrud);
    on<ProjectCrudHapusEvent>(onHapusProjectCrud);
    on<ProjectCrudLihatEvent>(onLihatProjectCrud);
    on<ComboCustomerChangedEvent>(onComboCustomerChanged);
    on<ComboCobChangedEvent>(onComboCobChanged);
    on<ComboMstJobCatChangedEvent>(onComboMstJobCatChanged);
  }

  Future<void> onTambahProjectCrud(
      ProjectCrudTambahEvent event, Emitter<ProjectCrudState> emit) async {
    ReturnDataAPI returnData;
    bool hasFailure = true;
    emit(state.copyWith(isSaving: true, isSaved: false));
    returnData = await repository.projectCrudTambah(event.record);
    hasFailure = !returnData.success;
    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onUbahProjectCrud(
      ProjectCrudUbahEvent event, Emitter<ProjectCrudState> emit) async {
    emit(state.copyWith(isSaving: true, isSaved: false));
    debugPrint("onUbahProjectCrud");
    debugPrint("onUbahProjectCrud event.record : ${event.record.toJson()}");
    bool hasFailure = !await repository.projectCrudUbah(event.record);
    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onHapusProjectCrud(
      ProjectCrudHapusEvent event, Emitter<ProjectCrudState> emit) async {
    emit(state.copyWith(isSaving: true, isSaved: false));
    bool hasFailure = !await repository.projectCrudHapus(event.recordId);
    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onLihatProjectCrud(
      ProjectCrudLihatEvent event, Emitter<ProjectCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    debugPrint("onLihatProjectCrud #10");

    ProjectCrudModel record = await repository.projectCrudLihat(event.recordId);

    debugPrint(
        "onLihatProjectCrud -> record.comboCob : ${jsonEncode(record.comboCob?.toJson())}");

    emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
        record: record,
        comboCustomer: record.comboCustomer,
        comboCob: record.comboCob ?? ComboCobModel(),
        comboMstJobCat: record.comboMstJobCat ?? ComboMMstJobcatModel()));
  }

  Future<void> onComboCustomerChanged(
      ComboCustomerChangedEvent event, Emitter<ProjectCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ComboCustomerModel comboCustomer = event.comboCustomer;
    emit(state.copyWith(
        isLoading: false, isLoaded: true, comboCustomer: comboCustomer));
  }

  Future<void> onComboCobChanged(
      ComboCobChangedEvent event, Emitter<ProjectCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ComboCobModel comboCob = event.comboCob;
    emit(state.copyWith(isLoading: false, isLoaded: true, comboCob: comboCob));
  }

  Future<void> onComboMstJobCatChanged(
      ComboMstJobCatChangedEvent event, Emitter<ProjectCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ComboMMstJobcatModel comboMstJobCat = event.comboMstJobCat;
    emit(state.copyWith(
        isLoading: false, isLoaded: true, comboMstJobCat: comboMstJobCat));
  }
}
