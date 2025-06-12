import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/todo/companylist_model.dart';
import 'package:esalesapp/repositories/todo/companylist_repository.dart';

part 'companylist_event.dart';
part 'companylist_state.dart';

class CompanyListBloc extends Bloc<CompanyListEvents, CompanyListState> {
	CompanyListBloc() : super(const CompanyListState()) {
		on<FetchCompanyListEvent>(onFetchCompanyList);
		on<RefreshCompanyListEvent>(onRefreshCompanyList);
		on<UbahCompanyListEvent>(onUbahCompanyList);
		on<TambahCompanyListEvent>(onTambahCompanyList);
		on<HapusCompanyListEvent>(onHapusCompanyList);
		on<CloseDialogCompanyListEvent>(onCloseDialogCompanyList);
	}

	Future<void> onRefreshCompanyList(
			RefreshCompanyListEvent event, Emitter<CompanyListState> emit) async {
		emit(const CompanyListState());

		emit(state.copyWith(timeline1Id: event.timeline1Id));
		add(FetchCompanyListEvent());
	}

	Future<void> onFetchCompanyList(
			FetchCompanyListEvent event, Emitter<CompanyListState> emit) async {
		if (state.hasReachedMax) return;

		CompanyListRepository repo = CompanyListRepository();
		if (state.status == ListStatus.initial) {
			List<CompanyListModel> items = await repo.getCompanyList(state.timeline1Id, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<CompanyListModel> items = await repo.getCompanyList(state.timeline1Id, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<CompanyListModel> companyList = List.of(state.items)..addAll(items);

			final result = companyList
				.whereWithIndex((e, index) =>
					companyList.indexWhere((e2) => e2.timeline2Id == e.timeline2Id) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusCompanyList(
		HapusCompanyListEvent event, Emitter<CompanyListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogCompanyList(
		CloseDialogCompanyListEvent event, Emitter<CompanyListState> emit) async {
		emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahCompanyList(
		TambahCompanyListEvent event, Emitter<CompanyListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahCompanyList(
		UbahCompanyListEvent event, Emitter<CompanyListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}