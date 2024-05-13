import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/mststaff/staffcrud_model.dart';
import 'package:esalesapp/repositories/mststaff/staffcrud_repository.dart';

part 'staffcrud_event.dart';
part 'staffcrud_state.dart';

class StaffCrudBloc extends Bloc<StaffCrudEvents, StaffCrudState> {
	final StaffCrudRepository repository;
	StaffCrudBloc({required this.repository}) : super(const StaffCrudState()) {
		on<StaffCrudUbahEvent>(onUbahStaffCrud);
		on<StaffCrudTambahEvent>(onTambahStaffCrud);
		on<StaffCrudHapusEvent>(onHapusStaffCrud);
		on<StaffCrudLihatEvent>(onLihatStaffCrud);
	}

	Future<void> onTambahStaffCrud(
		StaffCrudTambahEvent event, Emitter<StaffCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.staffCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahStaffCrud(
		StaffCrudUbahEvent event, Emitter<StaffCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.staffCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusStaffCrud(
		StaffCrudHapusEvent event, Emitter<StaffCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.staffCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatStaffCrud(
		StaffCrudLihatEvent event, Emitter<StaffCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		StaffCrudModel record = await repository.staffCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}