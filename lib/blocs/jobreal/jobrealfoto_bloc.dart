import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:esalesapp/helper/image_helper.dart';
import 'package:esalesapp/models/image/downloadfileinfo64.dart';
import 'package:esalesapp/repositories/jobreal/jobrealfoto_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'jobrealfoto_event.dart';
part 'jobrealfoto_state.dart';

class JobRealFotoBloc extends Bloc<JobRealFotoEvents, JobRealFotoState> {  
  final JobRealFotoRepository repository;  

  JobRealFotoBloc({required this.repository})
      : super(const JobRealFotoState()) {   
    on<UploadFotoJobRealEvent>(onUploadFile);
    on<DownloadFotoJobRealEvent>(onDownloadFile);
    on<HapusFotoAPIJobRealEvent>(onHapusFotoAPI);
    on<HapusFotoStateJobRealFotoEvent>(onHapusFotoState);
    on<ResetStateJobRealFotoEvent>(onResetState);
    on<Save2StateFotoJobRealEvent>(onSave2State);
  }

  Future<void> onResetState(
      ResetStateJobRealFotoEvent event, Emitter<JobRealFotoState> emit) async {
    emit(state.copyWith(
        isUploaded: false,
        isUploading: false,
        isDownloaded: false,
        isDownloading: false,
        isDeleted: false,
        isDeleting: false,
        hasFailure: false,
        fotoPath: ""));
  }

  Future<void> onSave2State(
      Save2StateFotoJobRealEvent event, Emitter<JobRealFotoState> emit) async {
    emit(state.copyWith(isUploading: true, isUploaded: false));

    emit(state.copyWith(
        isUploading: false, isUploaded: true, fotoPath: event.filePath));
  }

  Future<void> onUploadFile(
      UploadFotoJobRealEvent event, Emitter<JobRealFotoState> emit) async {
    emit(state.copyWith(isUploading: true, isUploaded: false));

    await repository.uploadFotoJobReal(event.jobReal1Id, event.filePath);
    //debugPrint("event.filePath : ${event.filePath}");
    emit(state.copyWith(
        isUploading: false, isUploaded: true, fotoPath: event.filePath));
  }

  Future<void> onDownloadFile(
      DownloadFotoJobRealEvent event, Emitter<JobRealFotoState> emit) async {
    debugPrint("onDownloadFile #10");

    emit(state.copyWith(isDownloading: true, isDownloaded: false));

    DownloadFileInfo64Model? fileInfo =
        await repository.downloadFotoJobReal(event.jobReal1Id);

    //debugPrint("fileInfo : ${fileInfo.toString()}");

    debugPrint("onDownloadFile #20");

    if (fileInfo != null) {
      //debugPrint("fileInfo.datafile64! : ${fileInfo.datafile64}");

      ImageHelper helper = ImageHelper();
      Uint8List bytes = base64Decode(fileInfo.datafile64!);

      debugPrint("onDownloadFile #30");

      String filePath = await helper.convertBytes2LocalImage(
          fileName: fileInfo.namafile, bytes: bytes);

      debugPrint("onDownloadFile #40");

      debugPrint("event.filePath : $filePath");

      emit(state.copyWith(
          isDownloading: false,
          isDownloaded: true,
          //fileFoto: fileFoto,
          fotoPath: filePath));
    } else {
      emit(state.copyWith(
          isDownloading: false, isDownloaded: false, fotoPath: ""));
    }
  }

  Future<void> onHapusFotoAPI(
      HapusFotoAPIJobRealEvent event, Emitter<JobRealFotoState> emit) async {
    emit(state.copyWith(isDeleting: true, isDeleted: false));
    bool hasFailure = !await repository.jobRealCrudHapusFoto(event.jobReal1Id);
    emit(state.copyWith(
        isDeleting: false,
        isDeleted: true,
        hasFailure: hasFailure,
        fotoPath: ""));
  }

  Future<void> onHapusFotoState(
    HapusFotoStateJobRealFotoEvent event, Emitter<JobRealFotoState> emit) async {

    emit(state.copyWith(isDeleting: true, isDeleted: false));

    emit(state.copyWith(
      isDeleting: false,
      isDeleted: true,
      fotoPath: ""));

  }
  
}
