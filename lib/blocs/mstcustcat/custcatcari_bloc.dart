import 'package:equatable/equatable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/mstcustcat/custcatcari_model.dart';
import 'package:esalesapp/repositories/mstcustcat/custcatcari_repository.dart';

part 'custcatcari_event.dart';
part 'custcatcari_state.dart';

class CustCatCariBloc extends Bloc<CustCatCariEvents, CustCatCariState> {
	CustCatCariBloc() : super(const CustCatCariState()) {
		on<FetchCustCatCariEvent>(onFetchCustCatCari);
		on<RefreshCustCatCariEvent>(onRefreshCustCatCari);
		on<UbahCustCatCariEvent>(onUbahCustCatCari);
		on<TambahCustCatCariEvent>(onTambahCustCatCari);
		on<HapusCustCatCariEvent>(onHapusCustCatCari);
		on<CloseDialogCustCatCariEvent>(onCloseDialogCustCatCari);
	}

	Future<void> onRefreshCustCatCari(
			RefreshCustCatCariEvent event, Emitter<CustCatCariState> emit) async {
		emit(const CustCatCariState());

		//await Future.delayed(const Duration(seconds: 1));

		add(FetchCustCatCariEvent(hal: 0, searchText: event.searchText));
	}

	Future<void> onFetchCustCatCari(
			FetchCustCatCariEvent event, Emitter<CustCatCariState> emit) async {
		if (state.hasReachedMax) return;

		CustCatCariRepository repo = CustCatCariRepository();
		if (state.status == ListStatus.initial) {
			List<CustCatCariModel> items = await repo.getCustCatCari(event.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<CustCatCariModel> items = await repo.getCustCatCari(event.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<CustCatCariModel> custCatCari = List.of(state.items)..addAll(items);

			final result = custCatCari
				.whereWithIndex((e, index) =>
					custCatCari.indexWhere((e2) => e2.mcustcatId == e.mcustcatId) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusCustCatCari(
		HapusCustCatCariEvent event, Emitter<CustCatCariState> emit) async {
		return emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogCustCatCari(
		CloseDialogCustCatCariEvent event, Emitter<CustCatCariState> emit) async {
		return emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahCustCatCari(
		TambahCustCatCariEvent event, Emitter<CustCatCariState> emit) async {
		return emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahCustCatCari(
		UbahCustCatCariEvent event, Emitter<CustCatCariState> emit) async {
		return emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}