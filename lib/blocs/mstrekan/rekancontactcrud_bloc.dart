import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/combobox/comboinsurer_model.dart';
import 'package:esalesapp/models/mstrekan/rekancontactcrud_model.dart';
import 'package:esalesapp/repositories/mstrekan/rekancontactcrud_repository.dart';

part 'rekancontactcrud_event.dart';
part 'rekancontactcrud_state.dart';

class RekanContactCrudBloc extends Bloc<RekanContactCrudEvents, RekanContactCrudState> {
	final RekanContactCrudRepository repository;
	RekanContactCrudBloc({required this.repository}) : super(const RekanContactCrudState()) {
		on<RekanContactCrudUbahEvent>(onUbahRekanContactCrud);
		on<RekanContactCrudTambahEvent>(onTambahRekanContactCrud);
		on<RekanContactCrudHapusEvent>(onHapusRekanContactCrud);
		on<RekanContactCrudLihatEvent>(onLihatRekanContactCrud);
	}

	Future<void> onTambahRekanContactCrud(
		RekanContactCrudTambahEvent event, Emitter<RekanContactCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.rekanContactCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahRekanContactCrud(
		RekanContactCrudUbahEvent event, Emitter<RekanContactCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.rekanContactCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusRekanContactCrud(
		RekanContactCrudHapusEvent event, Emitter<RekanContactCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.rekanContactCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatRekanContactCrud(
		RekanContactCrudLihatEvent event, Emitter<RekanContactCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		RekanContactCrudModel record = await repository.rekanContactCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}


}