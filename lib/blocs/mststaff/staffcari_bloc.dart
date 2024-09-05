import 'package:equatable/equatable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/mststaff/staffcari_model.dart';
import 'package:esalesapp/repositories/mststaff/staffcari_repository.dart';

part 'staffcari_event.dart';
part 'staffcari_state.dart';

class StaffCariBloc extends Bloc<StaffCariEvents, StaffCariState> {
	StaffCariBloc() : super(const StaffCariState()) {
		on<FetchStaffCariEvent>(onFetchStaffCari);
		on<RefreshStaffCariEvent>(onRefreshStaffCari);
		on<UbahStaffCariEvent>(onUbahStaffCari);
		on<TambahStaffCariEvent>(onTambahStaffCari);
		on<HapusStaffCariEvent>(onHapusStaffCari);
		on<CloseDialogStaffCariEvent>(onCloseDialogStaffCari);
	}

	Future<void> onRefreshStaffCari(
			RefreshStaffCariEvent event, Emitter<StaffCariState> emit) async {
		emit(const StaffCariState());

		//await Future.delayed(const Duration(seconds: 1));

		add(FetchStaffCariEvent(hal: 0, searchText: event.searchText));
	}

	Future<void> onFetchStaffCari(
			FetchStaffCariEvent event, Emitter<StaffCariState> emit) async {
		if (state.hasReachedMax) return;

		StaffCariRepository repo = StaffCariRepository();
		if (state.status == ListStatus.initial) {
			List<StaffCariModel> items = await repo.getStaffCari(event.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<StaffCariModel> items = await repo.getStaffCari(event.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<StaffCariModel> staffCari = List.of(state.items)..addAll(items);

			final result = staffCari
				.whereWithIndex((e, index) =>
					staffCari.indexWhere((e2) => e2.mstaffId == e.mstaffId) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusStaffCari(
		HapusStaffCariEvent event, Emitter<StaffCariState> emit) async {
		return emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogStaffCari(
		CloseDialogStaffCariEvent event, Emitter<StaffCariState> emit) async {
		return emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahStaffCari(
		TambahStaffCariEvent event, Emitter<StaffCariState> emit) async {
		return emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahStaffCari(
		UbahStaffCariEvent event, Emitter<StaffCariState> emit) async {
		return emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}