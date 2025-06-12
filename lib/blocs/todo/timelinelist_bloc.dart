import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/todo/timelinelist_model.dart';
import 'package:esalesapp/repositories/todo/timelinelist_repository.dart';

part 'timelinelist_event.dart';
part 'timelinelist_state.dart';

class TimelineListBloc extends Bloc<TimelineListEvents, TimelineListState> {
	TimelineListBloc() : super(const TimelineListState()) {
		on<FetchTimelineListEvent>(onFetchTimelineList);
		on<RefreshTimelineListEvent>(onRefreshTimelineList);
		on<UbahTimelineListEvent>(onUbahTimelineList);
		on<TambahTimelineListEvent>(onTambahTimelineList);
		on<HapusTimelineListEvent>(onHapusTimelineList);
		on<CloseDialogTimelineListEvent>(onCloseDialogTimelineList);
	}

	Future<void> onRefreshTimelineList(
			RefreshTimelineListEvent event, Emitter<TimelineListState> emit) async {
		emit(const TimelineListState());

		emit(state.copyWith(searchText: event.searchText));
		add(FetchTimelineListEvent());
	}

	Future<void> onFetchTimelineList(
			FetchTimelineListEvent event, Emitter<TimelineListState> emit) async {
		if (state.hasReachedMax) return;

		TimelineListRepository repo = TimelineListRepository();
		if (state.status == ListStatus.initial) {
			List<TimelineListModel> items = await repo.getTimelineList(state.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<TimelineListModel> items = await repo.getTimelineList(state.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<TimelineListModel> timelineList = List.of(state.items)..addAll(items);

			final result = timelineList
				.whereWithIndex((e, index) =>
					timelineList.indexWhere((e2) => e2.timeline1Id == e.timeline1Id) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusTimelineList(
		HapusTimelineListEvent event, Emitter<TimelineListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogTimelineList(
		CloseDialogTimelineListEvent event, Emitter<TimelineListState> emit) async {
		emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahTimelineList(
		TambahTimelineListEvent event, Emitter<TimelineListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahTimelineList(
		UbahTimelineListEvent event, Emitter<TimelineListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}