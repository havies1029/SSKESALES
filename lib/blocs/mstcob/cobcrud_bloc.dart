import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/mstcob/cobcrud_model.dart';
import 'package:esalesapp/repositories/mstcob/cobcrud_repository.dart';

part 'cobcrud_event.dart';
part 'cobcrud_state.dart';

class CobCrudBloc extends Bloc<CobCrudEvents, CobCrudState> {
	final CobCrudRepository repository;
	CobCrudBloc({required this.repository}) : super(const CobCrudState()) {
		on<CobCrudUbahEvent>(onUbahCobCrud);
		on<CobCrudTambahEvent>(onTambahCobCrud);
		on<CobCrudHapusEvent>(onHapusCobCrud);
		on<CobCrudLihatEvent>(onLihatCobCrud);
	}

	Future<void> onTambahCobCrud(
		CobCrudTambahEvent event, Emitter<CobCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.cobCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahCobCrud(
		CobCrudUbahEvent event, Emitter<CobCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.cobCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusCobCrud(
		CobCrudHapusEvent event, Emitter<CobCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.cobCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatCobCrud(
		CobCrudLihatEvent event, Emitter<CobCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		CobCrudModel record = await repository.cobCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}