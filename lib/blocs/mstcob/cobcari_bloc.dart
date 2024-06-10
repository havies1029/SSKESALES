import 'package:equatable/equatable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/mstcob/cobcari_model.dart';
import 'package:esalesapp/repositories/mstcob/cobcari_repository.dart';

part 'cobcari_event.dart';
part 'cobcari_state.dart';

class CobCariBloc extends Bloc<CobCariEvents, CobCariState> {
	CobCariBloc() : super(const CobCariState()) {
		on<FetchCobCariEvent>(onFetchCobCari);
		on<RefreshCobCariEvent>(onRefreshCobCari);
		on<UbahCobCariEvent>(onUbahCobCari);
		on<TambahCobCariEvent>(onTambahCobCari);
		on<HapusCobCariEvent>(onHapusCobCari);
		on<CloseDialogCobCariEvent>(onCloseDialogCobCari);
	}

	Future<void> onRefreshCobCari(
			RefreshCobCariEvent event, Emitter<CobCariState> emit) async {
		emit(const CobCariState());

		await Future.delayed(const Duration(seconds: 1));

		add(FetchCobCariEvent(hal: 0, searchText: event.searchText));
	}

	Future<void> onFetchCobCari(
			FetchCobCariEvent event, Emitter<CobCariState> emit) async {
		if (state.hasReachedMax) return;

		CobCariRepository repo = CobCariRepository();
		if (state.status == ListStatus.initial) {
			List<CobCariModel> items = await repo.getCobCari(event.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<CobCariModel> items = await repo.getCobCari(event.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<CobCariModel> cobCari = List.of(state.items)..addAll(items);

			final result = cobCari
				.whereWithIndex((e, index) =>
					cobCari.indexWhere((e2) => e2.mcobId == e.mcobId) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusCobCari(
		HapusCobCariEvent event, Emitter<CobCariState> emit) async {
		return emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogCobCari(
		CloseDialogCobCariEvent event, Emitter<CobCariState> emit) async {
		return emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahCobCari(
		TambahCobCariEvent event, Emitter<CobCariState> emit) async {
		return emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahCobCari(
		UbahCobCariEvent event, Emitter<CobCariState> emit) async {
		return emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}