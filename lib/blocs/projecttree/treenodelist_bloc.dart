import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/projecttree/treenodelist_model.dart';
import 'package:esalesapp/repositories/projecttree/treenodelist_repository.dart';

part 'treenodelist_event.dart';
part 'treenodelist_state.dart';

class TreenodeListBloc extends Bloc<TreenodeListEvents, TreenodeListState> {
	TreenodeListBloc() : super(const TreenodeListState()) {
		on<FetchTreenodeListEvent>(onFetchTreenodeList);
		on<RefreshTreenodeListEvent>(onRefreshTreenodeList);
		on<UbahTreenodeListEvent>(onUbahTreenodeList);
		on<TambahTreenodeListEvent>(onTambahTreenodeList);
		on<HapusTreenodeListEvent>(onHapusTreenodeList);
		on<CloseDialogTreenodeListEvent>(onCloseDialogTreenodeList);
	}

	Future<void> onRefreshTreenodeList(
			RefreshTreenodeListEvent event, Emitter<TreenodeListState> emit) async {
		emit(const TreenodeListState());

		emit(state.copyWith(prjtree1Id: event.prjtree1Id));
		add(FetchTreenodeListEvent());
	}

	Future<void> onFetchTreenodeList(
			FetchTreenodeListEvent event, Emitter<TreenodeListState> emit) async {
		if (state.hasReachedMax) return;

		TreenodeListRepository repo = TreenodeListRepository();
		if (state.status == ListStatus.initial) {
			List<TreenodeListModel> items = await repo.getTreenodeList(state.prjtree1Id, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<TreenodeListModel> items = await repo.getTreenodeList(state.prjtree1Id, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<TreenodeListModel> treenodeList = List.of(state.items)..addAll(items);

			final result = treenodeList
				.whereWithIndex((e, index) =>
					treenodeList.indexWhere((e2) => e2.prjtree2Id == e.prjtree2Id) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusTreenodeList(
		HapusTreenodeListEvent event, Emitter<TreenodeListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogTreenodeList(
		CloseDialogTreenodeListEvent event, Emitter<TreenodeListState> emit) async {
		emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahTreenodeList(
		TambahTreenodeListEvent event, Emitter<TreenodeListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahTreenodeList(
		UbahTreenodeListEvent event, Emitter<TreenodeListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}