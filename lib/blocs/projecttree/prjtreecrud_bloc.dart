import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/models/combobox/combommstjobcat_model.dart';
import 'package:esalesapp/models/projecttree/prjtreecrud_model.dart';
import 'package:esalesapp/repositories/projecttree/prjtreecrud_repository.dart';

part 'prjtreecrud_event.dart';
part 'prjtreecrud_state.dart';

class PrjtreeCrudBloc extends Bloc<PrjtreeCrudEvents, PrjtreeCrudState> {
	final PrjtreeCrudRepository repository;
	PrjtreeCrudBloc({required this.repository}) : super(const PrjtreeCrudState()) {
		on<PrjtreeCrudUbahEvent>(onUbahPrjtreeCrud);
		on<PrjtreeCrudTambahEvent>(onTambahPrjtreeCrud);
		on<PrjtreeCrudHapusEvent>(onHapusPrjtreeCrud);
		on<PrjtreeCrudLihatEvent>(onLihatPrjtreeCrud);
		on<ComboCustomerChangedEvent>(onComboCustomerChanged);
		on<ComboMMstJobcatChangedEvent>(onComboMMstJobcatChanged);
	}

	Future<void> onTambahPrjtreeCrud(
		PrjtreeCrudTambahEvent event, Emitter<PrjtreeCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.prjtreeCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahPrjtreeCrud(
		PrjtreeCrudUbahEvent event, Emitter<PrjtreeCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.prjtreeCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusPrjtreeCrud(
		PrjtreeCrudHapusEvent event, Emitter<PrjtreeCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.prjtreeCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatPrjtreeCrud(
		PrjtreeCrudLihatEvent event, Emitter<PrjtreeCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		PrjtreeCrudModel record = await repository.prjtreeCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onComboCustomerChanged(
			ComboCustomerChangedEvent event, Emitter<PrjtreeCrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboCustomerModel comboCustomer = event.comboCustomer;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboCustomer: comboCustomer));
	}

	Future<void> onComboMMstJobcatChanged(
			ComboMMstJobcatChangedEvent event, Emitter<PrjtreeCrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboMMstJobcatModel comboMMstJobcat = event.comboMMstJobcat;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboMMstJobcat: comboMMstJobcat));
	}

}