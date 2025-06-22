import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/todo/todocompanylist_model.dart';
import 'package:esalesapp/repositories/todo/todocompanylist_repository.dart';

part 'todocompanylist_event.dart';
part 'todocompanylist_state.dart';

class TodoCompanyListBloc extends Bloc<TodoCompanyListEvents, TodoCompanyListState> {
	TodoCompanyListBloc() : super(const TodoCompanyListState()) {
		on<FetchTodoCompanyListEvent>(onFetchTodoCompanyList);
		on<RefreshTodoCompanyListEvent>(onRefreshTodoCompanyList);
		on<UbahTodoCompanyListEvent>(onUbahTodoCompanyList);
		on<TambahTodoCompanyListEvent>(onTambahTodoCompanyList);
		on<HapusTodoCompanyListEvent>(onHapusTodoCompanyList);
		on<CloseDialogTodoCompanyListEvent>(onCloseDialogTodoCompanyList);
	}

	Future<void> onRefreshTodoCompanyList(
			RefreshTodoCompanyListEvent event, Emitter<TodoCompanyListState> emit) async {
		emit(const TodoCompanyListState());

		emit(state.copyWith(timeline1Id: event.timeline1Id));
		add(FetchTodoCompanyListEvent());
	}

	Future<void> onFetchTodoCompanyList(
			FetchTodoCompanyListEvent event, Emitter<TodoCompanyListState> emit) async {
		if (state.hasReachedMax) return;

		TodoCompanyListRepository repo = TodoCompanyListRepository();
		if (state.status == ListStatus.initial) {
			List<TodoCompanyListModel> items = await repo.getTodoCompanyList(state.timeline1Id, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<TodoCompanyListModel> items = await repo.getTodoCompanyList(state.timeline1Id, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<TodoCompanyListModel> todoCompanyList = List.of(state.items)..addAll(items);

			final result = todoCompanyList
				.whereWithIndex((e, index) =>
					todoCompanyList.indexWhere((e2) => e2.timeline2Id == e.timeline2Id) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusTodoCompanyList(
		HapusTodoCompanyListEvent event, Emitter<TodoCompanyListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogTodoCompanyList(
		CloseDialogTodoCompanyListEvent event, Emitter<TodoCompanyListState> emit) async {
		emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahTodoCompanyList(
		TambahTodoCompanyListEvent event, Emitter<TodoCompanyListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahTodoCompanyList(
		UbahTodoCompanyListEvent event, Emitter<TodoCompanyListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}