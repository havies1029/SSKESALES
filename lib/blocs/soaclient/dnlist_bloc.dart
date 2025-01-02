import 'package:equatable/equatable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/soaclient/dnlist_model.dart';
import 'package:esalesapp/repositories/soaclient/dnlist_repository.dart';

part 'dnlist_event.dart';
part 'dnlist_state.dart';

class DnlistBloc extends Bloc<DnlistEvents, DnlistState> {
  DnlistBloc() : super(const DnlistState()) {
    on<FetchDnlistEvent>(onFetchDnlist);
    on<RefreshDnlistEvent>(onRefreshDnlist);
    on<SetSelectedDNEvent>(onSetSelectedDNEvent);
  }

  Future<void> onRefreshDnlist(
      RefreshDnlistEvent event, Emitter<DnlistState> emit) async {
    emit(const DnlistState());

    emit(state.copyWith(
        soaAgingId: event.soaAgingId, searchText: event.searchText));

    add(FetchDnlistEvent());
  }

  Future<void> onFetchDnlist(
      FetchDnlistEvent event, Emitter<DnlistState> emit) async {
    emit(state.copyWith(status: ListStatus.initial));

    if (state.hasReachedMax) return;

    DnlistRepository repo = DnlistRepository();
    if (state.status == ListStatus.initial) {
      List<DnlistModel> items =
          await repo.getDnlist(state.soaAgingId, state.searchText, 0);
      return emit(state.copyWith(
          items: items,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: 1));
    }
    List<DnlistModel> items =
        await repo.getDnlist(state.soaAgingId, state.searchText, state.hal);
    if (items.isEmpty) {
      return emit(state.copyWith(hasReachedMax: true));
    } else {
      List<DnlistModel> dnlist = List.of(state.items)..addAll(items);

      final result = dnlist
          .whereWithIndex((e, index) =>
              dnlist.indexWhere((e2) => e2.dn1Id == e.dn1Id) == index)
          .toList();

      return emit(state.copyWith(
          items: result,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: state.hal + 1));
    }
  }

  Future<void> onSetSelectedDNEvent(
      SetSelectedDNEvent event, Emitter<DnlistState> emit) async {
    emit(state.copyWith(selectedDNId: event.selectedDNId));
  }
}
