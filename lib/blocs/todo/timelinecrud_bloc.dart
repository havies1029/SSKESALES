import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/todo/timelinecrud_model.dart';
import 'package:esalesapp/repositories/todo/timelinecrud_repository.dart';

part 'timelinecrud_event.dart';
part 'timelinecrud_state.dart';

class TimelineCrudBloc extends Bloc<TimelineCrudEvents, TimelineCrudState> {
	final TimelineCrudRepository repository;
	TimelineCrudBloc({required this.repository}) : super(const TimelineCrudState()) {
		on<TimelineCrudUbahEvent>(onUbahTimelineCrud);
		on<TimelineCrudTambahEvent>(onTambahTimelineCrud);
		on<TimelineCrudHapusEvent>(onHapusTimelineCrud);
		on<TimelineCrudLihatEvent>(onLihatTimelineCrud);
	}

	Future<void> onTambahTimelineCrud(
		TimelineCrudTambahEvent event, Emitter<TimelineCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.timelineCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahTimelineCrud(
		TimelineCrudUbahEvent event, Emitter<TimelineCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.timelineCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusTimelineCrud(
		TimelineCrudHapusEvent event, Emitter<TimelineCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.timelineCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatTimelineCrud(
		TimelineCrudLihatEvent event, Emitter<TimelineCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		TimelineCrudModel record = await repository.timelineCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}