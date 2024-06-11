import 'package:equatable/equatable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/mstjob/jobcari_model.dart';
import 'package:esalesapp/repositories/mstjob/jobcari_repository.dart';

part 'jobcari_event.dart';
part 'jobcari_state.dart';

class JobCariBloc extends Bloc<JobCariEvents, JobCariState> {
  JobCariBloc() : super(const JobCariState()) {
    on<FetchJobCariEvent>(onFetchJobCari);
    on<RefreshJobCariEvent>(onRefreshJobCari);
    on<UbahJobCariEvent>(onUbahJobCari);
    on<TambahJobCariEvent>(onTambahJobCari);
    on<HapusJobCariEvent>(onHapusJobCari);
    on<CloseDialogJobCariEvent>(onCloseDialogJobCari);
    on<InitDataJobCariEvent>(onInitData);
  }

  Future<void> onRefreshJobCari(
      RefreshJobCariEvent event, Emitter<JobCariState> emit) async {
    emit(const JobCariState());
    emit(state.copyWith(personId: event.personId));
    await Future.delayed(const Duration(seconds: 1));

    add(FetchJobCariEvent(hal: 0, searchText: event.searchText));
  }

  Future<void> onInitData(
      InitDataJobCariEvent event, Emitter<JobCariState> emit) async {
    debugPrint("onInitData event.personId : ${event.personId}");
    emit(state.copyWith(personId: event.personId));
  }

  Future<void> onFetchJobCari(
      FetchJobCariEvent event, Emitter<JobCariState> emit) async {
    if (state.hasReachedMax) return;

    JobCariRepository repo = JobCariRepository();
    if (state.status == ListStatus.initial) {
      debugPrint("onFetchJobCari state.personId : ${state.personId}");

      List<JobCariModel> items =
          await repo.getJobCari(state.personId, event.searchText, 0);
      return emit(state.copyWith(
          items: items,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: 1));
    }
    List<JobCariModel> items =
        await repo.getJobCari(state.personId, event.searchText, state.hal);
    if (items.isEmpty) {
      return emit(state.copyWith(hasReachedMax: true));
    } else {
      List<JobCariModel> jobCari = List.of(state.items)..addAll(items);

      final result = jobCari
          .whereWithIndex((e, index) =>
              jobCari.indexWhere((e2) => e2.mjobId == e.mjobId) == index)
          .toList();

      return emit(state.copyWith(
          items: result,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: state.hal + 1));
    }
  }

  Future<void> onHapusJobCari(
      HapusJobCariEvent event, Emitter<JobCariState> emit) async {
    return emit(state.copyWith(viewMode: "hapus"));
  }

  Future<void> onCloseDialogJobCari(
      CloseDialogJobCariEvent event, Emitter<JobCariState> emit) async {
    return emit(state.copyWith(viewMode: ""));
  }

  Future<void> onTambahJobCari(
      TambahJobCariEvent event, Emitter<JobCariState> emit) async {
    return emit(state.copyWith(viewMode: "tambah"));
  }

  Future<void> onUbahJobCari(
      UbahJobCariEvent event, Emitter<JobCariState> emit) async {
    return emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
  }
}
