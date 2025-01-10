import 'package:equatable/equatable.dart';
import 'package:esalesapp/blocs/jobreal/jobreal2cari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal2grid_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal3cari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal3grid_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealfoto_bloc.dart';
import 'package:esalesapp/common/app_data.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/models/combobox/comboinsurer_model.dart';
import 'package:esalesapp/models/jobreal/jobreal2cari_model.dart';
import 'package:esalesapp/models/jobreal/jobreal3cari_model.dart';
import 'package:esalesapp/models/jobreal/newbriefinginitvalue_model.dart';
import 'package:esalesapp/models/soaclient/tasksoainit_model.dart';
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
  final JobReal3CariBloc jobReal3CariBloc;
  final JobRealFotoBloc jobRealFotoBloc;
  final JobReal2GridBloc jobReal2GridBloc;
  final JobReal3GridBloc jobReal3GridBloc;
  JobRealCrudBloc(
      {required this.repository,
      required this.jobReal2CariBloc,
      required this.jobReal3CariBloc,
      required this.jobRealFotoBloc,
      required this.jobReal2GridBloc,
      required this.jobReal3GridBloc})
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
    on<JobRealOtorisasiEvent>(onOtorisasiJobReal);
    on<ComboInsurerJobRealCrudChangedEvent>(onComboInsurerChange);
    on<Request2RefreshJobRealCrudEvent>(onRequest2Refresh);
    on<UndoComboCustomerJobRealCrudChangedEvent>(onUndoComboCustomerChanged);
    on<FinishedUndoComboCustomerJobRealCrudChangedEvent>(
        onFinishedUndoComboCustomerChanged);
    on<GetInitValueNewBriefingHarianModeEvent>(
        onGetInitValueNewBriefingHarianMode);
    on<GetInitValueNewSOAClientModeEvent>(onGetInitValueSOAClientMode);
    on<SetFotoUploadedEvent>(onSetFotoUploadedEvent);
  }

  Future<void> onPreOpen(
      JobRealCrudPreOpenEvent event, Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(viewMode: event.viewmode));
  }

  Future<void> onGetInitValueNewBriefingHarianMode(
      GetInitValueNewBriefingHarianModeEvent event,
      Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    NewBriefingInitValueModel initValue = await repository
        .jobRealGetNewBriefingInitValue(event.jobId, event.jobCatId);

    JobRealCrudModel record = JobRealCrudModel(
        picName: initValue.pic,
        taskDesc: initValue.taskDesc,
        materi: initValue.perihal);

    emit(state.copyWith(
        comboCustomer: initValue.comboCustomer,
        comboJob: initValue.comboJob,
        comboJobCat: initValue.comboJobcat,
        comboMedia: initValue.comboMedia,
        isLoaded: true,
        isLoading: false,
        record: record));
  }

  Future<void> onGetInitValueSOAClientMode(
      GetInitValueNewSOAClientModeEvent event,
      Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    TasksoainitModel initValue =
        await repository.jobRealGetNewSoaClientInitValue(event.dn1Id);

    JobRealCrudModel record = JobRealCrudModel(
        mrekanId: initValue.mrekanId,
        materi: initValue.materi,
        mjobcatId: initValue.mjobcatId,
        comboJobcat: initValue.comboJobcat,
        comboCustomer: initValue.comboCustomer);

    emit(state.copyWith(
        comboCustomer: initValue.comboCustomer,
        comboJobCat: initValue.comboJobcat,
        record: record,
        isLoaded: true,
        isLoading: false));

    //set grid cob
    JobReal3CariModel dnCOB = JobReal3CariModel(
        mcobId: initValue.comboCob.mcobId,
        cobNama: initValue.comboCob.cobNama,
        isChecked: true,
        jobreal3Id: "");
    List<JobReal3CariModel> pickedCob = [];
    pickedCob.add(dnCOB);

    jobReal3GridBloc.add(GetPickedCobJobReal3ListEvent(pickedCob: pickedCob));
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
    //debugPrint("onTambahJobRealCrud #10");

    ReturnDataAPI returnData;
    bool hasFailure = true;
    emit(state.copyWith(isSaving: true, isSaved: false));
    returnData = await repository.jobRealCrudTambah(event.record);
    hasFailure = !returnData.success;

    if (!hasFailure) {
      //debugPrint("onTambahJobRealCrud #20");
      String jobReal1Id = returnData.data;

      jobReal2CariBloc.add(ReplaceSelectedSppaJobReal2CariEvent(
          selectedSPPA: event.selectedSppa));

      /*
      debugPrint(
          "jobReal2CariBloc.state.selectedItems #101 : ${jsonEncode(jobReal2CariBloc.state.selectedItems)}");
      */
      jobReal2CariBloc.add(Update2ApiJobReal2Event(jobreal1Id: jobReal1Id));
      jobReal3CariBloc.add(Update2ApiJobReal3Event(jobreal1Id: jobReal1Id));

      var fotoState = jobRealFotoBloc.state;
      if (fotoState.isPendingUpload) {
        if (fotoState.imageSource == "camera") {
          jobRealFotoBloc.add(UploadFotoJobRealEvent(
              jobReal1Id: jobReal1Id,
              filePath: fotoState.fotoPath,
              imageSource: fotoState.imageSource));
        } else if (fotoState.imageSource == "gallery") {
          jobRealFotoBloc.add(UploadFotoBytesJobRealEvent(
              jobReal1Id: jobReal1Id,
              fileName: fotoState.fileName,
              bytes: fotoState.fotoBytes!,
              imageSource: fotoState.imageSource));
        }
      }
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
    ComboInsurerModel? comboInsurer = record.comboInsurer;

    emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
        record: record,
        comboCustomer: comboCustomer,
        comboJob: comboJob,
        comboJobCat: comboJobcat,
        comboMedia: comboMedia,
        comboInsurer: comboInsurer,
        requireComboInsurer: (comboInsurer == null?false:true)));
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

  Future<void> onComboInsurerChange(ComboInsurerJobRealCrudChangedEvent event,
      Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ComboInsurerModel comboInsurer = event.comboInsurer;
    ComboJobcatModel comboJobCat = const ComboJobcatModel();
    ComboJobModel comboJob = const ComboJobModel();

    emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
        comboInsurer: comboInsurer,
        comboJobCat: comboJobCat,
        comboJob: comboJob));
  }

  Future<void> onComboCustomerChanged(
      ComboCustomerJobRealCrudChangedEvent event,
      Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(
        isLoading: true, isLoaded: false, requireComboInsurer: false));

    ComboCustomerModel comboCustomer = event.comboCustomer;
    //ComboJobcatModel comboJobcat = const ComboJobcatModel();
    //ComboJobModel comboJob = const ComboJobModel();
    String rekanType = comboCustomer.rekanType;
    bool requireComboInsurer = false;

    //debugPrint("AppData.userCabang : ${AppData.userCabang}");
    //debugPrint("comboCustomer.rekanType : ${comboCustomer.rekanType}");

    if (AppData.userCabang == "teknik") {
      if (rekanType == "customer") {
        requireComboInsurer = true;
      }
    }

    //reset grid sppa
    jobReal2GridBloc.add(ResetStateJobReal2ListEvent());
    jobReal2CariBloc.add(ResetStateJobReal2CariEvent());

    emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
        //comboJobCat: comboJobcat,
        //comboJob: comboJob,
        comboCustomer: comboCustomer,
        requireComboInsurer: requireComboInsurer));
  }

  Future<void> onUndoComboCustomerChanged(
      UndoComboCustomerJobRealCrudChangedEvent event,
      Emitter<JobRealCrudState> emit) async {
    debugPrint("onUndoComboCustomerChanged");

    emit(state.copyWith(isLoading: true, isLoaded: false));

    ComboCustomerModel? comboCustomer = event.comboCustomer;

    emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
        comboCustomer: comboCustomer,
        forceChangeComboCustomer: true));
  }

  Future<void> onFinishedUndoComboCustomerChanged(
      FinishedUndoComboCustomerJobRealCrudChangedEvent event,
      Emitter<JobRealCrudState> emit) async {
    debugPrint("onFinishedUndoComboCustomerChanged");
    emit(state.copyWith(forceChangeComboCustomer: false));
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

  Future<void> onOtorisasiJobReal(
      JobRealOtorisasiEvent event, Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(isSaving: true, isSaved: false, hasFailure: false));
    ReturnDataAPI result = await repository.jobRealOtorisasi(event.recordId);
    emit(state.copyWith(
        isSaving: false, isSaved: true, hasFailure: result.success));
  }

  Future<void> onRequest2Refresh(Request2RefreshJobRealCrudEvent event,
      Emitter<JobRealCrudState> emit) async {
    emit(state.copyWith(isLoading: false, isLoaded: true));
  }

  Future<void> onSetFotoUploadedEvent(
      SetFotoUploadedEvent event, Emitter<JobRealCrudState> emit) async {
    //debugPrint("onSetFotoUploadedEvent");
    //emit(state.copyWith(isSaving: true, isSaved: false));

    JobRealCrudModel rec = state.record!;
    rec.hasFoto = true;

    //emit(state.copyWith(isSaving: false, isSaved: true, record: rec));
    emit(state.copyWith(record: rec));
  }
}
