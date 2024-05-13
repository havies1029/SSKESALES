import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/mstcustcat/custcatcrud_model.dart';
import 'package:esalesapp/repositories/mstcustcat/custcatcrud_repository.dart';

part 'custcatcrud_event.dart';
part 'custcatcrud_state.dart';

class CustCatCrudBloc extends Bloc<CustCatCrudEvents, CustCatCrudState> {
	final CustCatCrudRepository repository;
	CustCatCrudBloc({required this.repository}) : super(const CustCatCrudState()) {
		on<CustCatCrudUbahEvent>(onUbahCustCatCrud);
		on<CustCatCrudTambahEvent>(onTambahCustCatCrud);
		on<CustCatCrudHapusEvent>(onHapusCustCatCrud);
		on<CustCatCrudLihatEvent>(onLihatCustCatCrud);
	}

	Future<void> onTambahCustCatCrud(
		CustCatCrudTambahEvent event, Emitter<CustCatCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.custCatCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahCustCatCrud(
		CustCatCrudUbahEvent event, Emitter<CustCatCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.custCatCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusCustCatCrud(
		CustCatCrudHapusEvent event, Emitter<CustCatCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.custCatCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatCustCatCrud(
		CustCatCrudLihatEvent event, Emitter<CustCatCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		CustCatCrudModel record = await repository.custCatCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}