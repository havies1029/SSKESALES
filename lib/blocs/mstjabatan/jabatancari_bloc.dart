import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/mstjabatan/jabatancari_model.dart';
import 'package:esalesapp/repositories/mstjabatan/jabatancari_repository.dart';

part 'jabatancari_event.dart';
part 'jabatancari_state.dart';

class JabatanCariBloc extends Bloc<JabatanCariEvents, JabatanCariState> {
	JabatanCariBloc() : super(const JabatanCariState()) {
		on<FetchJabatanCariEvent>(onFetchJabatanCari);
		on<RefreshJabatanCariEvent>(onRefreshJabatanCari);
		on<UbahJabatanCariEvent>(onUbahJabatanCari);
		on<TambahJabatanCariEvent>(onTambahJabatanCari);
		on<HapusJabatanCariEvent>(onHapusJabatanCari);
		on<CloseDialogJabatanCariEvent>(onCloseDialogJabatanCari);
	}

	Future<void> onRefreshJabatanCari(
			RefreshJabatanCariEvent event, Emitter<JabatanCariState> emit) async {
		emit(const JabatanCariState());

		await Future.delayed(const Duration(seconds: 1));

		add(FetchJabatanCariEvent(hal: 0, searchText: event.searchText));
	}

	Future<void> onFetchJabatanCari(
			FetchJabatanCariEvent event, Emitter<JabatanCariState> emit) async {
		if (state.hasReachedMax) return;

		JabatanCariRepository repo = JabatanCariRepository();
		if (state.status == ListStatus.initial) {
			List<JabatanCariModel> items = await repo.getJabatanCari(event.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<JabatanCariModel> items = await repo.getJabatanCari(event.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<JabatanCariModel> jabatanCari = List.of(state.items)..addAll(items);

			final result = jabatanCari
				.whereWithIndex((e, index) =>
					jabatanCari.indexWhere((e2) => e2.mjabatanId == e.mjabatanId) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusJabatanCari(
		HapusJabatanCariEvent event, Emitter<JabatanCariState> emit) async {
		return emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogJabatanCari(
		CloseDialogJabatanCariEvent event, Emitter<JabatanCariState> emit) async {
		return emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahJabatanCari(
		TambahJabatanCariEvent event, Emitter<JabatanCariState> emit) async {
		return emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahJabatanCari(
		UbahJabatanCariEvent event, Emitter<JabatanCariState> emit) async {
		return emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}