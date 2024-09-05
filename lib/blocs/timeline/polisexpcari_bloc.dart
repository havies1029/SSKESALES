import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/timeline/polisexpcari_model.dart';
import 'package:esalesapp/repositories/timeline/polisexpcari_repository.dart';

import '../../common/constants.dart';

part 'polisexpcari_event.dart';
part 'polisexpcari_state.dart';

class PolisExpCariBloc extends Bloc<PolisExpCariEvents, PolisExpCariState> {
  PolisExpCariBloc() : super(const PolisExpCariState()) {
    on<FetchPolisExpCariEvent>(onFetchPolisExpCari);
    on<RefreshPolisExpCariEvent>(onRefreshPolisExpCari);
  }

  Future<void> onRefreshPolisExpCari(
      RefreshPolisExpCariEvent event, Emitter<PolisExpCariState> emit) async {
    debugPrint("onRefreshPolisExpCari");
    emit(const PolisExpCariState());

    //await Future.delayed(const Duration(seconds: 1));

    add(FetchPolisExpCariEvent(
        expgroupId: event.expgroupId,
        personalId: event.personalId,        
        searchText: event.searchText));
  }

  Future<void> onFetchPolisExpCari(
      FetchPolisExpCariEvent event, Emitter<PolisExpCariState> emit) async {
    debugPrint("onFetchPolisExpCari");
    if (state.hasReachedMax) return;

    PolisExpCariRepository repo = PolisExpCariRepository();
    if (state.status == ListStatus.initial) {
      debugPrint("onFetchPolisExpCari -> ListStatus.initial");
      List<PolisExpCariModel> items = await repo.getPolisExpCari(
          event.searchText, 0, event.expgroupId, event.personalId);
      return emit(state.copyWith(
        items: items,
        hasReachedMax: false,
        hal: 1,
        status: ListStatus.success,
      ));
    }
    List<PolisExpCariModel> items = await repo.getPolisExpCari(
        event.searchText, state.hal, event.expgroupId, event.personalId);

    if (items.isEmpty) {
      debugPrint("onFetchPolisExpCari -> items.isEmpty");
      return emit(state.copyWith(hasReachedMax: true));
    } else {
      List<PolisExpCariModel> polisExpCari = List.of(state.items)
        ..addAll(items);

      debugPrint("onFetchPolisExpCari -> add : ${items.length} items");

/*
      var elements = polisExpCari.map((e) => e.toJson()).toList();
      debugPrint("elements #1 count : ${elements.length} items");
      debugPrint(elements.toString());
      elements = ListHelper.filterListByKey(elements, "polis1Id");
      debugPrint("elements #2 count : ${elements.length} items");

      final result = elements
          .map<PolisExpCariModel>((json) => PolisExpCariModel.fromJson(json))
          .toList();
*/
      
      final result = polisExpCari
          .whereWithIndex((e, index) =>
              polisExpCari.indexWhere((e2) => e2.polis1Id == e.polis1Id) ==
              index)
          .toList();
      

      debugPrint("onFetchPolisExpCari -> total : ${result.length} items");

      return emit(state.copyWith(
        items: result,
        hasReachedMax: false,
        hal: state.hal + 1,
        status: ListStatus.success,
      ));
    }
  }
}
