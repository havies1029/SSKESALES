import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/combobox/combomproject_model.dart';
import 'package:esalesapp/models/projectplan/plancrud_model.dart';
import 'package:esalesapp/repositories/projectplan/plancrud_repository.dart';

part 'plancrud_event.dart';
part 'plancrud_state.dart';

class PlanCrudBloc extends Bloc<PlanCrudEvents, PlanCrudState> {
	final PlanCrudRepository repository;
	PlanCrudBloc({required this.repository}) : super(const PlanCrudState()) {
		on<PlanCrudUbahEvent>(onUbahPlanCrud);
		on<PlanCrudTambahEvent>(onTambahPlanCrud);
		on<PlanCrudHapusEvent>(onHapusPlanCrud);
		on<PlanCrudLihatEvent>(onLihatPlanCrud);
		on<ComboMProjectChangedEvent>(onComboMProjectChanged);
	}

	Future<void> onTambahPlanCrud(
		PlanCrudTambahEvent event, Emitter<PlanCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.planCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahPlanCrud(
		PlanCrudUbahEvent event, Emitter<PlanCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.planCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusPlanCrud(
		PlanCrudHapusEvent event, Emitter<PlanCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.planCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatPlanCrud(
		PlanCrudLihatEvent event, Emitter<PlanCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		PlanCrudModel record = await repository.planCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onComboMProjectChanged(
			ComboMProjectChangedEvent event, Emitter<PlanCrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboMProjectModel comboMProject = event.comboMProject;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboMProject: comboMProject));
	}

}