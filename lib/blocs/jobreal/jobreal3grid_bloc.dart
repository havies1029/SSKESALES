import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:esalesapp/blocs/jobreal/jobreal3cari_bloc.dart';
import 'package:esalesapp/models/jobreal/jobreal3cari_model.dart';
import 'package:esalesapp/repositories/jobreal/jobreal3cari_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';

import '../../common/constants.dart';

part 'jobreal3grid_event.dart';
part 'jobreal3grid_state.dart';

class JobReal3GridBloc extends Bloc<JobReal3GridEvents, JobReal3GridState> {
  final JobReal3CariBloc jobReal3CariBloc;
  //late final StreamSubscription jobReal3CariBlocSubscription;
  JobReal3GridBloc({required this.jobReal3CariBloc})
      : super(const JobReal3GridState()) {
    /*
    jobReal3CariBlocSubscription =
        jobReal3CariBloc.stream.listen((JobReal3CariState pickCobState) async {
      if (pickCobState.requestToUpdate) {
        var selectedCob =
            pickCobState.items.where((element) => element.isChecked).toList();

        //if (selectedCob.isNotEmpty) {
        //debugPrint("selectedCob : $selectedCob");
        add(GetPickedCobJobReal3ListEvent(pickedCob: selectedCob));
        //}
      } 
    });
    */

    on<FetchJobReal3GridEvent>(onFetchJobReal3Grid);
    on<RefreshJobReal3GridEvent>(onRefreshJobReal3Grid);
    on<ResetStateJobReal3ListEvent>(onResetState);
    on<ReloadGridJobReal3ListEvent>(onReloadGrid);
    on<GetPickedCobJobReal3ListEvent>(onGetPickedCob);
  }

  Future<void> onGetPickedCob(GetPickedCobJobReal3ListEvent event,
      Emitter<JobReal3GridState> emit) async {
    emit(state.copyWith(status: ListStatus.initial));
    emit(state.copyWith(status: ListStatus.success, items: event.pickedCob));
  }

  Future<void> onRefreshJobReal3Grid(
      RefreshJobReal3GridEvent event, Emitter<JobReal3GridState> emit) async {
    emit(const JobReal3GridState());

    debugPrint("onRefreshJobReal3Grid #10");

    //await Future.delayed(const Duration(seconds: 1));

    add(FetchJobReal3GridEvent(jobreal1Id: event.jobreal1Id));
  }

  Future<void> onFetchJobReal3Grid(
      FetchJobReal3GridEvent event, Emitter<JobReal3GridState> emit) async {
    if (state.hasReachedMax) return;

    debugPrint("onFetchJobReal3Grid #10");

    JobReal3CariRepository repo = JobReal3CariRepository();
    if (state.status == ListStatus.initial) {
      List<JobReal3CariModel> items =
          await repo.getJobReal3Grid(event.jobreal1Id);
      return emit(state.copyWith(
        items: items,
        hasReachedMax: false,
        status: ListStatus.success,
      ));
    }
    List<JobReal3CariModel> items =
        await repo.getJobReal3Grid(event.jobreal1Id);
    if (items.isEmpty) {
      return emit(state.copyWith(hasReachedMax: true, items: items));
    } else {
      List<JobReal3CariModel> jobReal3Grid = List.of(state.items)
        ..addAll(items);

      final result = jobReal3Grid
          .whereWithIndex((e, index) =>
              jobReal3Grid.indexWhere((e2) => e2.jobreal3Id == e.jobreal3Id) ==
              index)
          .toList();

      return emit(state.copyWith(
        items: result,
        hasReachedMax: false,
        status: ListStatus.success,
      ));
    }
  }

  Future<void> onReloadGrid(ReloadGridJobReal3ListEvent event,
      Emitter<JobReal3GridState> emit) async {
    emit(state.copyWith(status: ListStatus.initial));

    debugPrint("ReloadGridJobReal3ListEvent #10");

    emit(state.copyWith(status: ListStatus.success));
  }

  Future<void> onResetState(ResetStateJobReal3ListEvent event,
      Emitter<JobReal3GridState> emit) async {
    emit(state.copyWith(
        hasReachedMax: false,
        status: ListStatus.initial,
        items: <JobReal3CariModel>[]));
  }
}
