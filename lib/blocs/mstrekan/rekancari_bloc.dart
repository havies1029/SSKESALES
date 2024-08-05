import 'package:equatable/equatable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/mstrekan/rekancari_model.dart';
import 'package:esalesapp/repositories/mstrekan/rekancari_repository.dart';

part 'rekancari_event.dart';
part 'rekancari_state.dart';

class RekanCariBloc extends Bloc<RekanCariEvents, RekanCariState> {
  RekanCariBloc() : super(const RekanCariState()) {
    on<FetchRekanCariEvent>(onFetchRekanCari);
    on<RefreshRekanCariEvent>(onRefreshRekanCari);
    on<UbahRekanCariEvent>(onUbahRekanCari);
    on<TambahRekanCariEvent>(onTambahRekanCari);
    on<HapusRekanCariEvent>(onHapusRekanCari);
    on<CloseDialogRekanCariEvent>(onCloseDialogRekanCari);
    //on<SetFilterRekanCariEvent>(onSetFilterRekanCari);
  }

  Future<void> onRefreshRekanCari(
      RefreshRekanCariEvent event, Emitter<RekanCariState> emit) async {
    emit(const RekanCariState());

    await Future.delayed(const Duration(seconds: 1));

    add(FetchRekanCariEvent(
        rekanTypeId: event.rekanTypeId, hal: 0, searchText: event.searchText, filterBy: event.filterBy));
  }

  Future<void> onFetchRekanCari(
      FetchRekanCariEvent event, Emitter<RekanCariState> emit) async {
    if (state.hasReachedMax) return;

    debugPrint("onFetchRekanCari");

    debugPrint("state.filterBy : ${event.filterBy}");

    RekanCariRepository repo = RekanCariRepository();
    if (state.status == ListStatus.initial) {
      List<RekanCariModel> items = await repo.getRekanCari(
          event.rekanTypeId, event.searchText, (event.filterBy != "all"), 0);
      //List<RekanCariModel> filteredItems = filterItemsBy(items, state.filterBy);
      return emit(state.copyWith(
          items: items,
          filterBy: event.filterBy,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: 1,
          rekanTypeId: event.rekanTypeId));
    }
    List<RekanCariModel> items = await repo.getRekanCari(event.rekanTypeId,
        event.searchText, (event.filterBy != "all"), state.hal);
    if (items.isEmpty) {
      return emit(state.copyWith(hasReachedMax: true));
    } else {
      List<RekanCariModel> rekanCari = List.of(state.items)..addAll(items);

      final result = rekanCari
          .whereWithIndex((e, index) =>
              rekanCari.indexWhere((e2) => e2.mrekanId == e.mrekanId) == index)
          .toList();

      return emit(state.copyWith(
          items: result,
          filterBy: event.filterBy,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: state.hal + 1,
          rekanTypeId: event.rekanTypeId));
    }
  }

  Future<void> onHapusRekanCari(
      HapusRekanCariEvent event, Emitter<RekanCariState> emit) async {
    return emit(state.copyWith(viewMode: "hapus"));
  }

  Future<void> onCloseDialogRekanCari(
      CloseDialogRekanCariEvent event, Emitter<RekanCariState> emit) async {
    return emit(state.copyWith(viewMode: ""));
  }

  Future<void> onTambahRekanCari(
      TambahRekanCariEvent event, Emitter<RekanCariState> emit) async {
    return emit(state.copyWith(viewMode: "tambah"));
  }

  Future<void> onUbahRekanCari(
      UbahRekanCariEvent event, Emitter<RekanCariState> emit) async {
    return emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
  }

  /*
  Future<void> onSetFilterRekanCari(
      SetFilterRekanCariEvent event, Emitter<RekanCariState> emit) async {
    debugPrint("onSetFilterRekanCari event.filterBy : ${event.filterBy}");

    
    debugPrint("state.filterBy #10 : ${state.filterBy}");

    emit(state.copyWith(filterBy: event.filterBy));

    debugPrint("state.filterBy #20 : ${state.filterBy}");

    add(RefreshRekanCariEvent(
        rekanTypeId: state.rekanTypeId, hal: 0, searchText: ""));
    
    debugPrint("state.filterBy #30 : ${state.filterBy}");
  }
  */

  /*
  List<RekanCariModel> filterItemsBy(
      List<RekanCariModel> list, String filterCriteria) {
    List<RekanCariModel> filteredList = list;

    if (filterCriteria != "all") {
      filteredList =
          list.where((x) => x.marketingNama == AppData.personName).toList();
    }

    return filteredList;
  }
  */
}
