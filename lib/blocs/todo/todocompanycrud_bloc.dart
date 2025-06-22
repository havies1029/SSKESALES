import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/models/todo/todocompanycrud_model.dart';
import 'package:esalesapp/repositories/todo/todocompanycrud_repository.dart';

part 'todocompanycrud_event.dart';
part 'todocompanycrud_state.dart';

class TodoCompanyCrudBloc extends Bloc<TodoCompanyCrudEvents, TodoCompanyCrudState> {
	final TodoCompanyCrudRepository repository;
	TodoCompanyCrudBloc({required this.repository}) : super(const TodoCompanyCrudState()) {
		on<TodoCompanyCrudUbahEvent>(onUbahTodoCompanyCrud);
		on<TodoCompanyCrudTambahEvent>(onTambahTodoCompanyCrud);
		on<TodoCompanyCrudHapusEvent>(onHapusTodoCompanyCrud);
		on<TodoCompanyCrudLihatEvent>(onLihatTodoCompanyCrud);
		on<ComboCustomerChangedEvent>(onComboCustomerChanged);
	}

	Future<void> onTambahTodoCompanyCrud(
		TodoCompanyCrudTambahEvent event, Emitter<TodoCompanyCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.todoCompanyCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahTodoCompanyCrud(
		TodoCompanyCrudUbahEvent event, Emitter<TodoCompanyCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.todoCompanyCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusTodoCompanyCrud(
		TodoCompanyCrudHapusEvent event, Emitter<TodoCompanyCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.todoCompanyCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatTodoCompanyCrud(
		TodoCompanyCrudLihatEvent event, Emitter<TodoCompanyCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		TodoCompanyCrudModel record = await repository.todoCompanyCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onComboCustomerChanged(
			ComboCustomerChangedEvent event, Emitter<TodoCompanyCrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboCustomerModel comboCustomer = event.comboCustomer;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboCustomer: comboCustomer));
	}

}