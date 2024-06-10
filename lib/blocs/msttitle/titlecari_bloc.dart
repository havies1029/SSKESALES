import 'package:equatable/equatable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/msttitle/titlecari_model.dart';
import 'package:esalesapp/repositories/msttitle/titlecari_repository.dart';

part 'titlecari_event.dart';
part 'titlecari_state.dart';

class TitleCariBloc extends Bloc<TitleCariEvents, TitleCariState> {
	TitleCariBloc() : super(const TitleCariState()) {
		on<FetchTitleCariEvent>(onFetchTitleCari);
		on<RefreshTitleCariEvent>(onRefreshTitleCari);
		on<UbahTitleCariEvent>(onUbahTitleCari);
		on<TambahTitleCariEvent>(onTambahTitleCari);
		on<HapusTitleCariEvent>(onHapusTitleCari);
		on<CloseDialogTitleCariEvent>(onCloseDialogTitleCari);
	}

	Future<void> onRefreshTitleCari(
			RefreshTitleCariEvent event, Emitter<TitleCariState> emit) async {
		emit(const TitleCariState());

		await Future.delayed(const Duration(seconds: 1));

		add(FetchTitleCariEvent(hal: 0, searchText: event.searchText));
	}

	Future<void> onFetchTitleCari(
			FetchTitleCariEvent event, Emitter<TitleCariState> emit) async {
		if (state.hasReachedMax) return;

		TitleCariRepository repo = TitleCariRepository();
		if (state.status == ListStatus.initial) {
			List<TitleCariModel> items = await repo.getTitleCari(event.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<TitleCariModel> items = await repo.getTitleCari(event.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<TitleCariModel> titleCari = List.of(state.items)..addAll(items);

			final result = titleCari
				.whereWithIndex((e, index) =>
					titleCari.indexWhere((e2) => e2.mtitleId == e.mtitleId) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusTitleCari(
		HapusTitleCariEvent event, Emitter<TitleCariState> emit) async {
		return emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogTitleCari(
		CloseDialogTitleCariEvent event, Emitter<TitleCariState> emit) async {
		return emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahTitleCari(
		TambahTitleCariEvent event, Emitter<TitleCariState> emit) async {
		return emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahTitleCari(
		UbahTitleCariEvent event, Emitter<TitleCariState> emit) async {
		return emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}