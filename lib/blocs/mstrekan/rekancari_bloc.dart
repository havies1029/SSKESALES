import 'package:equatable/equatable.dart';
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
	}

	Future<void> onRefreshRekanCari(
			RefreshRekanCariEvent event, Emitter<RekanCariState> emit) async {
		emit(const RekanCariState());

		await Future.delayed(const Duration(seconds: 1));

		add(FetchRekanCariEvent(rekanTypeId: event.rekanTypeId, hal: 0, searchText: event.searchText));
	}

	Future<void> onFetchRekanCari(
			FetchRekanCariEvent event, Emitter<RekanCariState> emit) async {
		if (state.hasReachedMax) return;

		RekanCariRepository repo = RekanCariRepository();
		if (state.status == ListStatus.initial) {
			List<RekanCariModel> items = await repo.getRekanCari(event.rekanTypeId, event.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<RekanCariModel> items = await repo.getRekanCari(event.rekanTypeId, event.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<RekanCariModel> rekanCari = List.of(state.items)..addAll(items);

			final result = rekanCari
				.whereWithIndex((e, index) =>
					rekanCari.indexWhere((e2) => e2.mrekanId == e.mrekanId) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
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

}