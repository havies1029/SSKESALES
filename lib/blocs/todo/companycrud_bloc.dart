import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/models/todo/companycrud_model.dart';
import 'package:esalesapp/repositories/todo/companycrud_repository.dart';

part 'companycrud_event.dart';
part 'companycrud_state.dart';

class CompanyCrudBloc extends Bloc<CompanyCrudEvents, CompanyCrudState> {
	final CompanyCrudRepository repository;
	CompanyCrudBloc({required this.repository}) : super(const CompanyCrudState()) {
		on<CompanyCrudUbahEvent>(onUbahCompanyCrud);
		on<CompanyCrudTambahEvent>(onTambahCompanyCrud);
		on<CompanyCrudHapusEvent>(onHapusCompanyCrud);
		on<CompanyCrudLihatEvent>(onLihatCompanyCrud);
		on<ComboCustomerChangedEvent>(onComboCustomerChanged);
	}

	Future<void> onTambahCompanyCrud(
		CompanyCrudTambahEvent event, Emitter<CompanyCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.companyCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahCompanyCrud(
		CompanyCrudUbahEvent event, Emitter<CompanyCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.companyCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusCompanyCrud(
		CompanyCrudHapusEvent event, Emitter<CompanyCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.companyCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatCompanyCrud(
		CompanyCrudLihatEvent event, Emitter<CompanyCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		CompanyCrudModel record = await repository.companyCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onComboCustomerChanged(
			ComboCustomerChangedEvent event, Emitter<CompanyCrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboCustomerModel comboCustomer = event.comboCustomer;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboCustomer: comboCustomer));
	}

}