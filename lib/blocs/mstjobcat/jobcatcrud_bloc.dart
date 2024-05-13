import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/mstjobcat/jobcatcrud_model.dart';
import 'package:esalesapp/repositories/mstjobcat/jobcatcrud_repository.dart';

part 'jobcatcrud_event.dart';
part 'jobcatcrud_state.dart';

class JobCatCrudBloc extends Bloc<JobCatCrudEvents, JobCatCrudState> {
	final JobCatCrudRepository repository;
	JobCatCrudBloc({required this.repository}) : super(const JobCatCrudState()) {
		on<JobCatCrudUbahEvent>(onUbahJobCatCrud);
		on<JobCatCrudTambahEvent>(onTambahJobCatCrud);
		on<JobCatCrudHapusEvent>(onHapusJobCatCrud);
		on<JobCatCrudLihatEvent>(onLihatJobCatCrud);
	}

	Future<void> onTambahJobCatCrud(
		JobCatCrudTambahEvent event, Emitter<JobCatCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.jobCatCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahJobCatCrud(
		JobCatCrudUbahEvent event, Emitter<JobCatCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.jobCatCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusJobCatCrud(
		JobCatCrudHapusEvent event, Emitter<JobCatCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.jobCatCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatJobCatCrud(
		JobCatCrudLihatEvent event, Emitter<JobCatCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		JobCatCrudModel record = await repository.jobCatCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}