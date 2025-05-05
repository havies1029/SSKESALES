import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/projecttree/treenodecrud_model.dart';
import 'package:esalesapp/repositories/projecttree/treenodecrud_repository.dart';

part 'treenodecrud_event.dart';
part 'treenodecrud_state.dart';

class TreenodeCrudBloc extends Bloc<TreenodeCrudEvents, TreenodeCrudState> {
	final TreenodeCrudRepository repository;
	TreenodeCrudBloc({required this.repository}) : super(const TreenodeCrudState()) {
		on<TreenodeCrudUbahEvent>(onUbahTreenodeCrud);
		on<TreenodeCrudTambahEvent>(onTambahTreenodeCrud);
		on<TreenodeCrudHapusEvent>(onHapusTreenodeCrud);
		on<TreenodeCrudLihatEvent>(onLihatTreenodeCrud);
	}

	Future<void> onTambahTreenodeCrud(
		TreenodeCrudTambahEvent event, Emitter<TreenodeCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.treenodeCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahTreenodeCrud(
		TreenodeCrudUbahEvent event, Emitter<TreenodeCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.treenodeCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusTreenodeCrud(
		TreenodeCrudHapusEvent event, Emitter<TreenodeCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.treenodeCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatTreenodeCrud(
		TreenodeCrudLihatEvent event, Emitter<TreenodeCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		TreenodeCrudModel record = await repository.treenodeCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}