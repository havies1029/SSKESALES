import 'package:equatable/equatable.dart';
import 'package:esalesapp/blocs/jobreal/jobreal2cari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealfoto_bloc.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/combobox/combojobcat_model.dart';
import 'package:esalesapp/models/combobox/combojob_model.dart';
import 'package:esalesapp/models/combobox/combomedia_model.dart';
import 'package:esalesapp/models/jobreal/jobrealcrud_model.dart';
import 'package:esalesapp/repositories/jobreal/jobrealcrud_repository.dart';

part 'jobrealcrud_event.dart';
part 'jobrealcrud_state.dart';

class JobRealCrudBloc extends Bloc<JobRealCrudEvents, JobRealCrudState> {
  final JobRealCrudRepository repository;
  final JobReal2CariBloc jobReal2CariBloc;
  final JobRealFotoBloc jobRealFotoBloc;
  JobRealCrudBloc(
      {required this.repository,
      required this.jobReal2CariBloc,
      required this.jobRealFotoBloc})
      : super(const JobRealCrudState()) {
    on<JobRealCrudUbahEvent>(onUbahJobRealCrud);
    on<JobRealCrudTambahEvent>(onTambahJobRealCrud);
    on<JobRealCrudHapusEvent>(onHapusJobRealCrud);
    on<JobRealCrudLihatEvent>(onLihatJobRealCrud);
    on<ComboJobcatChangedEvent>(onComboJobcatChanged);
    on<ComboJobChangedEvent>(onComboJobChanged);
    on<ComboMediaChangedEvent>(onComboMediaChanged);
    on<ComboCustomerJobRealCrudChangedEvent>(onComboCustomerChanged);
    on<JobRealCrudResetStateEvent>(onResetState);
    on<JobRealCrudPreOpenEvent>(onPreOpen);
  }

  Future<void> onPreOpen(
      JobRealCrudPreOpenEvent event, Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(viewMode: event.viewmode));
  }

  Future<void> onResetState(
      JobRealCrudResetStateEvent event, Emitter<JobRealCrudState> emit) async {
    debugPrint("JobRealCrudResetStateEvent -> onResetState");

    emit(state.copyWith(
        record: JobRealCrudModel(),
        comboCustomer: const ComboCustomerModel(),
        comboJob: const ComboJobModel(),
        comboJobCat: const ComboJobcatModel(),
        comboMedia: const ComboMediaModel(),
        isLoaded: false,
        isLoading: false,
        isSaved: false,
        isSaving: false,
        viewMode: ""));
  }

  Future<void> onTambahJobRealCrud(
      JobRealCrudTambahEvent event, Emitter<JobRealCrudState> emit) async {
    ReturnDataAPI returnData;
    bool hasFailure = true;
    emit(state.copyWith(isSaving: true, isSaved: false));
    returnData = await repository.jobRealCrudTambah(event.record);
    hasFailure = !returnData.success;

    if (!hasFailure) {
      String jobReal1Id = returnData.data;
      jobReal2CariBloc
          .add(Update2ApiJobReal2Event(jobreal1Id: jobReal1Id));

      var fotoState = jobRealFotoBloc.state;
      jobRealFotoBloc.add(UploadFotoJobRealEvent(
          jobReal1Id: jobReal1Id, filePath: fotoState.fotoPath));
    }

    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onUbahJobRealCrud(
      JobRealCrudUbahEvent event, Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(isSaving: true, isSaved: false, hasFailure: false));
    bool hasFailure = !await repository.jobRealCrudUbah(event.record);
    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onHapusJobRealCrud(
      JobRealCrudHapusEvent event, Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(isSaving: true, isSaved: false, hasFailure: false));
    bool hasFailure = !await repository.jobRealCrudHapus(event.recordId);
    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onLihatJobRealCrud(
      JobRealCrudLihatEvent event, Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));
    JobRealCrudModel record = await repository.jobRealCrudLihat(event.recordId);

    ComboJobcatModel? comboJobcat = record.comboJobcat;
    ComboJobModel? comboJob = record.comboJob;
    ComboCustomerModel? comboCustomer = record.comboCustomer;
    ComboMediaModel? comboMedia = record.comboMedia;

    emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
        record: record,
        comboCustomer: comboCustomer,
        comboJob: comboJob,
        comboJobCat: comboJobcat,
        comboMedia: comboMedia));
  }

  Future<void> onComboJobcatChanged(
      ComboJobcatChangedEvent event, Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ComboJobcatModel comboJobcat = event.comboJobcat;

    emit(state.copyWith(
        isLoading: false, isLoaded: true, comboJobCat: comboJobcat));
  }

  Future<void> onComboJobChanged(
      ComboJobChangedEvent event, Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ComboJobModel comboJob = event.comboJob;

    emit(state.copyWith(isLoading: false, isLoaded: true, comboJob: comboJob));
  }

  Future<void> onComboCustomerChanged(
      ComboCustomerJobRealCrudChangedEvent event,
      Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ComboCustomerModel comboCustomer = event.comboCustomer;
    JobRealCrudModel rec = state.record!;
    rec.mrekanId = comboCustomer.mrekanId;
    rec.comboCustomer = comboCustomer;

    emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
        record: rec,
        comboCustomer: comboCustomer));
  }

  Future<void> onComboMediaChanged(
      ComboMediaChangedEvent event, Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ComboMediaModel comboMedia = event.comboMedia;
    JobRealCrudModel rec = state.record!;
    rec.mmediaId = comboMedia.mmediaId;
    rec.comboMedia = comboMedia;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: rec));
  }
}
