import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/todo/todotimelinelist_model.dart';
import 'package:esalesapp/repositories/todo/todotimelinelist_repository.dart';
import 'package:infinite_calendar_view/infinite_calendar_view.dart';

part 'todotimelinelist_event.dart';
part 'todotimelinelist_state.dart';

class TodoTimelineListBloc extends Bloc<TodoTimelineListEvents, TodoTimelineListState> {
	TodoTimelineListBloc() : super(TodoTimelineListState(tgl1: DateTime.now(), calendarView: "day")) {
		on<FetchTodoTimelineListEvent>(onFetchTodoTimelineList);
		on<RefreshTodoTimelineListEvent>(onRefreshTodoTimelineList);
		on<UbahTodoTimelineListEvent>(onUbahTodoTimelineList);
		on<TambahTodoTimelineListEvent>(onTambahTodoTimelineList);
		on<HapusTodoTimelineListEvent>(onHapusTodoTimelineList);
		on<CloseDialogTodoTimelineListEvent>(onCloseDialogTodoTimelineList);
	}

	Future<void> onRefreshTodoTimelineList(
			RefreshTodoTimelineListEvent event, Emitter<TodoTimelineListState> emit) async {
		emit(TodoTimelineListState(tgl1: DateTime.now(), calendarView: "day"));

		emit(state.copyWith(tgl1: event.tgl1, calendarView: event.calendarView));
		add(FetchTodoTimelineListEvent());
	}

	Future<void> onFetchTodoTimelineList(
			FetchTodoTimelineListEvent event, Emitter<TodoTimelineListState> emit) async {
		if (state.hasReachedMax) return;

		TodoTimelineListRepository repo = TodoTimelineListRepository();
		if (state.status == ListStatus.initial) {
			List<Event> items = await repo.getTodoList(state.tgl1, state.calendarView);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: true,
				status: ListStatus.success,
				));
		}
    /*
		List<Event> items = await repo.getTodoList(state.tgl1, state.calendarView);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<Event> todoTimelineList = List.of(state.items)..addAll(items);

			final result = todoTimelineList
				.whereWithIndex((e, index) =>
					todoTimelineList.indexWhere((e2) => e2.data == e.data) ==
					index)
				.toList();

      return emit(state.copyWith(
        items: result,
        hasReachedMax: false,
        status: ListStatus.success
      ));
		}
    */
	}

	Future<void> onHapusTodoTimelineList(
		HapusTodoTimelineListEvent event, Emitter<TodoTimelineListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogTodoTimelineList(
		CloseDialogTodoTimelineListEvent event, Emitter<TodoTimelineListState> emit) async {
		emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahTodoTimelineList(
		TambahTodoTimelineListEvent event, Emitter<TodoTimelineListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahTodoTimelineList(
		UbahTodoTimelineListEvent event, Emitter<TodoTimelineListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}