import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/combobox/combojobcat_model.dart';
import 'package:esalesapp/models/mstjob/jobcrud_model.dart';
import 'package:esalesapp/repositories/mstjob/jobcrud_repository.dart';

part 'jobcrud_event.dart';
part 'jobcrud_state.dart';

class JobCrudBloc extends Bloc<JobCrudEvents, JobCrudState> {
	final JobCrudRepository repository;
	JobCrudBloc({required this.repository}) : super(const JobCrudState()) {
		on<JobCrudUbahEvent>(onUbahJobCrud);
		on<JobCrudTambahEvent>(onTambahJobCrud);
		on<JobCrudHapusEvent>(onHapusJobCrud);
		on<JobCrudLihatEvent>(onLihatJobCrud);
		on<ComboJobcatChangedEvent>(onComboJobcatChanged);
	}

	Future<void> onTambahJobCrud(
		JobCrudTambahEvent event, Emitter<JobCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.jobCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahJobCrud(
		JobCrudUbahEvent event, Emitter<JobCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.jobCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusJobCrud(
		JobCrudHapusEvent event, Emitter<JobCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.jobCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatJobCrud(
		JobCrudLihatEvent event, Emitter<JobCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		JobCrudModel record = await repository.jobCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onComboJobcatChanged(
			ComboJobcatChangedEvent event, Emitter<JobCrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboJobcatModel comboJobcat = event.comboJobcat;
		JobCrudModel rec = state.record!;
		rec.mjobcatId = comboJobcat.mjobcatId;
		rec.comboJobcat = comboJobcat;

		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			record: rec));
	}

}