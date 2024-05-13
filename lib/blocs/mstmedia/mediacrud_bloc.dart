import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/mstmedia/mediacrud_model.dart';
import 'package:esalesapp/repositories/mstmedia/mediacrud_repository.dart';

part 'mediacrud_event.dart';
part 'mediacrud_state.dart';

class MediaCrudBloc extends Bloc<MediaCrudEvents, MediaCrudState> {
	final MediaCrudRepository repository;
	MediaCrudBloc({required this.repository}) : super(const MediaCrudState()) {
		on<MediaCrudUbahEvent>(onUbahMediaCrud);
		on<MediaCrudTambahEvent>(onTambahMediaCrud);
		on<MediaCrudHapusEvent>(onHapusMediaCrud);
		on<MediaCrudLihatEvent>(onLihatMediaCrud);
	}

	Future<void> onTambahMediaCrud(
		MediaCrudTambahEvent event, Emitter<MediaCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.mediaCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahMediaCrud(
		MediaCrudUbahEvent event, Emitter<MediaCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.mediaCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusMediaCrud(
		MediaCrudHapusEvent event, Emitter<MediaCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.mediaCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatMediaCrud(
		MediaCrudLihatEvent event, Emitter<MediaCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		MediaCrudModel record = await repository.mediaCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}