import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/msttitle/titlecrud_model.dart';
import 'package:esalesapp/repositories/msttitle/titlecrud_repository.dart';

part 'titlecrud_event.dart';
part 'titlecrud_state.dart';

class TitleCrudBloc extends Bloc<TitleCrudEvents, TitleCrudState> {
	final TitleCrudRepository repository;
	TitleCrudBloc({required this.repository}) : super(const TitleCrudState()) {
		on<TitleCrudUbahEvent>(onUbahTitleCrud);
		on<TitleCrudTambahEvent>(onTambahTitleCrud);
		on<TitleCrudHapusEvent>(onHapusTitleCrud);
		on<TitleCrudLihatEvent>(onLihatTitleCrud);
	}

	Future<void> onTambahTitleCrud(
		TitleCrudTambahEvent event, Emitter<TitleCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.titleCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahTitleCrud(
		TitleCrudUbahEvent event, Emitter<TitleCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.titleCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusTitleCrud(
		TitleCrudHapusEvent event, Emitter<TitleCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.titleCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatTitleCrud(
		TitleCrudLihatEvent event, Emitter<TitleCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		TitleCrudModel record = await repository.titleCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}