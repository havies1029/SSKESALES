import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/jobreal/sppacari_model.dart';
import 'package:esalesapp/repositories/jobreal/sppacari_repository.dart';

part 'sppa4timelinecari_event.dart';
part 'sppa4timelinecari_state.dart';

class Sppa4TimelineCariBloc extends Bloc<SppaCariEvents, SppaCariState> {
  Sppa4TimelineCariBloc() : super(const SppaCariState()) {
    on<FetchSppaCariEvent>(onFetchSppaCari);
    on<RefreshSppaCariEvent>(onRefreshSppaCari);
  }

  Future<void> onRefreshSppaCari(
      RefreshSppaCariEvent event, Emitter<SppaCariState> emit) async {
    emit(const SppaCariState());

    emit(state.copyWith(
        jobRealId: event.jobRealId, searchText: event.searchText, hal: 0));

    add(const FetchSppaCariEvent());
  }

  Future<void> onFetchSppaCari(
      FetchSppaCariEvent event, Emitter<SppaCariState> emit) async {
    debugPrint("onFetchSppaCari #10");

    if (state.hasReachedMax) return;

    SppaCariRepository repo = SppaCariRepository();
    if (state.status == ListStatus.initial) {
      List<SppaCariModel> items =
          await repo.getSppaCari(state.jobRealId, state.searchText, state.hal);
      return emit(state.copyWith(
          items: items,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: 1));
    }
    List<SppaCariModel> items =
        await repo.getSppaCari(state.jobRealId, state.searchText, state.hal);
    if (items.isEmpty) {
      return emit(state.copyWith(hasReachedMax: true));
    } else {
      List<SppaCariModel> sppaCari = List.of(state.items)..addAll(items);

      final result = sppaCari
          .whereWithIndex((e, index) =>
              sppaCari.indexWhere((e2) => e2.sppaNo == e.sppaNo) == index)
          .toList();

      return emit(state.copyWith(
          items: result,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: state.hal + 1));
    }
  }
}
