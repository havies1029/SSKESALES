import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/combobox/combojobcatgroup_model.dart';
import 'package:esalesapp/models/todo/todotimelinecrud_model.dart';
import 'package:esalesapp/repositories/todo/todotimelinecrud_repository.dart';

part 'todotimelinecrud_event.dart';
part 'todotimelinecrud_state.dart';

class TodoTimelineCrudBloc extends Bloc<TodoTimelineCrudEvents, TodoTimelineCrudState> {
	final TodoTimelineCrudRepository repository;
	TodoTimelineCrudBloc({required this.repository}) : super(const TodoTimelineCrudState()) {
		on<TodoTimelineCrudUbahEvent>(onUbahTodoTimelineCrud);
		on<TodoTimelineCrudTambahEvent>(onTambahTodoTimelineCrud);
		on<TodoTimelineCrudHapusEvent>(onHapusTodoTimelineCrud);
		on<TodoTimelineCrudLihatEvent>(onLihatTodoTimelineCrud);
		on<ComboJobcatgroupChangedEvent>(onComboJobcatgroupChanged);
    on<TodoTimelineCrudResetEvent>(onResetTodoTimelineCrud);
	}

	Future<void> onTambahTodoTimelineCrud(
		TodoTimelineCrudTambahEvent event, Emitter<TodoTimelineCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.todoTimelineCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahTodoTimelineCrud(
		TodoTimelineCrudUbahEvent event, Emitter<TodoTimelineCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.todoTimelineCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, 
      hasFailure: hasFailure));
	}

	Future<void> onHapusTodoTimelineCrud(
		TodoTimelineCrudHapusEvent event, Emitter<TodoTimelineCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.todoTimelineCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatTodoTimelineCrud(
		TodoTimelineCrudLihatEvent event, Emitter<TodoTimelineCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		TodoTimelineCrudModel record = await repository.todoTimelineCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record, comboJobcatgroup: record.comboJobcatgroup));
	}

	Future<void> onComboJobcatgroupChanged(
			ComboJobcatgroupChangedEvent event, Emitter<TodoTimelineCrudState> emit) async {

		ComboJobcatgroupModel comboJobcatgroup = event.comboJobcatgroup;
		emit(state.copyWith(
			comboJobcatgroup: comboJobcatgroup));
	}

  Future<void> onResetTodoTimelineCrud(
    TodoTimelineCrudResetEvent event, Emitter<TodoTimelineCrudState> emit) async {
    emit(state.copyWith(
      isLoading: false,
      isLoaded: false,
      isSaving: false,
      isSaved: false,
      hasFailure: false,
      record: TodoTimelineCrudModel(),
      comboJobcatgroup: ComboJobcatgroupModel()));
  }

}