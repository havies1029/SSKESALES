import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/mstjobgroup/jobgroupcrud_model.dart';
import 'package:esalesapp/repositories/mstjobgroup/jobgroupcrud_repository.dart';

part 'jobgroupcrud_event.dart';
part 'jobgroupcrud_state.dart';

class JobGroupCrudBloc extends Bloc<JobGroupCrudEvents, JobGroupCrudState> {
	final JobGroupCrudRepository repository;
	JobGroupCrudBloc({required this.repository}) : super(const JobGroupCrudState()) {
		on<JobGroupCrudUbahEvent>(onUbahJobGroupCrud);
		on<JobGroupCrudTambahEvent>(onTambahJobGroupCrud);
		on<JobGroupCrudHapusEvent>(onHapusJobGroupCrud);
		on<JobGroupCrudLihatEvent>(onLihatJobGroupCrud);
	}

	Future<void> onTambahJobGroupCrud(
		JobGroupCrudTambahEvent event, Emitter<JobGroupCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.jobGroupCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahJobGroupCrud(
		JobGroupCrudUbahEvent event, Emitter<JobGroupCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.jobGroupCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusJobGroupCrud(
		JobGroupCrudHapusEvent event, Emitter<JobGroupCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.jobGroupCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatJobGroupCrud(
		JobGroupCrudLihatEvent event, Emitter<JobGroupCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		JobGroupCrudModel record = await repository.jobGroupCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}