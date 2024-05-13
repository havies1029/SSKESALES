import 'package:equatable/equatable.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/combobox/combocob_model.dart';
import 'package:esalesapp/models/polis/poliscrud_model.dart';
import 'package:esalesapp/repositories/polis/poliscrud_repository.dart';

part 'poliscrud_event.dart';
part 'poliscrud_state.dart';

class PolisCrudBloc extends Bloc<PolisCrudEvents, PolisCrudState> {
	final PolisCrudRepository repository;
	PolisCrudBloc({required this.repository}) : super(const PolisCrudState()) {
		on<PolisCrudUbahEvent>(onUbahPolisCrud);
		on<PolisCrudTambahEvent>(onTambahPolisCrud);
		on<PolisCrudHapusEvent>(onHapusPolisCrud);
		on<PolisCrudLihatEvent>(onLihatPolisCrud);
		on<ComboCobChangedEvent>(onComboCobChanged);
		on<ComboCustomerChangedEvent>(onComboCustomerChanged);
	}

	Future<void> onTambahPolisCrud(
		PolisCrudTambahEvent event, Emitter<PolisCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.polisCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahPolisCrud(
		PolisCrudUbahEvent event, Emitter<PolisCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.polisCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusPolisCrud(
		PolisCrudHapusEvent event, Emitter<PolisCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.polisCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatPolisCrud(
		PolisCrudLihatEvent event, Emitter<PolisCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		PolisCrudModel record = await repository.polisCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onComboCobChanged(
			ComboCobChangedEvent event, Emitter<PolisCrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboCobModel comboCob = event.comboCob;
		PolisCrudModel rec = state.record!;
		rec.mcobId = comboCob.mcobId;
		rec.comboCob = comboCob;

		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			record: rec));
	}

	Future<void> onComboCustomerChanged(
			ComboCustomerChangedEvent event, Emitter<PolisCrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboCustomerModel comboCustomer = event.comboCustomer;
		PolisCrudModel rec = state.record!;
		rec.mrekanId = comboCustomer.mrekanId;
		rec.comboCustomer = comboCustomer;

		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			record: rec));
	}

}