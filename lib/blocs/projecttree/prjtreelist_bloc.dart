import 'package:equatable/equatable.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/projecttree/prjtreelist_model.dart';
import 'package:esalesapp/repositories/projecttree/prjtreelist_repository.dart';

part 'prjtreelist_event.dart';
part 'prjtreelist_state.dart';

class PrjtreeListBloc extends Bloc<PrjtreeListEvents, PrjtreeListState> {
	PrjtreeListBloc() : super(const PrjtreeListState()) {
		on<FetchPrjtreeListEvent>(onFetchPrjtreeList);
		on<RefreshPrjtreeListEvent>(onRefreshPrjtreeList);
		on<UbahPrjtreeListEvent>(onUbahPrjtreeList);
		on<TambahPrjtreeListEvent>(onTambahPrjtreeList);
		on<HapusPrjtreeListEvent>(onHapusPrjtreeList);
		on<CloseDialogPrjtreeListEvent>(onCloseDialogPrjtreeList);
    on<StartPrjTreeListEvent>(onStartProject);
	}

	Future<void> onRefreshPrjtreeList(
			RefreshPrjtreeListEvent event, Emitter<PrjtreeListState> emit) async {
		emit(const PrjtreeListState());

		emit(state.copyWith(searchText: event.searchText));
		add(FetchPrjtreeListEvent());
	}

	Future<void> onFetchPrjtreeList(
			FetchPrjtreeListEvent event, Emitter<PrjtreeListState> emit) async {
		if (state.hasReachedMax) return;

		PrjtreeListRepository repo = PrjtreeListRepository();
		if (state.status == ListStatus.initial) {
			List<PrjtreeListModel> items = await repo.getPrjtreeList(state.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<PrjtreeListModel> items = await repo.getPrjtreeList(state.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<PrjtreeListModel> prjtreeList = List.of(state.items)..addAll(items);

			final result = prjtreeList
				.whereWithIndex((e, index) =>
					prjtreeList.indexWhere((e2) => e2.prjtree1Id == e.prjtree1Id) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusPrjtreeList(
		HapusPrjtreeListEvent event, Emitter<PrjtreeListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogPrjtreeList(
		CloseDialogPrjtreeListEvent event, Emitter<PrjtreeListState> emit) async {
		emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahPrjtreeList(
		TambahPrjtreeListEvent event, Emitter<PrjtreeListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahPrjtreeList(
		UbahPrjtreeListEvent event, Emitter<PrjtreeListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

  Future<void> onStartProject(
      StartPrjTreeListEvent event, Emitter<PrjtreeListState> emit) async {
    //debugPrint("onStartProject");
    emit(state.copyWith(started: false, hasFailure: false));

    PrjtreeListRepository repository = PrjtreeListRepository();
    ReturnDataAPI returnData = await repository.projectStart(event.projectId);
    bool started = returnData.success;

    emit(state.copyWith(started: started, hasFailure: !started, errorMsg: returnData.data));

    //debugPrint("onStartProject -> started : $started");
    //debugPrint("onStartProject -> state.started : ${state.started}");
  }

}