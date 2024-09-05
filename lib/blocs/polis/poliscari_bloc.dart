import 'package:equatable/equatable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/polis/poliscari_model.dart';
import 'package:esalesapp/repositories/polis/poliscari_repository.dart';

part 'poliscari_event.dart';
part 'poliscari_state.dart';

class PolisCariBloc extends Bloc<PolisCariEvents, PolisCariState> {
	PolisCariBloc() : super(const PolisCariState()) {
		on<FetchPolisCariEvent>(onFetchPolisCari);
		on<RefreshPolisCariEvent>(onRefreshPolisCari);
		on<UbahPolisCariEvent>(onUbahPolisCari);
		on<TambahPolisCariEvent>(onTambahPolisCari);
		on<HapusPolisCariEvent>(onHapusPolisCari);
		on<CloseDialogPolisCariEvent>(onCloseDialogPolisCari);
	}

	Future<void> onRefreshPolisCari(
			RefreshPolisCariEvent event, Emitter<PolisCariState> emit) async {
		emit(const PolisCariState());

		//await Future.delayed(const Duration(seconds: 1));

		add(FetchPolisCariEvent(hal: 0, searchText: event.searchText));
	}

	Future<void> onFetchPolisCari(
			FetchPolisCariEvent event, Emitter<PolisCariState> emit) async {
		if (state.hasReachedMax) return;

		PolisCariRepository repo = PolisCariRepository();
		if (state.status == ListStatus.initial) {
			List<PolisCariModel> items = await repo.getPolisCari(event.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<PolisCariModel> items = await repo.getPolisCari(event.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<PolisCariModel> polisCari = List.of(state.items)..addAll(items);

			final result = polisCari
				.whereWithIndex((e, index) =>
					polisCari.indexWhere((e2) => e2.polis1Id == e.polis1Id) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusPolisCari(
		HapusPolisCariEvent event, Emitter<PolisCariState> emit) async {
		return emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogPolisCari(
		CloseDialogPolisCariEvent event, Emitter<PolisCariState> emit) async {
		return emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahPolisCari(
		TambahPolisCariEvent event, Emitter<PolisCariState> emit) async {
		return emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahPolisCari(
		UbahPolisCariEvent event, Emitter<PolisCariState> emit) async {
		return emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}