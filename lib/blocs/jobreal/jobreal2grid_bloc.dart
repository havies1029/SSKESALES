import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:esalesapp/blocs/jobreal/jobreal2cari_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/jobreal/jobreal2cari_model.dart';
import 'package:esalesapp/repositories/jobreal/jobreal2cari_repository.dart';

import '../../common/constants.dart';

part 'jobreal2grid_event.dart';
part 'jobreal2grid_state.dart';

class JobReal2GridBloc extends Bloc<JobReal2ListEvents, JobReal2GridState> {
  final JobReal2CariBloc jobReal2CariBloc;
  late final StreamSubscription jobReal2CariBlocSubscription;
  JobReal2GridBloc({required this.jobReal2CariBloc})
      : super(const JobReal2GridState()) {
    jobReal2CariBlocSubscription = jobReal2CariBloc.stream
        .listen((JobReal2CariState pickPolisState) async {
      if (pickPolisState.requestToUpdate) {
        var selectedPolicies =
            pickPolisState.items.where((element) => element.isChecked).toList();

        //if (selectedPolicies.isNotEmpty) {
        add(GetPickedPoliciesJobReal2ListEvent(
            pickedPolicies: selectedPolicies));
        //}
      }
    });

    on<FetchJobReal2ListEvent>(onFetchJobReal2List);
    on<RefreshJobReal2ListEvent>(onRefreshJobReal2List);
    on<ResetStateJobReal2ListEvent>(onResetState);
    on<ReloadGridJobReal2ListEvent>(onReloadGrid);
    on<GetPickedPoliciesJobReal2ListEvent>(onGetPickedPolicies);
    on<DeleteAllJobReal2ListEvent>(onDeleteAllJobReal2List);
  }

  Future<void> onGetPickedPolicies(GetPickedPoliciesJobReal2ListEvent event,
      Emitter<JobReal2GridState> emit) async {
    emit(state.copyWith(status: ListStatus.initial));
    emit(state.copyWith(
        status: ListStatus.success, items: event.pickedPolicies));
  }

  Future<void> onReloadGrid(ReloadGridJobReal2ListEvent event,
      Emitter<JobReal2GridState> emit) async {
    emit(state.copyWith(status: ListStatus.initial));

    emit(state.copyWith(status: ListStatus.success));
  }

  Future<void> onResetState(ResetStateJobReal2ListEvent event,
      Emitter<JobReal2GridState> emit) async {
    emit(state.copyWith(
        hasReachedMax: false,
        status: ListStatus.initial,
        items: <JobReal2CariModel>[]));
  }

  Future<void> onRefreshJobReal2List(
      RefreshJobReal2ListEvent event, Emitter<JobReal2GridState> emit) async {
    debugPrint("onRefreshJobReal2List");

    emit(const JobReal2GridState());

    add(FetchJobReal2ListEvent(jobreal1Id: event.jobreal1Id));
  }

  Future<void> onDeleteAllJobReal2List(
      DeleteAllJobReal2ListEvent event, Emitter<JobReal2GridState> emit) async {
    debugPrint("onDeleteAllJobReal2List");

    JobReal2CariRepository repo = JobReal2CariRepository();
    var result = await repo.jobReal2DeleteAll(event.jobreal1Id);

    List<JobReal2CariModel> items = [];

    emit(state.copyWith(
        status: result.success ? ListStatus.success : ListStatus.failure,
        items: result.success ? items : state.items));
  }

  Future<void> onFetchJobReal2List(
      FetchJobReal2ListEvent event, Emitter<JobReal2GridState> emit) async {
    debugPrint("onFetchJobReal2List");

    if (state.hasReachedMax) return;

    JobReal2CariRepository repo = JobReal2CariRepository();
    if (state.status == ListStatus.initial) {
      List<JobReal2CariModel> items =
          await repo.getJobReal2Grid(event.jobreal1Id);
      return emit(state.copyWith(
          items: items, hasReachedMax: false, status: ListStatus.success));
    }
    List<JobReal2CariModel> items =
        await repo.getJobReal2Grid(event.jobreal1Id);
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
}
