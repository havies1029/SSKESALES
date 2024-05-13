import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/mstjabatan/jabatancrud_model.dart';
import 'package:esalesapp/repositories/mstjabatan/jabatancrud_repository.dart';

part 'jabatancrud_event.dart';
part 'jabatancrud_state.dart';

class JabatanCrudBloc extends Bloc<JabatanCrudEvents, JabatanCrudState> {
	final JabatanCrudRepository repository;
	JabatanCrudBloc({required this.repository}) : super(const JabatanCrudState()) {
		on<JabatanCrudUbahEvent>(onUbahJabatanCrud);
		on<JabatanCrudTambahEvent>(onTambahJabatanCrud);
		on<JabatanCrudHapusEvent>(onHapusJabatanCrud);
		on<JabatanCrudLihatEvent>(onLihatJabatanCrud);
	}

	Future<void> onTambahJabatanCrud(
		JabatanCrudTambahEvent event, Emitter<JabatanCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.jabatanCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahJabatanCrud(
		JabatanCrudUbahEvent event, Emitter<JabatanCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.jabatanCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusJabatanCrud(
		JabatanCrudHapusEvent event, Emitter<JabatanCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.jabatanCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatJabatanCrud(
		JabatanCrudLihatEvent event, Emitter<JabatanCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		JabatanCrudModel record = await repository.jabatanCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}