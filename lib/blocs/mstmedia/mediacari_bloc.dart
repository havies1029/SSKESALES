import 'package:equatable/equatable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/mstmedia/mediacari_model.dart';
import 'package:esalesapp/repositories/mstmedia/mediacari_repository.dart';

part 'mediacari_event.dart';
part 'mediacari_state.dart';

class MediaCariBloc extends Bloc<MediaCariEvents, MediaCariState> {
	MediaCariBloc() : super(const MediaCariState()) {
		on<FetchMediaCariEvent>(onFetchMediaCari);
		on<RefreshMediaCariEvent>(onRefreshMediaCari);
		on<UbahMediaCariEvent>(onUbahMediaCari);
		on<TambahMediaCariEvent>(onTambahMediaCari);
		on<HapusMediaCariEvent>(onHapusMediaCari);
		on<CloseDialogMediaCariEvent>(onCloseDialogMediaCari);
	}

	Future<void> onRefreshMediaCari(
			RefreshMediaCariEvent event, Emitter<MediaCariState> emit) async {
		emit(const MediaCariState());

		await Future.delayed(const Duration(seconds: 1));

		add(FetchMediaCariEvent(hal: 0, searchText: event.searchText));
	}

	Future<void> onFetchMediaCari(
			FetchMediaCariEvent event, Emitter<MediaCariState> emit) async {
		if (state.hasReachedMax) return;

		MediaCariRepository repo = MediaCariRepository();
		if (state.status == ListStatus.initial) {
			List<MediaCariModel> items = await repo.getMediaCari(event.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<MediaCariModel> items = await repo.getMediaCari(event.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<MediaCariModel> mediaCari = List.of(state.items)..addAll(items);

			final result = mediaCari
				.whereWithIndex((e, index) =>
					mediaCari.indexWhere((e2) => e2.mmediaId == e.mmediaId) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusMediaCari(
		HapusMediaCariEvent event, Emitter<MediaCariState> emit) async {
		return emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogMediaCari(
		CloseDialogMediaCariEvent event, Emitter<MediaCariState> emit) async {
		return emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahMediaCari(
		TambahMediaCariEvent event, Emitter<MediaCariState> emit) async {
		return emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahMediaCari(
		UbahMediaCariEvent event, Emitter<MediaCariState> emit) async {
		return emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}